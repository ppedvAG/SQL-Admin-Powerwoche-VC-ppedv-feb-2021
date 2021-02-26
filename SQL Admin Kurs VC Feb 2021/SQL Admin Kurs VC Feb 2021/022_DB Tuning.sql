/*
DB besteht aus wieviele Dateien

mdf Daten
ldf Log

eine DB kann auch mehrere Datendateien besitzen
und somit kann man Daten trennen nach prinzip: Lesen und Schreiben

möglich:
- eine Tabelle auf einen andereren Datenträger
- eine Tabelle auf mehrere Dträger u verteilen

je mehr HDDs desto schneller

jede weitere Datei bekommt die Endung ndf 




1: Dateigruppen

*/

ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'Nwindhotdata', FILENAME = N'D:\_SQLDB\Nwindhotdata.ndf' , SIZE = 102400KB , FILEGROWTH = 65536KB ) TO FILEGROUP [HOT]
GO


--Einsatz.. neue Tabelle
create table messdaten (id int) on HOT


--wie kann man best. tabellen von PRIMARY(mdf) auf HOT schieben.. ?
--Es gibt keine SQL Syntax..

--Über die Entwurffsansicht der tabelle, kann man tabellen von Dgruppe A auf Dgruppe B schieben..
--aber es ist mit einem Löschen der tabvelle verbunden
--das SSMS verbiete das, kann aber deaktviert werden

--Extra..Optionen..Designer- haken entfernen bei Löschen von Änderung verhinden...
--Tipp: Haken nur kurz! entfernen

--2. tabelle auf mehrere HDDs verteilen

--Salamitaktik

--> Tabellen werden immer größer

-- TABA (10000 Zeilen)   TABB (100000 Zeilen)
--Abfrage auf A und B gestellt wird
--es kommen von A und B jeweils 10 Zeilen zurück

--aus großen tabellen kleine machen...

----> FALL 1: UMSATZ viele kleine Tabelle: u2020 u2021 u2019
      -- Software braucht aber Tabelle UMSATZ---> UNION


create table u2021 (id int, jahr int, spx int)
create table u2020 (id int, jahr int, spx int)
create table u2019 (id int, jahr int, spx int)
create table u2018 (id int, jahr int, spx int)


--Sicht
create view Umsatz
as
select * from u2021
UNION ALL ---keine Suche nach doppelten
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2018


--Was macht SQL Server
select * from umsatz --alle tabellen

select * from umsatz where Jahr = 2020 --macht genau dassselbe.. alle tabellen
--Es muss ein Garantiesiegel geben, dass in u2020 zb nur Daten von Jahr=2020 befinden

--CHECK CONSTRAINT
--für alle tabellen...
vALTER TABLE dbo.u2018 ADD CONSTRAINT
	CK_u2018 CHECK (jahr=2018)

select * from umsatz where Jahr = 2020


select * from umsatz where ID = 2020

--Nachteil: extrem kompliziert zum Warten
--geht INS UP und DEL.. ja geht, aber nur wenn
-- die ID Spalte darf kein Identity (Hochzähler)
-- PK auf die Spalten ID und Jahr, weil jeder über sicht hinweg Eindeutig werden
----==> Anwendung geht nicht mehr
--Wann kann ich das nehem: bei Archivdaten
--partitionierte Sicht


--Gibst was besseres? .. Ja.. die partitionierung

USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nw100', FILENAME = N'D:\_SQLDB\nw100.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nw200', FILENAME = N'D:\_SQLDB\nw200.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nw5000', FILENAME = N'D:\_SQLDB\nw5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwrest', FILENAME = N'D:\_SQLDB\nwrest.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [rest]
GO



--Zuerst F() zur Verteilung der Daten

------------------100---------200----------------------------------

create partition function fzahl(int)
as
RANGE LEFT FOR VALUES(100,200)

select $partition.fzahl(117) --> 2


--dann das schema
create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
--------              1       2    3  Reihenfolge entscheidet über Ort der Daten



create table ptab (id int identity, nummer int, spx char(4100)) ON schZahl(nummer)
----------------                                             auf Schema legen und Spalte angeben

set statistics io, time off-- und Plan ausschalten: ACHTUNG SCHLEIFE

declare @i as int=1

while @i<=20000
	Begin
		insert into ptab(nummer, spx) values(@i,'XYZ')
		set @i+=1
	end

--was ist nun besser?
set statistics time, io on
select * from ptab where id = 117 --ca 15ms und 20000 Seiten

select * from ptab where nummer = 117 --schneller .. kaum ms 100 Seiten


--Manipulieren

---Neue Grenze
select * from ptab where nummer = 1117 --teuer

-----100-----200-------------------5000------------------------------
--1         2            3                    4

--ptab, f(), schema

--zuerst schema anpassen, dann f()

--neue DGruppe zuweisen: 0ms
alter partition scheme schZahl next used bis5000


select $partition.fzahl(nummer), min(nummer), max(nummer), count(*) from ptab
group by $partition.fzahl(nummer)

alter partition function fzahl() split range (5000)
--jetzt wurden die Daten physikalisch verschoben


--Grenze entfernen: 100
--ptab nie, nur f(), schema muss nur genug Dgruppen habe

alter partition function fzahl() merge range(100)


select * from ptab where nummer = 117


































select 100
union doppelte zeilen werden gefiltert
select 100














