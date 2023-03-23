--21.03.2023 Sal� SQL


-- DML Data Manupulation Language

--insert into tabloAdi(Kolon1, Kolon2)
--values (deger1, deger2)
--metinsel, tarih tek t�rnak

--ORNEK
--�r�nler tablosuna veriler ekleyelim 

use CafeDB
insert into Urunler ([Birim_Fiyati],[Kategori_Id],[Urun_Adi],[Birim_Fiyati_Deneme1_182],[Birim_Fiyati_Deneme2_184],[Birim_Fiyati_Deneme3_Money])
values(10,2,'�ay',10.5,10.5556,10.202)

insert into Urunler(Urun_Adi,Kategori_Id,Birim_Fiyati)
values ('Kahve',2,35)

insert into Urunler(Urun_Adi,Kategori_Id,Birim_Fiyati)
values
('Limonata',2,30),
('S�cak �ikolata',2,20),
('Portakal Suyu',2,20),
('Oralet',2,15)




USE [CafeDB]
GO

INSERT INTO [dbo].[Urunler]
           ([Kategori_Id]
           ,[Urun_Adi]
           ,[Birim_Fiyati]
           ,[Birim_Fiyati_Deneme1_182]
           ,[Birim_Fiyati_Deneme2_184]
           ,[Birim_Fiyati_Deneme3_Money])
     VALUES
         (1,'S�tla�',20,null,null,null),
		 (1,'Kaday�f Dolmas�',30,30.99,30.9999,30.63),
		 (1,'Tramisu',45,null,null,null),
		 (1,'Trile�e',48,null,null,null)
GO

--DQL Data Query Language
--Select komutu se�me/listeleme yapar

-- select kolon adlar� from Tablo adi
--select* from tabloadi

select*from Urunler
select Urun_Adi, Birim_Fiyati from Urunler

select*,*,* from Urunler--K�t� �tesi kullan�m!!

select Birim_Fiyati_Deneme3_Money,*from Urunler --k�t� kullan�m !!!!!

select top 3* from Urunler --(top lullan�m�) best practice kullan�m:)

--no lock
select* from Urunler (nolock)
select* from Urunler with (nolock)

--Takma �sim ALIAS
--1. Nedeni--> Tabloya takma isim vererek tablo vce kolonlara daha kolay ula�mak
--2. nedeni JOIN konusunda a��klanacak
--3. nedeni SUBQUERYlerde derived table'� isimlendirmek i�indir.

select u.Urun_Adi as [Cafemizin �ok g�zel �r�nleri],u.Birim_Fiyati from Urunler as u --1,2,3,max4 harfli takma isim

--Bir tablonun kolonunu tabloda olan ba�ka bir kolonu takma isim olarak VERMEY�N�Z!!!...

select u.Urun_Adi,u.Birim_Fiyati from Urunler as u --1,2,3,max4 harfli takma isim

--kolonlarla i�lemler yapmak

select 10+10 sonuc
select 10+10 AS sonuc

select 10+'200000000' as sonuc -->
select '10'+'gamze' as sonuc
select 99.0+'10.75' sonuc

--�r�nlerin ismi, fiyat� �zerine %10 zam  kolonuna ihtiyac�m var
select u.Urun_Adi, u.Birim_Fiyati [Fiyat TL],
u.Birim_Fiyati*1.10[%10 eklenmi� yeni fiyat TL]
from Urunler u

--WHERE KOMUTU
--Mevcuttaki tabloya baz� ko�ullar uygulanacak
-- tablodaki verilere filtreleme yapabiiliriiz.

--�RNEK Kitap ad� Camdaki K�z olan kayd� getirelim.

--WHERE komutunun KULLANIMLARI 
   --1)Kar��la�t�rma ( <,> =,>=,<=,=!)
   --2)Mant�ksal (AND, OR, NOT)
   --3)Aral�k sorgulama (between...and)
   --4)Listesel sorgulama (in)
   --5)Like komutu
   --6)Null verileri sorgulama (is)
use OduncKitapDB
select* from Kitaplar
where KitapAdi='Camdaki K�z'

--Sayfa say�s� 350'den fazla kitaplar
select*from Kitaplar where SayfaSayisi>=350

--TurID 6 olan ve sayfa say�s� 350'den fazla olan kitaplar
select* from Kitaplar where TurId=6 and SayfaSayisi>350

select* from Kitaplar where SayfaSayisi>350 and TurId=6 --and ve demek

select* from Kitaplar where SayfaSayisi>350 or TurId=6 -- or ya da demek

-- Farkl� operat�rleri ayn� anda kullan�rsak .... Kullan!!

select* from Kitaplar where SayfaSayisi>350 and (TurId=6 or TurId=8)

--2) E�it de�il,Farkl�d�r, Not Operat�rleri

-- �rnek Sistemdeki TurId'si 6 olmayan kitaplar
select *from Kitaplar k(nolock)
where k.TurId !=6 --E��T DE��LD�R

select *from Kitaplar k(nolock)
where k.TurId <>6-- FARKLIDIR

--Not Operat�r�
select*from Kitaplar where not(TurId=6 or TurId=8)

select*from Kitaplar where not(SayfaSayisi>350 and (TurId=6 or TurId=8))

--and or not bir arada kullan�labilir
--Fakat parantez �nceli�ine dikkat edilmelidir.

select*from Kitaplar where not(YazarId=1 and SayfaSayisi>400 and StokAdeti>10)

select* from Kitaplar where not YazarId=19

--3) Aral�k Sorgulama (Between... and)
select* from Kitaplar(nolock) k where k.SayfaSayisi between 200 and 300 

--TurId 5 olan sayfaSayisi 200 ile 300 aras�nda olan kitaplar (sayfaSayisi >=200 ve <=300 mant��� vard�r)
select* from Kitaplar(nolock) k where k.SayfaSayisi between 200 and 300 and k.TurId=5

select * from Kitaplar k(nolock) where k.KayitTarihi between '20220114' and '20220114'

select * from Kitaplar k(nolock) where k.KayitTarihi <= '20220114' and k.KayitTarihi>= '20220114'

--14 ocak 2022 
-- best practice Tarih sorgulama
select * from Kitaplar k (nolock)
where k.KayitTarihi >= '20220114' and k.KayitTarihi < '20220115'

select * from Kitaplar k (nolock)
where k.KayitTarihi between '20220114' and '20220115'

--2022 ocak ay�
select * from Kitaplar k (nolock)
where k.KayitTarihi > '20211231' and k.KayitTarihi < '20220201'

select* from Kitaplar k(nolock)
where k.KitapAdi between 'Ezebere Ya�ayanlar' and 'Momo'

--GETDATE c# daki datetime, (Kay�t ekleme)
insert into Kitaplar(KayitTarihi, KitapAdi,TurId, YazarId, SayfaSayisi,StokAdeti,ResimLink,SilindiMi) values(GETDATE(),'Deneme 503',1,1,1,1,'',0)

select*from Kitaplar where Id=67
--20220114

--update TabloAd� set Kolon1=Yenidegeri1,Kolon2=YeniDegeri2...... where ko�ulu
update Kitaplar set KayitTarihi='2022-01-14 00:00:00.000',SilindiMi=1 where Id=67
update Kitaplar set KitapAdi='Deneme 503' where Id=67

insert into Kitaplar(KayitTarihi, KitapAdi,TurId, YazarId, SayfaSayisi,StokAdeti,ResimLink,SilindiMi) values(GETDATE(),'Deneme 503',1,1,1,1,'',0)

--2022den �nceki y�ldaki t�m kitaplar� stok 0 ve silindiMi 1 yapal�m

select*from Kitaplar(nolock)k where k.KayitTarihi<'20220101'

select* into Kitaplar20230321 from Kitaplar

select*from Kitaplar20230321
 
 update Kitaplar set StokAdeti=0, SilindiMi=1 where KayitTarihi<'20220101'

 --4)Listesel sorgulama(in)
 select* from Kitaplar(nolock) k where k.TurId=8 or k.TurId=6

 select* from Kitaplar(nolock) k where k.TurId in (8,6,2,4)

 select* from Kitaplar(nolock) k where k.KitapAdi in ('Camdaki K�z','Hayata D�n')

 select* from Kitaplar(nolock) k where k.KayitTarihi in ('20220114','20220115','2022-01-14 14:42:35.603')
 
 --5)Like Komutu
 -- % i�areti herhangi bir karakter kanlam�na gelir.
 -- _ alttire i�areti tek bir karakter anlam�na gelir.

 select*from Kitaplar (nolock) k
 where k.KitapAdi like 'c%' --C ile ba�layan kitaplar

 --c ile ba�las�n i�inde r olsun
 select* from Kitaplar (nolock) k where k.KitapAdi like 'c%r%'

 --Herhangi bir yerde en yanyana olsun
 select*from Kitaplar (nolock) k where k.KitapAdi like'%en%'

 -- ikinci harfi R olsun
select * from Kitaplar (nolock) k where k.KitapAdi like '__r%'

--sonu l_r ile bitsin (ler lar lur l�r ... lXr)
select * from Kitaplar (nolock) k where k.KitapAdi like '%l_r'

--sadece 4 harfliler gelsin
select * from Kitaplar (nolock) k where k.KitapAdi like '____'

--[] Aral�k belirtmek i�in
select * from Kitaplar (nolock) k where k.KitapAdi like '[a-D]__e_[B-Z]%'

--^ de�ili
select * from Kitaplar (nolock) k where k.KitapAdi like'[^-k]%'

select * from Kitaplar (nolock) k where k.KitapAdi like'[^m]___'

select * from Kitaplar (nolock) k where k.KitapAdi like'[^1]___'

--Like Not Kullan�m�

select * from Kitaplar (nolock) k where k.KitapAdi not like'm%'

--6) null verileri sorgulama (is)
select * from Kitaplar (nolock) k where k.ResimLink is null

--Resmi olmayan kitaplar
select * from Kitaplar (nolock) k where k.ResimLink is null or k.ResimLink=''

--null olmayan is not null
select * from Kitaplar (nolock) k where k.ResimLink is not null and k.ResimLink<>''

--Resmi olan kitaplar
select * from Kitaplar (nolock) k
where k.ResimLink is not null and k.ResimLink<> '' 
---Berk
select * from Kitaplar (nolock) k
where k.ResimLink is not null or not k.ResimLink='' 

insert into Kitaplar (KayitTarihi, KitapAdi, TurId, YazarId, SayfaSayisi, StokAdeti, ResimLink, SilindiMi) 
values (getdate(),'Berk Deneme 503',1,1,1,1,null,0 )

--distinct komutu
--Sorgu sonucunda gelen kolonun i�inde ayn� de�erler tekrar etmesin istersek o kolonun �n�ne tekille�tirme anlam�na distinct komutunu ekleriz.

select distinct TurId from Kitaplar(nolock)

select distinct YazarId, TurId from Kitaplar(nolock)

--group by da soruyu  ��zece�iz
--Kitaplar tablosunda yazar�n ka� kitab� var??
--------------------------------------------------------------------------------------------------------------------------------------JOIN ��LEMLER�------------------------------------------------------------
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
--------------------------------------------
--inner join(kesi�im)

select * from Kitaplar(nolock) k inner join Turler t(nolock) on k.TurId=t.Id --hangi alanlar �zerinde �zerinde e�le�me yapacak

select k.KitapAdi,k.SayfaSayisi,t.TurAdi from Kitaplar k(nolock) -- table 1
inner join Turler t(nolock) --table 2
on k.TurId=t.Id --Kesi�im sa�lanacak kolon
 
 -- Bir kitab�n ad�, t�r� ve yazar�n ad� soyad�

 select k.KitapAdi,t.TurAdi,y.YazarAdi+' '+y.YazarSoyadi Yazar from Kitaplar k (nolock) inner join Turler t(nolock) on t.Id=k.TurId join Yazarlar y(nolock) on k.YazarId=y.Id where k.SayfaSayisi>300

 --left join 
 -- Kitaplar�n �d�n� al�nma durumu
 select *from Kitaplar k(nolock)--table 1
 left join OduncIslemler oi (nolock) --table 2
 on k.Id=oi.KitapId

 select* from OduncIslemler
 -- 53 camdaki k�z   -- 2 seker portakal�
 select* from Kitaplar where Id in(53,2,3)

 insert into OduncIslemler (KayitTarihi, KitapId, OduncAlinmaTarihi, OduncBitisTarihi, PersonelId, TeslimEttigiTarih, TeslimEttiMi, UyeId) values 
(getdate(), 53, getdate(), '2023-04-21 13:50:58.903',1,null,0,5),
(getdate(), 2, getdate(), '2023-05-21 13:50:58.903',1,null,0,2)

--�RNEK Hi� �d�n� al�nmam�� kitaplar

select k.KitapAdi from Kitaplar k (nolock) left join OduncIslemler oi (nolock) on oi.KitapId=k.Id where oi.Id is not null

--1) from 2) join 3)where 4) group by 5)