/*
hast du schon mal Windows beobachtet?
--Task Manager
--> Ressourcemonitor
--klautirgendein anderer Prozess die ressourcen, die der SQL braucht
--Antivirentool... 
--Trojaner, Viren, 


Aktivitätsmonitor

aktive Verbindungen
Wer auf welcher DB m it welcher Software
RUnning
Supsended
Runnable


teuersten Abfrage der letzten Zeit
MB/sek pro DB Datei
die Wartezeit der letzten Sekunde kategorisiert


Systemsichten: DMV Data management Views

select * from sys.dm_os_wait_stats

Was aber we, wenn das Probem in der nacht war...??


*/
select * from sys.dm_os_wait_stats


/*

Abfrage-->SQL-->QUEUE--->Worker (welche ressource braauche ich denn?---> Logfile!)

|-------------------50ms------70ms|

70ms gesamte Wartezeit ..wait_time_ms
50ms auf Logfile gewartet  wait_time_ms-signal_wait_time_ms
20ms auf CPU gewartet  ...signal_wait_time_ms

Die ms sind hier kummuliererend seit Neustart.. also sagen mir die Zeiten zunächst nichts

---Worauf muss ich warten....?


Idee1: ich messe alle 60 Sekunden und beobachte die messwertunterschiede
		--> Tool: Datensammler : Serveraktivität

IDEE2. sortiere nach Dauer

select * from sys.dm_os_wait_stats order by wait_time_ms desc

? Sleep Task.. Queue..Lazy-- gleich ignorieren

Idee3: ich summiere alle Wartezeiten=100%
Wieviel % ist nun zb der SOS_Work_Dispatcher.. sind das nun 3% oder 80%


Regel: die Signalzeit sollte immer 25% oder weniger der gesamten Wartezeit sein

Ideal wäre:

Liste mit top 10 Waittypes    Anteil an gesamter Wartezeit   anteil an CPU Zeit


*/


/*
Aufzeichnung von Messwerten

*/

CREATE EVENT SESSION [Demo] ON SERVER 
ADD EVENT sqlserver.sp_statement_completed(SET collect_statement=(1)
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'''northwind'''))),
ADD EVENT sqlserver.sql_batch_completed
ADD TARGET package0.event_file(SET filename=N'D:\_BACKUP\demo.xel'),
ADD TARGET package0.histogram(SET source=N'sqlserver.sql_text')
WITH (STARTUP_STATE=OFF)
GO

