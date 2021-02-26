/*
Mehrere Instanzen m�glich... je nach SQL Server 64 oder 24...
Grund: aus Kompabilit�tsgrunden zu einer Software
			SQL 2019 und SQL 2014 gemischt auf einem Rechner

		aus Sicherheitsgr�nden
			ein SQL Admin aus INST1 darf nicht auf Instanz2 zugreifen

	aus Peformancegr�nden macht eine weier Instanz so gut wie nie Sinn
		Ausnahme: eine Instanz verlangt komplett andere Hardwaresettings

Tipp: SQL wird durch eine weitere Inst nie schneller...

Installation in Stichpunkten

Dienstkonten:
NT Service Konten existieren nur lokal, 
		beim Einsatz im Netzwerk muss das Computerkonto verwendet werden
es geht auch: DomUser ohne besondere Rechte
nie: Lokal System hat lokal jedes recht, aber keine netzwerkfunkt.

Browserdienst ist der Dolmetscher der  dem Client den richtigen Port der Instanz mitteilt
Port 1434 UDP

Volumewartungstask:
zur Sicherheit werden geren Daten mit NUllen �berschrieben
dem Dienst des SQL Server werden Rechte gegen selbst. ohne NULLEN schreiben huz m�ssemn
DB Dateien zu vergr��ern:

Ist einen Windows Einstellung: Durchf�hren von Volumewartungsaufgaben

Mit dieser Sicherheitseinstellung wird festgelegt, welche Benutzer und Gruppen Wartungsaufgaben auf einem Volume ausf�hren k�nnen, zum Beispiel eine Remotedefragmentierung.
Gehen Sie beim Zuweisen dieses Benutzerrechts vorsichtig vor. Benutzer mit diesem Benutzerrecht k�nnen Datentr�ger durchsuchen und Dateien in den Speicher erweitern, der andere Daten enth�lt. Wenn die erweiterten Dateien ge�ffnet werden, kann der Benutzer m�glicherweise die so erlangten Daten lesen und �ndern.
Standardwert: Administratoren


Wieso ist es einem guten Admin egal?
Bei einem guten Admin gibt es so gut wie nie Wachstum auf Dateiebene..


SA Konto.. am besten einen Ersatz schaffen
SASQL.. sysadmin Rolle..komplexes kennwort
SA deaktivieren


Datenverzeichnis
Regel: Trenne Daten von LOg (verschied HDDs)
		und das pro DB �berlegen...
		es macht keine Sinn alle Daten auf densleben Datentr�ger zu lassen

		Je mehr HDDs desto schneller


TEMPDB
	enth�lt: temp Tabellen, Wartungsarbeiten (Indizes), 
			 Zeilenversionierung
			Auslagerung
	kann unter Umst�nde extrem hohe Traffic

	eig HDDs haben (getrennt Log und Daten)

	Tempdb sollte keine gemischte Bl�cke besitzten
		(beim gem Bl�cken werden tabellen in einem Block aufgehoben)

		-T1117 Traceflag verhindert gemischte Bl�cke 
		(autom ab SQL 2016)

		alle DatenDateien m�ssen gleich gro�, damit SQL Server nicht bevorzugt 
		immer in die gr��te reinzuschreiben...

		-T1118

		soviele Dateien wie Kerne, aber max 8


MAXDOP



Arbeitsspeicher
gesamter Ram - OS (4GB - 8 / 10GB) = MAXRAM

MIN RAM: zun�chst.. k�nnen wir sp�ter feinjustieren

Max Arbeitssatz ist der peekWert: den k�nnte man as Min RAM verwenden
der MIN Wert wird erst zum Zuge kommen, wenn Daten in den Speicher gewandert sind..









*/