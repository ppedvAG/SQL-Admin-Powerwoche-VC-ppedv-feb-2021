/*
SETUP

Sicherheit: wie kann man sich authentifizierien?
reine Windows Auth ..sicherer
Windows und SQL Auth (gemischte)
		SA (alle rechte) ..komplexes Kennwort 


Dienstkonten:
	Datenbankmodul:
	Agent:

nie !....Lokal System

Dom User: braucht keine besonderen Rechte

NT Service\SQLSERVER.. verwaltetes Dienstkonto... Bei Netzwerkzugriffe wird muss 
das Computerkonto verwendet werden


PCSQL (NT Service\SQLSERVER) ----- > \\BACKUP\SQL (PCSQL)
       (svcAgent)                                  svcAgent
 Falls man das Dienstkonto �ndern  m�chte, dann im SQL Server Konfigurationsmanager


Pfaden f�r Datenbankdateien
Trenne Log von Daten physikalisch

Wieviele und welche hat einen DB:
..mdf
..ldf



seit SQL 2016 kommen auch Fragen nach Tempdb, Arbeitsspeicher und MAXDOP
Anzahl der DatenDateien f�r Tempdb=Anzahl der Kerne , aber nicht mehr wie 8



Kontrolliere den SQL : hv-sql1 nach folgenden kritrien

DB Dateienpfade: kein Standardpfad
--�ndert man den Standardpfad, dann git das erst nach dem Neustart des SQL Servers f�r 
neue DBs

Anzahl der Dateien f�r tempdb
Anzahl der CPUS: 8

Max: 2,1 PB.. SQL verwendet im schlimmsten Fall den kompletten RAM, so dass f�r das OS
	nichts mehr �brig bleibt
MIn Arbeitsspeicher: 0
MAX RAM  Gesamter RAM - OS (gut 2GB mindestens)

TEMPDB..2 Datendateien und ein Logfile, aber 8 Kerne
die Datendateien der tempdb sollten alle gleich gro� sein..




----------------------------------DB------------------------------------
auch eine DB hat Einstellungen: Initialgr��e
2012:  3MB Daten + 2 MB Log  Wachstumrate: 1MB Daten und 10% Logfile
2014: 5MB Daten + 2MB Log
2016: 8MB  + 8MB Log  Wachstumrate: 64MB  Daten und Log

Anfangsgr��e deutlich gr��er w�hlen: Wie lange lebt der Server..4 Jahre..
wie gro� ist die DB vermutlich in 3 bis 4 Jahren...



Logfile eher 1 GB Wachstumsrate
Datendatei eher auch 500 bis 1 GB

Wo kann man den "Inhalt" kontrollieren? --> Berichte --> datentr�gerverwendung
--Eigenschaften der DB.. Dateien: neue Gr��e eingeben


DBDesign:
Erstelle ein Diagramm mit allen wichtigen Tabellen
Kontrollieren ob Datentypen ok sind
Ob PK vorhanden sind und ob Referenzen vprhanden sind
--denn diese sorgen daf�r, dass IDs immer aufl�sbar sein

Beachte immer, dass die Seiten gut gef�llt sind, denn die Anzahl der Seiten die pro Abfrage gebraucht werden
kommen 1:1 in RAM

Weniger Seiten --> weniger IO --> weniger RAM --> weniger CPU




300 DB auf einen alten SQL Server

neuen SQL...

--wie lange lebt der neue Server so wie er ist: 3 Jahre

alle DB brauchen in Summe ca 400 TB in 3 jahren

HDD Umgebung hatte nur 300





*/

