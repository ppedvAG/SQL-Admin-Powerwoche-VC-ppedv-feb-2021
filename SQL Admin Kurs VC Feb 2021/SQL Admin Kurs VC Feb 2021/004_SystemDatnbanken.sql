/*
model
Vorlage f�r neue DB
create database.. (Kopie der model)
Backup:nur bei �nderungen


master
Herz
Konfiguration
Datenbanken
Login
Backup: bei jeder �nderung


tempdb
temp Tabellen (#tabelle, ##tabelle)
Zeilenversionierung (kopien von Datens�tzen in die tempdb)
bei zu geringen RAM, kann hier ausgelagert
--es sind nur temp Fragmente 
Backup: nie



msdb
DB f�r den Agent
Jobs, Auftr�ge, Mailsystem, Zeitpl�ne
Wartungspl�ne, IntegrationServices Pakete
Verlauf der Jobs
Backup: bei jeder �nderungen
bei Verlust. zwar kein Datenverust, aber jede Menge Arbeit


Wartungpl�ne


*/