DECLARE @command varchar(1000) 
SELECT @command = 'USE ?  CREATE USER [EVA] FOR LOGIN [EVA]
				 ALTER ROLE [db_backupoperator] ADD MEMBER [EVA]' 
EXEC sp_MSforeachdb @command 



USE [whoamiDB]
GO
CREATE USER [EVA] FOR LOGIN [EVA]
ALTER ROLE [db_backupoperator] ADD MEMBER [EVA]
GO


--Für Restore noch dbcreator Serverrolle