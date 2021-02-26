/*
Datentypen

"Otto"
N= UNICODE

varchar(50) "Otto"    4 Zeichen
char(50)    "otto                                   "  50 Zeichen
nvarchar(50) "Otto"   4Zeichen * 2 UNICODE    8 Zeichen
nchar(50)    "Otto                         "  50 Zeichen + 2 = 100 Zeichen 

Falls UNICODE nicht sein muss, dann kein UNICODE
char Feld immer dann wenn wir fixen Längen haben, sonst varchar


DATUM

date nur Datum
smalldatetime  ist auf die Sekunde genau
datetime       ist auf ms Sekunde genau
datetime2	   ist auf ns Sekunde genau
datetimeoffset ist auf ns Sekunde genau und enthält die Zeitzone
time nur zeit

datetime ist nicht genau. Es speichert auf 2 bis 3 ms nur genau

Zahlen


int  +- 2,1 mrd
smallint  ca 32000
tinyint +256
bigint 

bit 0 1

decimal(5,2) .. 5 Zeichen kang, davon 2 Nachkommas
decimla(18,0)

money (8 Nachkommas) aber wir dgerne für Währungs

float (> 20 nachkommastellen = real


Test auf Seiten Verschleiss

Datensätze werden in Seiten gespeichert
Seiten:
immer 8 kb groß unveränderlich
1 DS mann nicht mehr als 8060 Zeichen gross sein (normalweise)
1 DS muss in eine Seite passen
der nicht belegte teil einer Seiten muss dennoch, bei jedem Lesen, von der HDD in den RAM 
gepseichert werden



*/


use northwind


dbcc showcontig('Customers')

--Gescannte Seiten.............................: 3
---Mittlere Seitendichte (voll).....................: 96.95%

dbcc showcontig('t1')

--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%

select 40000*8 --320MB auf der HDD und im RAM
select 320*0.79 --252MB --70MB total umsonst im RAM und auf HDD



select * from t1



--Tabelle mit 10000 --nix
--   100000 800MB ---> 81% --- > 95% --evtl kommen hier nur 100MB raus
--   1000000 800MB ---> 90% --- > 92% --evtl kommen hier nur 1000MB raus

--Berichte der DB -.. Datenträgerverwendung durch obester Tabellen

