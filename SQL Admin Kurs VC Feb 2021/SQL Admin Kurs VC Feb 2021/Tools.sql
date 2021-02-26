/*

Datensammlung
1. Datawarehouse erstellen
2. Datensammlersatz aktivieren


3. Rechte auf Cacheverzeichnis vergeben.. Auftrag kontrllieren.. wer macht die Aufträge


Berichte (Eigenschaften .. Datensammlersatz... Server/Abfrage/Datenträger)

benötigt rel viel Platz und Ressourcen




Richtlinien



Profiler ist depricated

stattdessen Xevents.. kann aber den Profiler nicht ersetzen, ist aber teilweise besser

effektiver!
ns messbar
Aggregate


bis SQL 2008 keine Oberfläche
ab SQL 2012 gibts Oberfläche



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

