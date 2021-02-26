/*
Einstellungen des Server

RAM
MIN 0
MAX 2,1 PB (im Setup Vorschlag 2620 MB)



auf jeden Fall Max Wert vergeben
MAX, weil das OS auf jeden Fall genug RAM braucht: ca 4 bis 6 GB)

Min Wert zunächst 0 .. SQL Server gibt nur ungern wieder etwas her..


Wenn man 16GB und SQL frisst 15GB... auch das Betriebssytem braucht RAM (4 GB sollten es schon sein)




HDD
Trenne Log von Daten physikalisch 
Sicherung komprimieren

CPU
Automatische Affiniität am besten lasssen, dann kann SQL Server sich die Prozessoren aussuchen, 
die sie in dem Moment gerade rbaucht


*/