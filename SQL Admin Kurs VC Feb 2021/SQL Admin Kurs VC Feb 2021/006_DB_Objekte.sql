/*
Tabellen
..Datentyen...usw


Sichten (Views)
"eine gemerkte Abfrage"


create view vBest1997
as
select * from orders where year(orderdate)=1997


select * from vBest1997
--das gleiche wie

select * from (select * from orders where year(Orderdate)=1997) v

Eine Sicht ist eine gemerkte Abfrage und enthält keine Daten
Verhält sich aber wie eine Tabelle
	--INS UP DEL evtl möglich
	--Rechte auf die Sicht vergeben
	Sichten enthalten nur eine! Abfrage

Einsatzzweck von Sichten
Vereinfachung , weil man große Statements evtl vermeiden 
Wegen Security

use northwind
select * from kundeumsatz


Prozeduren stored procedures

create procedure gpKundeUmsatz @Jahr int
as
select * from orders where year(orderdate)=@Jahr


exec gpKundeUmsatz 1996

--Prozeduren können parametrisiert werden
--und jede menge Code enthalten, auch INS UP und DEL mischbar



Funktionen
..sind universell einsetzbar: als Spalte, als "Tabelle", auch im Where

create function fnBrutto (@netto money) returns money
as
Begin
	return (select @netto*1.19)
end

select dbo.fnBrutto(100)

select dbo.fnBrutto(Freight), freight from orders



Hitliste - was ist besser
--------------------------------
1) ad hoc .. select 
2) Prozedur
3) Sicht
4) F()

		Select  f()  Sicht				proz

--Prozedur     SELECT|SICHT              F()
--schnell-------------------------------langsam--->



*/