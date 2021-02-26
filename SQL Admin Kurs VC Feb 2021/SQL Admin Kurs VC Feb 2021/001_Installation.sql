/*
Instanz

jede Instanz ist absolut autark und voneineander isoliert
(beide verbauchen RAM und CPU)

SQL 2017 und SQL 2019 auf dem gleichen Rechner .. ja ..

mehrfach installierbar (24 mal)

Standardinstanz: Port 1433
Aufruf per "Rechnername"  (hv-sql2)
Instanzname: intern -->MSSQLSERVER


benannte Instanzen verwenden irgendwelche Ports.. kann später herausfinden
Aufruf "rechnername\Instanzname" (hv-sql2\personal)

Wieso macht man mehere Instanzen:
C# Software braucht SQL 2017 max

bereits ein SQL 2019 

jede Instanz hat eine eig Berechtigung



Dienste:

SQL Agent: Jobs Aufträge (netzwerkzugriff)

SQL DB Engine: verwaltetet Datenbanken und alles was dazugehört 
	ausser Jobs (Agent)

SQL Volltext 

SQL Browser
schulung\Administrator


Lokal System .. nie verwenden.. lokal jeden Zugriff , aber nie Netzwerk
DomänenBenutzer ;-) ohne weitere Rechte

NT Service\SQLAgent lokalen Konten mit theoretischen Netzwerkzugriff
	(anstatt des Kontos greift später das Computerkonto auf das netzwerk zu)
	man muss dem Computerkonto das Recht auf die Entzwerkfreigaben geben


Volumewartungstask
wird das Häckchen gesetzt dann werden bei Vergrößerungen der Datenbankdateien keine Nullen mehr vorab geschrieben
(--> schneller)


Authentifizieren: 
Windows Auth
+ SQL Auth (gemischte Auth), bei SQL Auth wird ein best KOnto (SA) nie gesperrt

rein Windows ist sicherer

SQL braucht man, wenn man eben sich nicht in der Domöne anmeldet




SA ist der Systemadministrator. Besitzt alle Rechte. 
Sollte ein sehr kompexes Kennwort haben... 
diesen evtl später deaktivieren und einen Ersatz machen

per default ist kein Windows Admin mehr SQL Admin..


Datenträger: 
Trenne Daten von Logfiles per Datenträger aus performancegründen


Tempdb: 8 Dateien ...


MAXDOP: 8

Arbeitsspeicher:

Standard 0 bis 2,1 PB

Empfohlen: 0 bis 2620 (8800)
*/