--23.03.2023 503 SQL
--�RNEK: Hangi kitap ka� kere �d�n� al�nm��t�r?

use OduncKitapDB
Select k.KitapAdi, count(*) [Ka� kere �d�n� al�nm��?]
from OduncIslemler(nolock)odnc
join Kitaplar k(nolock) on k.Id=odnc.KitapId
group by k.KitapAdi

--�RNEK: 1996 Y�l�nda en az kazand�ran �al��an

use NORTHWND
select  top 1 concat(e.FirstName ,' ', e.LastName) [�al��an] , 
count(*) [Sat�� Say�s�]
from Orders o (nolock)
join Employees e (nolock) on e.EmployeeID=o.EmployeeID
where o.OrderDate >='19960101' and o.OrderDate <'19970101'
group by e.FirstName , e.LastName
order by [Sat�� Say�s�] 

--�RNEK: 2006 y�l�nda kazanc� minimum 7000 olan birim fiyat� minimum 20 ve i�inde ff ge�meyen �r�nlerden kazand���m

select p.ProductName,cast( sum(od.UnitPrice*od.Quantity*(1-od.Discount))as decimal (18,2))[Kazan�] 
from [Order Details] od (nolock)
join Orders o(nolock) on o.ORderId=od.OrderID
join Products p (nolock)on p.ProductID=od.ProductID
where od.UnitPrice>=20 and p.ProductName not like '%ff%'
and o.OrderDate>='19970101' and o.OrderDate<'19980101'
group by p.ProductName
having sum(od.UnitPrice*od.Quantity*(1-od.Discount))>=7000

select cast (13948.6799926758 as decimal (18,2))