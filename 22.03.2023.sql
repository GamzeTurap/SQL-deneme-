--22.03.2023 Çarþamba 503 SQL

------------------------------------JOIN ÝÞLEMLERÝ-------------------------------------------------------
--Join birleþtirmek anlamýna gelir
--En az 2 tablonun birleþtirilmesi için kullanýlýr
--Join Çeþitleri--
--inner join (kesiþim)
--Left join (soldan)
--right (saðdan)
--outter(dýþ) join
--cross join (kartezyen)
--self join (joinin ayný tablolar üzerinde yapýlmýþ haline verilen isim)
--composite join

--ÖRNEK: 10248 numaralý sipariþi kim satmýþ ve hangi kargo göndermiþ
use NORTHWND

select o.OrderID[Sipariþ No],e.Title+' '+ e.FirstName+' '+e.LastName[Satýþý Yapan çalýþan], s.CompanyName[Kargo Firmasý] from Orders o (nolock) 
join Employees e on e.EmployeeID=o.EmployeeID
join Shippers s on o.ShipVia=s.ShipperID
where o.OrderID=10248

--left Join 
--Hiç sipariþ verilmemiþ ürünler

select* from Products p(nolock)
left join [Order Details] od (nolock) on p.ProductID=od.ProductID
where od.OrderID is null

--Yeni ürün Ekledik.
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
--Hiç ödünç alýnmayan kitaplar
Use OduncKitapDB
select*from OduncIslemler odnc
right join Kitaplar k on k.Id=odnc.KitapId
where odnc.Id is null
 
 select*from Kitaplar k 
left join OduncIslemler odnc on k.Id=odnc.KitapId
where odnc.Id is null

--left Join 
--Hiç sipariþ verilmemiþ ürünler
use NORTHWND
select* from Products p(nolock)
left join [Order Details] od (nolock) on p.ProductID=od.ProductID
where od.OrderID is null

-- Right Join
select* from [Order Details] odetay(nolock)
left join  Products p(nolock) on p.ProductID=odetay.ProductID
where odetay.OrderID is null


--Self Join
-- Join iþlemlerinde ayný tablo kullanýldýðýnda özel isim alýyor.
 Use NORTHWND
 select clsn.FirstName+' '+clsn.LastName[Çalýþan], mdr.FirstName+' '+mdr.LastName[Baðlý olduðu üstü]
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
-- Gamze Turap -Laura Callahan onun amiri olacak þekilde ekler misiniz

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
		  'Beþiktaþ'  , 'ist', 'Avrupa yakasý', '34700','TR', null,
		  null, null, null, 
		  (select EmployeeID from Employees where FirstName ='Laura' and LastName ='Callahan')
		  , null )


		  select * from Employees where FirstName ='Laura' and LastName ='Callahan' 
	 
         		  select * from Employees where FirstName ='Laura' and LastName ='Callahan' 
		  -- yeni açlýþan ekledik
		  INSERT INTO [dbo].[Customers]
           ([CustomerID]           ,[CompanyName]
           ,[ContactName]           ,[ContactTitle]
           ,[Address]           ,[City]
           ,[Region]           ,[PostalCode]
           ,[Country]           ,[Phone]           ,[Fax])
     VALUES
         ('ZEYNP', 'Wissen Akademi', 'Zeynep Köroðlu', 'Software developer', 
		 'Beþiktaþ', 'ÝST', 'Avrupa Yakasý', '34700','TR', null, null),
		 ('EDAKL', 'Wissen Akademi', 'Eda Kýlýnç', 'Software developer', 
		 'Beþiktaþ', 'ÝST', 'Avrupa Yakasý', '34700','TR', null, null) 


--composite join
 --Çalýþanlarýmla ayný þehirde olan müþteriler
 use NORTHWND
 select * from Customers c
 join Employees e on
 e.Country=c.Country and e.City=c.City
and e.PostalCode=c.PostalCode

 --cross(kartezyen) join --> olasýlýk
select e.FirstName , e.LastName,  e2.LastName
from Employees e
cross join Employees e2 
--11 ^2 =121


-----------------------------------------------------------------------
--FUNTION
--MATHEMATÝCAL FUNCTION

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

--örn: sipariþler verildiði tarihten itibaren tahmini 3 gün sonra kargolanacaktýr

select o.OrderID, o.OrderDate,
dateadd (day,3,o.OrderDate) TahminiKargoTarihi
from Orders o (nolock)

--dateddiff 2 tarih aarsýndaki farký alýr
select DATEDIFF(day,'20220322','20230222')
select DATEDIFF(month,'20220322','20230222')
select DATEDIFF(year,'20220322','20230222')

--örn: sipariþin verildiði ve kargolandýðý tarih arasýnda kaç gün geçmiþtir?
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day, o.OrderDate, o.ShippedDate)[kaç günde kargolanmýþtýr?]
from Orders (nolock) o
select month ('20230322')

--ÖRN: Sipariþin verildiði ve kargolandýðý tarih arasýnda kaç gün geçmiþtir?
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolanmýþtýr? ]
from Orders (nolock) o
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20


select o.OrderID, o.OrderDate, o.ShippedDate,
c.CompanyName, c.ContactName, c.Phone,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolanmýþtýr? ]
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

--trim ifadeki sað ve soldaki boþluklarý siler
select trim ('        Gamze Turap'           )
select ltrim ('        Gamze Turap'           )
select RTRIM ('        Gamze Turap'           )

--substring ifadenin içinden bir kýsým keser/alýr

select SUBSTRING ('Gamze Turap',1,9)

--yerine baþka bir deððer vermek
select REPLACE ('Gamze','mz','zm')


select len('G a m z e') -- boþluðu da sayar

--concat birleþtirmek
select CONCAT ('Gamze ', ' ','Turap')

select CONCAT (e.FirstName,'',e.LastName,e.City)
from Employees e

select CONCAT(e.FirstName, ' ', e.LastName) [Ýsim Soyisim]
from Employees e

--str: içine yazýlan ifadeyi stringe çevirir

select str (75,3) -- Ýkinci parametre stringe dönüþtürdüðünde kaç karakter olacaðýný belirler

--Fonsiyon içinde fonsiyon yazýlabilir
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
-- Artan ya da Azalan sýralama yapar 
-- ORDER BY ifadesinden sonra 
--Tek bir kolon varsa tek kolona göre
-- Birden çok kolon varsa önce ilki sonra diðerine göre sýralar
use OduncKitapDB
select * from Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc

select * from Kitaplar
order by StokAdeti,
KitapAdi desc, TurId desc

use NORTHWND
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolanmýþtýr? ]
from Orders (nolock) o
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20
order by [Kaç Günde Kargolanmýþtýr? ] 

------------------------------------------------------------------------------------
--case when then
--örn: her satýr için discount>0 ise indirimli deðilse indirimsiz yazan kolonu oluþturalým

select*,
case
when od.Discount>0 then 'indirimli'
else 'indirimsiz'
end [indirim durumu]
from [Order Details] od (nolock)

--örn: sipariþ detay tablosundaki her satýrdaki ürün için eðer quantity<3 ise stok tükeniyor yazsýn 10 ile 50 arasýnda ise kampanyaya uygun ürün yazsýn 50 den büyükse müdür onayý gerikli hiçbirine uymuyorsa ------- yazsýn.

select od.OrderID, od.ProductID, od.Quantity,
case
when od.Quantity<3 then 'stok tükeniyor'
when od.Quantity between 10 and 50 then 'kampanyaya uygun ürün'
when od.Quantity>50 then 'müdür oanyý gerekli'
else '---------------'
end[quantity e göre durumlar]
from[order details] od

--ÖRNEK: Sipariþ tablosundaki shipcountry alanýna bakalým içinde xx geçen kolonlara puan verelim

select o.OrderID, o.ShipCountry,
case
when o.ShipCountry like '%an%' and o.ShipVia=3 then 100 else 0
end [Kargo Ülke Puaný]
from Orders o(nolock)

-- rownumber(): Veriye satýr numarasý ekleyen fonsiyon

select ROW_NUMBER () over (order by p.CategoryId desc) SýraNo, p.ProductName,p.CategoryID, p.UnitPrice
from Products p(nolock)

use OduncKitapDB
select row_number() over (order by k.SayfaSayisi desc) SýraNo,*
from Kitaplar k(nolock)

select row_number() over (order by k.SayfaSayisi desc) SýraNo, k.KitapAdi, t.TurAdi, concat(y.YazarAdi,'',y.YazarSoyadi),k.SayfaSayisi
from Kitaplar k(nolock) 
join Turler t on t.Id=k.TurId
join YAzarlar y on y.Id=k.YazarId

-------------------------------------------------------------------------------------------------
--Aggregate Functions
--SUM: Bir sütundaki verileri toplar
--MAX: Bir kolondaki verler arasýndan en büyük olaný verir
--MÝN: Bir kolondaki verler arasýndan en küçük olaný verir
--AVG: Bir kolondaki verilerin/deðerlerin ortalamasýný alýr.
--COUNT: Bir kolondaki verilerin sayýsýný verir.
--------
--DÝPNOT:Hesaplama donksiyonlarý NULL olan deðerleri dikkate almazlar!
Use NORTHWND
select count(*)from Customers
select COUNT(region)from Customers

select max (UnitPrice)[En pahalý Ürünün fiyatý] from Products
select min (UnitPrice)[En ucuz Ürünün fiyatý] from Products
select avg (UnitPrice)[Ortalama Ürünün fiyatý] from Products
select sum (UnitPrice)[Toplam Ürünün fiyatý] from Products

create table Deneme(
Id int identity (1,1) primary key, 
Deger int null
)

insert into Deneme(Deger) values (100),(null),(150),(200),(null),(50)
 select avg (deger)from Deneme --- null deðerleri dikkate almaz. 800/6=133

 select avg(isnull(deger,0))vSonuç from Deneme --800/8
 select count(isnull(region,''))from Customers
 -------------------------------------------------------------------------------------------------

-- Group by -- having
 --Genellikle agreegate func ile kullanýlýr.

 --ÖRNEK: Hangi ülkede kaç müþterim var?

 select c.Country, count(*)[Müþteri Sayýsý]
 from Customers (nolock)c
 group by c.Country
 -- order by [Müþteri sayýsý] desc
 order by c.Country desc

 
 select c.City, count(*)[Müþteri Sayýsý]
 from Customers (nolock)c
 group by c.Country, c.City
order by [Müþteri sayýsý] desc
-- order by c.Country desc

--Kitaplar tablosunda yazarýn kaç adet kitabý var?
use OduncKitapDB
select  k.YazarId, y.YazarAdi,y.YazarSoyadi, count(*)[Kitap Sayýsý]
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

--having: Group by ile grupladýðýnýz kolonu ya da agreeate func iþlemþnin sonucunu koþula tabi tutabiliriz.
--ÖRNEK: Hangi ülkede 5ten fazla müþterim var?
use NORTHWND

 select c.Country, count(*)[Müþteri Sayýsý]
 from Customers (nolock)c
 group by c.Country
 having count (*)>5 and c.Country!='USA'
 order by c.Country desc

 --DÝPNOT: Performans açýsýndan daha iyidir
--NEDEN? Çünkü önce datadan USA'leri çýkarttý sonra grupladý sonra grupladýðýndan 5ten büyükleri aldý.
  select c.Country, count(*)[Müþteri Sayýsý]
 from Customers (nolock)c
 where c.Country!='USA'
 group by c.Country
having count (*)>5 
 order by c.Country desc

 --ÖRN: ÜRün bazýnda ciro 
 select top 300 od.ProductID, p.ProductName, sum (od.UnitPrice*od.Quantity*(1-od.Discount))[Ciro]
 from [Order Details] od (nolock) join Products p(nolock) on p.ProductID=od.ProductID
 group by od.ProductID, p.ProductName

 select p.ProductName, sum (od.UnitPrice*od.Quantity*(1-od.Discount))[Ciro]
 from [Order Details] od (nolock) join Products p(nolock) on p.ProductID=od.ProductID
 group by p.ProductName
order by Ciro desc

--ÖRNEK: En çok alýþveriþ yapan müþteri
select top 1 o.CustomerID,c.CompanyName, COUNT(*)[Alýþveriþ Sayýsý]
from Orders o (nolock)
join Customers c (nolock ) on c.CustomerID=o.CustomerID
group by o.CustomerID, c.CompanyName
order by [Alýþveriþ Sayýsý] desc

--ÖRNEK:En çok satýþ yapan çalýþan
