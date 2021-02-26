/*
model
Vorlage für neue DB
create database.. (Kopie der model)
Backup:nur bei Änderungen


master
Herz
Konfiguration
Datenbanken
Login
Backup: bei jeder Änderung


tempdb
temp Tabellen (#tabelle, ##tabelle)
Zeilenversionierung (kopien von Datensätzen in die tempdb)
bei zu geringen RAM, kann hier ausgelagert
--es sind nur temp Fragmente 
Backup: nie



msdb
DB für den Agent
Jobs, Aufträge, Mailsystem, Zeitpläne
Wartungspläne, IntegrationServices Pakete
Verlauf der Jobs
Backup: bei jeder Änderungen
bei Verlust. zwar kein Datenverust, aber jede Menge Arbeit


Wartungpläne


*/