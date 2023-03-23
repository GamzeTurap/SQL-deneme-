--22.03.2023 �ar�amba 503 SQL

------------------------------------JOIN ��LEMLER�-------------------------------------------------------
--Join birle�tirmek anlam�na gelir
--En az 2 tablonun birle�tirilmesi i�in kullan�l�r
--Join �e�itleri--
--inner join (kesi�im)
--Left join (soldan)
--right (sa�dan)
--outter(d��) join
--cross join (kartezyen)
--self join (joinin ayn� tablolar �zerinde yap�lm�� haline verilen isim)
--composite join

--�RNEK: 10248 numaral� sipari�i kim satm�� ve hangi kargo g�ndermi�
use NORTHWND

select o.OrderID[Sipari� No],e.Title+' '+ e.FirstName+' '+e.LastName[Sat��� Yapan �al��an], s.CompanyName[Kargo Firmas�] from Orders o (nolock) 
join Employees e on e.EmployeeID=o.EmployeeID
join Shippers s on o.ShipVia=s.ShipperID
where o.OrderID=10248

--left Join 
--Hi� sipari� verilmemi� �r�nler

select* from Products p(nolock)
left join [Order Details] od (nolock) on p.ProductID=od.ProductID
where od.OrderID is null

--Yeni �r�n Ekledik.
INSERT INTO [dbo].[Products]
           ([ProductName]
           ,[SupplierID]
           ,[CategoryID]
           ,[QuantityPerUnit]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[ReorderLevel]
           ,[Discontinued])
     VALUES('503 DENEME',10,5,'100 boxes',503,100,255,10,0),
	 ('5030 DENEME',10,5,'25 boxes',503,100,255,10,1),
	 ('5031 DENEME',10,5,'30 boxes',503,100,255,10,1),
	 ('5032 DENEME',10,5,'50 boxes',503,100,255,10,1)

--Right Join
--Hi� �d�n� al�nmayan kitaplar
Use OduncKitapDB
select*from OduncIslemler odnc
right join Kitaplar k on k.Id=odnc.KitapId
where odnc.Id is null
 
 select*from Kitaplar k 
left join OduncIslemler odnc on k.Id=odnc.KitapId
where odnc.Id is null

--left Join 
--Hi� sipari� verilmemi� �r�nler
use NORTHWND
select* from Products p(nolock)
left join [Order Details] od (nolock) on p.ProductID=od.ProductID
where od.OrderID is null

-- Right Join
select* from [Order Details] odetay(nolock)
left join  Products p(nolock) on p.ProductID=odetay.ProductID
where odetay.OrderID is null


--Self Join
-- Join i�lemlerinde ayn� tablo kullan�ld���nda �zel isim al�yor.
 Use NORTHWND
 select clsn.FirstName+' '+clsn.LastName[�al��an], mdr.FirstName+' '+mdr.LastName[Ba�l� oldu�u �st�]
 from Employees clsn (nolock)
 left join Employees mdr (nolock)
 on clsn.ReportsTo=mdr.EmployeeID

 select *
from Employees clsn (nolock)
 left join Employees mdr(nolock) 
on clsn.ReportsTo = mdr.EmployeeID

select *
from Employees mdr (nolock)
 right join Employees clsn(nolock) 
on clsn.ReportsTo = mdr.EmployeeID

-- Outer Join
use OduncKitapDB
select*from Kitaplar k(nolock)
full outer join Turler t(nolock)
on t.Id=k.TurId

select*from Kitaplar k(nolock)
full outer join OduncIslemler oi
on oi.KitapId=k.Id

select*from Kitaplar k(nolock)
left join OduncIslemler oi
on oi.KitapId=k.Id

use NORTHWND
select * from Customers full outer join Orders on Customers.CustomerID=orders.CustomerID

select*from orders
where customerId is null or CustomerId=' '

USE [NORTHWND]

select*from Employees where EmployeeID=5
INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
VALUES ( null,5,getdate(), null, null, 3, 10,
      'Betul Gemisi',
      (select Address from Employees where EmployeeID=5),
      (select City from Employees where EmployeeID=5), -- '14cvbfcvb'
      (select Region from Employees where EmployeeID=5), --''
      (select PostalCode from Employees where EmployeeID=5),-- ''
      (select Country from Employees where EmployeeID=5) --'London'
     )
--select * from Employees
-- Gamze Turap -Laura Callahan onun amiri olacak �ekilde ekler misiniz

INSERT INTO [dbo].[Employees]
           ([LastName]           ,[FirstName]           ,[Title]
           ,[TitleOfCourtesy]           ,[BirthDate]           ,[HireDate]
           ,[Address]           ,[City]           ,[Region]
           ,[PostalCode]           ,[Country]
           ,[HomePhone]           ,[Extension]           ,[Photo]           ,[Notes]
           ,[ReportsTo]           ,[PhotoPath])
     VALUES
          ('Turap', 'Gamze', 'Software Developer', 'Miss', '19921114',
		  getdate(),
		  'Be�ikta�'  , 'ist', 'Avrupa yakas�', '34700','TR', null,
		  null, null, null, 
		  (select EmployeeID from Employees where FirstName ='Laura' and LastName ='Callahan')
		  , null )


		  select * from Employees where FirstName ='Laura' and LastName ='Callahan' 
	 
         		  select * from Employees where FirstName ='Laura' and LastName ='Callahan' 
		  -- yeni a�l��an ekledik
		  INSERT INTO [dbo].[Customers]
           ([CustomerID]           ,[CompanyName]
           ,[ContactName]           ,[ContactTitle]
           ,[Address]           ,[City]
           ,[Region]           ,[PostalCode]
           ,[Country]           ,[Phone]           ,[Fax])
     VALUES
         ('ZEYNP', 'Wissen Akademi', 'Zeynep K�ro�lu', 'Software developer', 
		 'Be�ikta�', '�ST', 'Avrupa Yakas�', '34700','TR', null, null),
		 ('EDAKL', 'Wissen Akademi', 'Eda K�l�n�', 'Software developer', 
		 'Be�ikta�', '�ST', 'Avrupa Yakas�', '34700','TR', null, null) 


--composite join
 --�al��anlar�mla ayn� �ehirde olan m��teriler
 use NORTHWND
 select * from Customers c
 join Employees e on
 e.Country=c.Country and e.City=c.City
and e.PostalCode=c.PostalCode

 --cross(kartezyen) join --> olas�l�k
select e.FirstName , e.LastName,  e2.LastName
from Employees e
cross join Employees e2 
--11 ^2 =121


-----------------------------------------------------------------------
--FUNTION
--MATHEMAT�CAL FUNCTION

--FUNCTIONS
--Mathematical Functions
select PI()
select pi() sonuc
select power (2,3) as sonuc
select power (2,3) sonuc
select sqrt (81) sonuc
select CEILING (9.00000001)
select FLOOR (9.9999999)
select round (9.26025,4)


-- DateTime Function
select getdate()
select year(getdate())
select month(getdate())
select day(getdate())

select dateadd(day,3,getdate())
select dateadd(month,-3,getdate())
select dateadd(year,10,getdate())
select dateadd(day,3,'20230322')

--�rn: sipari�ler verildi�i tarihten itibaren tahmini 3 g�n sonra kargolanacakt�r

select o.OrderID, o.OrderDate,
dateadd (day,3,o.OrderDate) TahminiKargoTarihi
from Orders o (nolock)

--dateddiff 2 tarih aars�ndaki fark� al�r
select DATEDIFF(day,'20220322','20230222')
select DATEDIFF(month,'20220322','20230222')
select DATEDIFF(year,'20220322','20230222')

--�rn: sipari�in verildi�i ve kargoland��� tarih aras�nda ka� g�n ge�mi�tir?
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day, o.OrderDate, o.ShippedDate)[ka� g�nde kargolanm��t�r?]
from Orders (nolock) o
select month ('20230322')

--�RN: Sipari�in verildi�i ve kargoland��� tarih aras�nda ka� g�n ge�mi�tir?
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Ka� G�nde Kargolanm��t�r? ]
from Orders (nolock) o
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20


select o.OrderID, o.OrderDate, o.ShippedDate,
c.CompanyName, c.ContactName, c.Phone,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Ka� G�nde Kargolanm��t�r? ]
from Orders (nolock) o
join Customers c on c.CustomerID=o.CustomerID
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20


--String Functions
Select ASCII ('a')
select char (97)
--
select CHARINDEX ('a','pli ata bak')
select left ('Gamze',1)
Select RIGHT ('Gamze',3)

--trim ifadeki sa� ve soldaki bo�luklar� siler
select trim ('        Gamze Turap'           )
select ltrim ('        Gamze Turap'           )
select RTRIM ('        Gamze Turap'           )

--substring ifadenin i�inden bir k�s�m keser/al�r

select SUBSTRING ('Gamze Turap',1,9)

--yerine ba�ka bir de��er vermek
select REPLACE ('Gamze','mz','zm')


select len('G a m z e') -- bo�lu�u da sayar

--concat birle�tirmek
select CONCAT ('Gamze ', ' ','Turap')

select CONCAT (e.FirstName,'',e.LastName,e.City)
from Employees e

select CONCAT(e.FirstName, ' ', e.LastName) [�sim Soyisim]
from Employees e

--str: i�ine yaz�lan ifadeyi stringe �evirir

select str (75,3) -- �kinci parametre stringe d�n��t�rd���nde ka� karakter olaca��n� belirler

--Fonsiyon i�inde fonsiyon yaz�labilir
select trim(str(503))

select len(str(75.858585899,10,5))
select str(75.811181899,10,2)

 
-- 22/03/2023

select concat( trim(str(day(o.OrderDate))),' / ',
trim(str(month(o.OrderDate))), ' / ',
trim(str(year(o.OrderDate))))
from Orders o

-- 
select CONCAT(day(o.OrderDate),' / ',MONTH(o.OrderDate),' / ',YEAR(o.OrderDate)) 
from Orders o(nolock)
-------------------------------------------------------------------------------------------
--case when then
--row
--order by
-- Artan ya da Azalan s�ralama yapar 
-- ORDER BY ifadesinden sonra 
--Tek bir kolon varsa tek kolona g�re
-- Birden �ok kolon varsa �nce ilki sonra di�erine g�re s�ralar
use OduncKitapDB
select * from Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc

select * from Kitaplar
order by StokAdeti,
KitapAdi desc, TurId desc

use NORTHWND
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Ka� G�nde Kargolanm��t�r? ]
from Orders (nolock) o
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20
order by [Ka� G�nde Kargolanm��t�r? ] 

------------------------------------------------------------------------------------
--case when then
--�rn: her sat�r i�in discount>0 ise indirimli de�ilse indirimsiz yazan kolonu olu�tural�m

select*,
case
when od.Discount>0 then 'indirimli'
else 'indirimsiz'
end [indirim durumu]
from [Order Details] od (nolock)

--�rn: sipari� detay tablosundaki her sat�rdaki �r�n i�in e�er quantity<3 ise stok t�keniyor yazs�n 10 ile 50 aras�nda ise kampanyaya uygun �r�n yazs�n 50 den b�y�kse m�d�r onay� gerikli hi�birine uymuyorsa ------- yazs�n.

select od.OrderID, od.ProductID, od.Quantity,
case
when od.Quantity<3 then 'stok t�keniyor'
when od.Quantity between 10 and 50 then 'kampanyaya uygun �r�n'
when od.Quantity>50 then 'm�d�r oany� gerekli'
else '---------------'
end[quantity e g�re durumlar]
from[order details] od

--�RNEK: Sipari� tablosundaki shipcountry alan�na bakal�m i�inde xx ge�en kolonlara puan verelim

select o.OrderID, o.ShipCountry,
case
when o.ShipCountry like '%an%' and o.ShipVia=3 then 100 else 0
end [Kargo �lke Puan�]
from Orders o(nolock)

-- rownumber(): Veriye sat�r numaras� ekleyen fonsiyon

select ROW_NUMBER () over (order by p.CategoryId desc) S�raNo, p.ProductName,p.CategoryID, p.UnitPrice
from Products p(nolock)

use OduncKitapDB
select row_number() over (order by k.SayfaSayisi desc) S�raNo,*
from Kitaplar k(nolock)

select row_number() over (order by k.SayfaSayisi desc) S�raNo, k.KitapAdi, t.TurAdi, concat(y.YazarAdi,'',y.YazarSoyadi),k.SayfaSayisi
from Kitaplar k(nolock) 
join Turler t on t.Id=k.TurId
join YAzarlar y on y.Id=k.YazarId

-------------------------------------------------------------------------------------------------
--Aggregate Functions
--SUM: Bir s�tundaki verileri toplar
--MAX: Bir kolondaki verler aras�ndan en b�y�k olan� verir
--M�N: Bir kolondaki verler aras�ndan en k���k olan� verir
--AVG: Bir kolondaki verilerin/de�erlerin ortalamas�n� al�r.
--COUNT: Bir kolondaki verilerin say�s�n� verir.
--------
--D�PNOT:Hesaplama donksiyonlar� NULL olan de�erleri dikkate almazlar!
Use NORTHWND
select count(*)from Customers
select COUNT(region)from Customers

select max (UnitPrice)[En pahal� �r�n�n fiyat�] from Products
select min (UnitPrice)[En ucuz �r�n�n fiyat�] from Products
select avg (UnitPrice)[Ortalama �r�n�n fiyat�] from Products
select sum (UnitPrice)[Toplam �r�n�n fiyat�] from Products

create table Deneme(
Id int identity (1,1) primary key, 
Deger int null
)

insert into Deneme(Deger) values (100),(null),(150),(200),(null),(50)
 select avg (deger)from Deneme --- null de�erleri dikkate almaz. 800/6=133

 select avg(isnull(deger,0))vSonu� from Deneme --800/8
 select count(isnull(region,''))from Customers
 -------------------------------------------------------------------------------------------------

-- Group by -- having
 --Genellikle agreegate func ile kullan�l�r.

 --�RNEK: Hangi �lkede ka� m��terim var?

 select c.Country, count(*)[M��teri Say�s�]
 from Customers (nolock)c
 group by c.Country
 -- order by [M��teri say�s�] desc
 order by c.Country desc

 
 select c.City, count(*)[M��teri Say�s�]
 from Customers (nolock)c
 group by c.Country, c.City
order by [M��teri say�s�] desc
-- order by c.Country desc

--Kitaplar tablosunda yazar�n ka� adet kitab� var?
use OduncKitapDB
select  k.YazarId, y.YazarAdi,y.YazarSoyadi, count(*)[Kitap Say�s�]
from Kitaplar k(nolock)
join Yazarlar y (nolock) on k.YazarId=y.Id
group by k.YazarId, y.YazarAdi,y.YazarSoyadi

select count(*) from Kitaplar where YazarId=19

 select*from Yazarlar Where YazarAdi like'%mustafa kemal%'
 select*from Kitaplar where YazarId=1

 
update Kitaplar set YazarId=17 where Id=8
update Kitaplar set YazarId=17 where Id=61
update Kitaplar set YazarId=17 where Id=65
update Kitaplar set YazarId=17 where Id=66

--having: Group by ile gruplad���n�z kolonu ya da agreeate func i�lem�nin sonucunu ko�ula tabi tutabiliriz.
--�RNEK: Hangi �lkede 5ten fazla m��terim var?
use NORTHWND

 select c.Country, count(*)[M��teri Say�s�]
 from Customers (nolock)c
 group by c.Country
 having count (*)>5 and c.Country!='USA'
 order by c.Country desc

 --D�PNOT: Performans a��s�ndan daha iyidir
--NEDEN? ��nk� �nce datadan USA'leri ��kartt� sonra gruplad� sonra gruplad���ndan 5ten b�y�kleri ald�.
  select c.Country, count(*)[M��teri Say�s�]
 from Customers (nolock)c
 where c.Country!='USA'
 group by c.Country
having count (*)>5 
 order by c.Country desc

 --�RN: �R�n baz�nda ciro 
 select top 300 od.ProductID, p.ProductName, sum (od.UnitPrice*od.Quantity*(1-od.Discount))[Ciro]
 from [Order Details] od (nolock) join Products p(nolock) on p.ProductID=od.ProductID
 group by od.ProductID, p.ProductName

 select p.ProductName, sum (od.UnitPrice*od.Quantity*(1-od.Discount))[Ciro]
 from [Order Details] od (nolock) join Products p(nolock) on p.ProductID=od.ProductID
 group by p.ProductName
order by Ciro desc

--�RNEK: En �ok al��veri� yapan m��teri
select top 1 o.CustomerID,c.CompanyName, COUNT(*)[Al��veri� Say�s�]
from Orders o (nolock)
join Customers c (nolock ) on c.CustomerID=o.CustomerID
group by o.CustomerID, c.CompanyName
order by [Al��veri� Say�s�] desc

--�RNEK:En �ok sat�� yapan �al��an
