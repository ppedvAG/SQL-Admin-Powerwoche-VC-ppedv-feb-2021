/*
Indizes sind Performance Katalysatoren
..machen schnell aber auch langsam

sind u.a verantwortlich für Sperrniveu (ohne INdex wird gesamte tabelle gesperrt, 
	mit IX evtl nur die betroffene Zeile)

	Je besser der IX , desto geringer CPU und RAM Auslastung
	und ebenso geringerer IO Verbrauch

Merke: Steht im PLAN ein SCAN, dann bedeutet das eine Suche von A bis Z
	findet man einen SEEK ist das ein zielgerichtetes Finden (herauspicken)

	Look ist ein Nachschlagevorgang (vgl telefonbuch... Anruf)
		sollte vermieden werden

Was ist besser:

Table SCAN oder Nicht gr IX SCAN --- N Gr IX SCAN .. ist weniger
IX SEEK vs IX SCAN.. SEEK!


CLustered IX gibt es nur einmal sollte für Spalten verwendet werden, die häufig 
Bereichssuchen haben (Bestelldatum zb)

N CL IX gut bei eindeutigen Werten

!!!! PK häufig CL IX.. aber warum.. oft eine Verschwendung des CL IX auf eine
eindeutig Spalte


Arten:

Gruppierten INDEX  (clustered)
NICHT gruppierten INDEX  (non clustered)
------------------------------------------
eindeutiger IX.. Spalten im INDEX dürfen nur einmal vorkommen
zusammengesetzter IX.. besteht aus mehr Spalten (max 16 Spalten)
IX mit einegschlossenen Spalten

	in den IX Schlüsselspalten kommt immer das Where rein  (BAUM)
	in den Spalten enthalten kommen alle Spalten des SELECT rein (am Ende des Baumes)



nGr IX.. ist eine Kopie von Daten in sort Reihenfolge
kann es pro tabelle ca 1000 mal geben
je weniger treffer desto besser: Suchen nach ID/PK

grIX ist die Tabelle in sort Reihenfolge
wie oft gibt es einen gr IX pro tabelle: 1mal
gut bei: wenigern Werten, aber auch bei Abfragen nach Bereiczen (auch gern mit mehr Resultaten)

entschiedend: where




*/

select * from Customers

insert into customers (customerid, companyname) values ('ppedv', 'ppedv AG')

--KU Tabelle mit 2 MIO Zeilen 
select top 1 * from ku

select * into ku2 from ku

alter table ku2 add id int identity

select id from ku2 where id = 100

set statistics io, time on

--kompletter Table SCAN

--NIX_ID

select id from ku2 where id = 100 --Seiten: 3 ...0ms

select id, freight from ku2 where id =100---Seiten : 4
select id, freight from ku2 where id < 12000 -- Table Scan -- ab knapp 1%

select id,freight from ku2 where freight = 0.02 --IX SCAN.. aber besser als TAB SCAN

--NIX_ID_inkl_CIFR--IX mit eingeschl Spalten
select id,freight, city, country from ku2 where id = 100 -- reiner IX Seek
select id,freight, city  from ku2 where id = 100 --IX SEEK aber mit LOOKUP



--	in den IX Schlüsselspalten kommt immer das Where rein  (BAUM)
--	in den Spalten enthalten kommen alle Spalten des SELECT rein (am Ende des Baumes)
select companyname, sum(unitprice*quantity) from ku2
where country = 'UK' and freight = 0.02
group by companyname



CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210225-163256] ON [dbo].[ku2]
(
	[Country] ASC,
	[Freight] ASC
)
INCLUDE([CompanyName],[UnitPrice],[Quantity]) 
GO

CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[ku2] ([Country],[Freight])
INCLUDE ([CompanyName],[UnitPrice],[Quantity])


set statistics io, time on

select country, city, sum(freight) from 
ku2
where productid = 1 
		and 
	 orderid between 10270 and 10290
Group by country, city

--56642 --> RAM 
--CPU-Zeit = 376 ms, verstrichene Zeit = 70 ms.

--TABLE SCAN.. das schlechteste..!--> SEEK.. am besten ohne Lookup (Anruf)

--NGR IX: 
--Indexschlüsselspalten müssen die where Spalten
--alle Spalten des SELECT in Spalten enthalten.. 

--nach Index: 222 Seiten und ca knapp 0 ms

--IX SCAN.. und kein Hinweis ausf fehl IX
--ab einem OR im Statement schlägt der SQL Server keine IND mehr vor
--also manuell nach den gleichen Kriterien

select country, city, sum(freight) from 
ku2
where productid = 1 
		OR 
	orderid between 10270 and 10290
Group by country, city









