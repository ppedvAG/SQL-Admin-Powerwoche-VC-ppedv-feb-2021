/*


Login: Betreten des SQL Servers
User: Rechte in einer DB

Login und User sind zwei getrennt zu betrachtende Dinge

Innerhalb der DB:

Schema entspricht Ordner
Rollen entspricht Gruppen


Auf Schemas können Rechte vergeben werden wie etwa Select 
damit kann der Benutzer alles Lesen , was innerhalb des Schemas liegt
*/
USE [Kurs2014DB]
GO
CREATE SCHEMA [HR] AUTHORIZATION [DB]
GO
use [Kurs2014DB]
GO
GRANT SELECT ON SCHEMA::[HR] TO [Max]
GO

/*
natürlich kann auch auf ein einzelnes Objekt ein recht gesetzt werden
*/
use [Kurs2014DB]
GO
GRANT SELECT ON [IT].[kst] TO [Max]
GO

/*

Objekte anzulegen bedarf mehrere Rechte:

Recht auf DB: wie tabelle erstellen
und
Recht im Schema das recht ausüben zu dürfen.. wie ALTER
*/

use [Kurs2014DB]
GO
GRANT CREATE VIEW TO [Peter]
GO

use [Kurs2014DB]
GO
GRANT ALTER ON SCHEMA::[IT] TO [Peter]
GO



/*
Günstigerweise arbeitet man besser mit Rollen
damit wird die Verwatung deutlich einfacher..

Rechte werden dann auf Rollen vergeben, anstatt auf user

*/

USE [Kurs2014DB]
GO
CREATE ROLE [HRRolle] AUTHORIZATION [dbo]
GO
USE [Kurs2014DB]
GO
ALTER ROLE [HRRolle] ADD MEMBER [Peter]
GO


/*Serverrollen
eigenen sich dazu best Personen Administrationsrechte zu geben...

entweder verwendet man die vorgegebenen Serverrollen
oder man macht eig. Der Vorteil von selbsterstellten Serverrollen ist der, dass man die Rechte einzelen 
konfigurieren kann und nicht gleich zB alle Sicherheitsrechte bekommt..

*/

USE [master]
GO

/****** Object:  ServerRole [KursDBSecurityRolle]    Script Date: 24.02.2021 10:56:54 ******/
CREATE SERVER ROLE [KursDBSecurityRolle]
GO

ALTER SERVER ROLE [KursDBSecurityRolle] ADD MEMBER [Max]

GO

use [master]

GO

GRANT ALTER ON LOGIN::[Peter] TO [KursDBSecurityRolle]

GO


/*

Besitzverkettung

Sichten?
max darf unter it.* lesen

Sichten verhalten sich doch wie Tabellen....

*/

select * from it.kst --darf Max

select * from ma.mitarbeiter --darf max nicht

--max macht folgendes.. die rechte dazu het er bekommen

create view it.mamit
as
select * from ma.mitarbeiter
GO


select * from it.mamit
--klappt


--Nur bei Besitzverkettung funktioniert das,
--dass ein Benutzer Daten lesen kann obwohl er 
--keine rechte auf eigtl Objekt besitzt

--Das ist durchaus sehr nützlich, da man sonst alle Verweise untersuchen

--dbo  dbo    dbo   dbo dbo   dbo
--V5-->v4--->v3-->v2---V1--->T

--SQL Server kontrolliert nur das aufgerufene Objekt
--Aber gebe nie einem User das 
--Recht Sichten, 
--Prozeduren oder 
--Funktionen anlegen zu dürfen

