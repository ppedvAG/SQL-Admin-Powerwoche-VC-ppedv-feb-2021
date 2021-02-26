Use northwind;
GO

set nocount on


--DROP TABLE IF EXISTS demoX;
GO

--create table demox (id int identity, sp1 int, sp2 varchar(50));
GO


---------------CL IX
--CREATE UNIQUE CLUSTERED INDEX [CLIX] ON [dbo].[demox]  (	[id] ASC)
----------------------------------------------------


--Nicht gruppierter IX
--> CREATE UNIQUE NONCLUSTERED INDEX [NIX] ON [dbo].[demox] ([id] ASC ) INCLUDE([sp1],[sp2])








select * from [dbo].[Sales Totals by Amount]
 where saleamount < 3000;
 Go


 select shipname, customerid, city, Country, Productname, unitprice, quantity, freight 
 from invoices
 where city = 'Lyon';
 GO 


 declare @i as int=1
 while @i < 1000
 begin
 select * from demox where id = FLOOR(RANd()*100)
 set @i+=1
 end


 declare @i4 as int=1
 while @i4<100
 begin
	 exec custorderhist 'ALFKI'
	set @i4+=1
 end


declare @i3 as int=1
	while @i3 < 10000
		begin
			insert into demox values (@i3, @@SERVERNAME)
			set @i3 +=1
		end


select * from demoX where ID < 10
GO 

/*
declare @i5 as int=1

--begin tran
while @i5 <5	
begin
	update demox set sp2 = convert(varchar(50), getdate())
	where id = FLOOR(RANd()*100)	
	Waitfor delay '00:00:00.500'
	set @i5+=1
End
commit
*/

declare @i2 as int=1
 while @i2 < 1000
	 begin
	 select * from demox where id = FLOOR(RANd()*100)
	 set @i2+=1
 end

