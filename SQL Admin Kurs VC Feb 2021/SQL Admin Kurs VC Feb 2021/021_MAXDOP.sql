set statistics io, time on
--io Anzahl der Seiten
--time in ms die CPU Zeit und die gesamte Dauer
--in dieser Sitzung läuft die Messung bis wir Set.. off schalten oder die verbindung beeenden
--Miß nie einfach mal.. auf Dauer

select companyname, sum(unitprice+quantity) from ku
group by companyname


--Messung
/*
Analyse und Komp zeit: beim ersten mal etwas höher.. beim 2ten mal sollte sie 0 sein
 logische Lesevorgänge: Anzahl der Seiten von HDD oder von RAM
 CPU Zeit in ms
 Dauer gesamt in ms

 --mit einer CPU:  CPU-Zeit = 1344 ms, verstrichene Zeit = 1341 ms.
 --mit 4 CPUs 1248 ms, verstrichene Zeit = 313 ms.
 --8 CPUS:, CPU-Zeit = 2282 ms, verstrichene Zeit = 326 ms.
 --Kosten ca 33,5 SQL Dollar
 --Wenn CPU zeit mehr als Dauer... dan müssen mehr CPUs daran gearbeitet haben

 --fazit: wir kommen mit 4 CPU deutlich besser weg als mit 8 oder 6 CPUs...

 --Der kostenschwellwert von 5 ist bescheuert.. viel zu niederig
 ----bestimmt, dass SQL Server entder 1 CPU oder gleich alle (=Wert bei MAXDOP) einsetzt

 --best practice: Kostenschwellwert höher: 25 OLTP / 50 (DW).. man darf hier gerne rumprobieren
 --der MAXDOP (Anzahl der CPUs) auf max 8 setzten und gerne mal mit 50% der kerne probieren



 --MAXDOP.. regelt die Anzahl der CPUs pro Abfrage
 ---default: bis SQL 2017: 0 = Alle
 --default: Kostenschwellwert (ab wieviel SQL Dollar verwendet SQL mehr als 1 CPU)
			5

			--erst SQL 2019 schlägt im Setup vor die CPUs auf max 8 zu drosseln


--man kann auch MAXDOP pro DB einstellen (ab SQL 2016) und daher unabhängig vom Server arbeiten
--es zählt dann das der DB
*/

--Auch bei Abfrage möglich.. dann zählt der Wert bei der Abfrage
select companyname, sum(unitprice+quantity) from ku 
group by companyname option (maxdop 4)


USE [Northwind]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

 --Symobol mit 2 Pfeilen


 --kann ich nach paral.. fragen?

 select * from sys.dm_os_wait_stats where wait_type like 'CX%'

 --Idee.. CPU sparen.. die man für anderes evtl mal braucht..


*/