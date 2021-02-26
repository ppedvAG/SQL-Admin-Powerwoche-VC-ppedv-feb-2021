/*
eine DB besteht normalerweise aus 2 Dateien

Datendatei:  ... MDF (master data file)
Logfile ........ LDF (log data file) .. Transaktionsprotokoll

Regel: Trenne Log von Daten

per Default: neue DBs haben 16MB (8+8) und Wachstumsraten von 64 MB

https://codeshare.io/501zYn

*/
use Kurs2014DB

create table t1(id int identity, spx char(4100))

insert into t1 
select 'XY'
Go 20000

--kleine Vergrößerungen brauchen in Summe mehr Zeit als wenn die vergrößerungen größere MB Happen geesen wärem
--Ideal: keine Vergrößerung
--Cool: man macht die DB so groß , wie sie in 3 Jahren sein wird..

--Backup? Das backup sichert nur die Daten weg, die enthalten sind
--Wachstumsratenn dennoch anpassen auf ein Maß, das nicht weh tut, aber dennoch 
--für seltenes Wachstum sorgt
-- 1 GB als Faustregel



