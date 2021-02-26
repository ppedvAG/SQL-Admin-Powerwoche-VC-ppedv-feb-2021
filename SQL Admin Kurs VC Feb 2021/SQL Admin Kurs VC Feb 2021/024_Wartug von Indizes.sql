/*
Fehlende Indizes

Überflüssige Indizes weil sie dassselbe tun was ein anderer schon macht

Problem: jedes INS UP DEL ist erst dann fetig, wenn jeder IX auch aktualisiert wurde
--> wir könne > 1000 IX pro Tabelle haben

Fehlverhalten: statt reinen SEEK --> SEEK mit Lookup oder ein IX SCAN
 reinen SEEK: Covered (abdeckender) IX

Fragmentierung
o bis 10% ..nix tun
10% bis 30% Reorganisieren.. Blattebene des IX wird verdichtet (nicht der Baum)
>30% Rebuild IX komplett renoviert

Statistiken
werden gebaucht um den richigen IX herauszufinden:
NIX ist ja nur gut, wenn rel wenig rauskommt. Das muss an vorher wissen

Statistiken ändern sich bei I U D--> also Stat müssen aktualisiert werden

Mechanismus: alle 20% Änderungen an der Gesamtmeneg plus 500 dazu plus Abfrage auf Spalte

TAB 1 MIO
1x Otto (eigtl IX Seek super)
+ 200000 OTTO dazu-- > keine neue Stat
+ 500 Otto dazu --> keie neue stat
+ Abfrage auf mit Vorname --> jetzt neue Stat

bis 200499 Ottos würde er also IX machen, obwohl schon längt der TAB Scan besser besser

--Sieht man das... bei Abfrage mit essung der IO

tabelle hat 60000 Seiten .. wir suchen mit IX Seek .. 3 Seiten bei einem DS

Tabwll durchsuchen nach 100000 Werten (aber Stat denkt noch wert ist einmalig)
		---> > 500000 Seiten







*/