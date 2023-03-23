--23.03.2023 503 SQL
--ÖRNEK: Hangi kitap kaç kere ödünç alýnmýþtýr?

use OduncKitapDB
Select k.KitapAdi, count(*) [Kaç kere ödünç alýnmýþ?]
from OduncIslemler(nolock)odnc
join Kitaplar k(nolock) on k.Id=odnc.KitapId
group by k.KitapAdi

--ÖRNEK: 1996 Yýlýnda en az kazandýran çalýþan

use NORTHWND
select  top 1 concat(e.FirstName ,' ', e.LastName) [Çalýþan] , 
count(*) [Satýþ Sayýsý]
from Orders o (nolock)
join Employees e (nolock) on e.EmployeeID=o.EmployeeID
where o.OrderDate >='19960101' and o.OrderDate <'19970101'
group by e.FirstName , e.LastName
order by [Satýþ Sayýsý] 

--ÖRNEK: 2006 yýlýnda kazancý minimum 7000 olan birim fiyatý minimum 20 ve içinde ff geçmeyen ürünlerden kazandýðým

select p.ProductName,cast( sum(od.UnitPrice*od.Quantity*(1-od.Discount))as decimal (18,2))[Kazanç] 
from [Order Details] od (nolock)
join Orders o(nolock) on o.ORderId=od.OrderID
join Products p (nolock)on p.ProductID=od.ProductID
where od.UnitPrice>=20 and p.ProductName not like '%ff%'
and o.OrderDate>='19970101' and o.OrderDate<'19980101'
group by p.ProductName
having sum(od.UnitPrice*od.Quantity*(1-od.Discount))>=7000

select cast (13948.6799926758 as decimal (18,2))