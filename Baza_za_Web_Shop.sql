create database webshop

use webshop

Create table Artikal(
artikal_id INT Primary Key identity(1,1),
ime nvarchar(255) not null,
cena int not null,
statusArtikla_id int,
kategorija_id int,
opis nvarchar(250),
magacin int,
link  nvarchar(max)
)


Create table Kategorija (
kategorija_id int Primary Key identity(1,1),
kategorija_ime nvarchar(100)
)


Create table StatusArtikla (
statusArtikla_id int Primary Key identity(1,1),
is_vidljivo nvarchar(2)
)


Create table Slika (
slika_id int Primary Key Identity(1,1),
naziv nvarchar(max),
slika_ref nvarchar(150) not null unique
)


Drop table Porudzbina

Create Table Porudzbina (
porudzbina_id INT PRIMARY KEY identity(1,1),
korisnik_email nvarchar(250) not null,
artikal_id INT not null,
is_zavrseno nvarchar(2),
vreme_porudzbina DATETIME NOT NULL,
kolicina_kupovine INT NOT NULL
)


Create table Korisnik (
korisnik_id int Primary Key identity(1,1),
ime_korisnik nvarchar(100) not null,
prezime_korisnik nvarchar(100) not null,
lozinka_hash nvarchar(255) not null,
email nvarchar(255) not null unique,
drzava nvarchar(100) not null,
grad nvarchar(100) not null,
opstina nvarchar(100) not null,
postanski_br int not null,
adresa nvarchar(255) not null,
tip_korisnik_id int,
pol nvarchar(10) not null check (pol in('Musko', 'Zensko'))
)


Create table TipKorisnik (
tip_korisnik_id int Primary Key identity(1,1),
is_administrator nvarchar(2)
)



ALTER table Artikal
add constraint FK_statusArtikla_id
FOREIGN KEY (statusArtikla_id)
REFERENCES StatusArtikla(statusArtikla_id);

ALTER table Artikal
add constraint FK_kategorija_id
FOREIGN KEY (kategorija_id)
REFERENCES Kategorija(kategorija_id);

--ALTER table Artikal
--add constraint FK_slika_id
--FOREIGN KEY (ime)
--REFERENCES Slika(slika_id);



ALTER table Porudzbina
add constraint FK_korisnik_id
FOREIGN KEY (korisnik_id)
REFERENCES Korisnik(korisnik_id);

ALTER table Porudzbina
add constraint FK_artikal_id
FOREIGN KEY (artikal_id)
REFERENCES Artikal(artikal_id);



ALTER table Korisnik
add constraint FK_tip_korisnik_id
FOREIGN KEY (tip_korisnik_id)
REFERENCES TipKorisnik(tip_korisnik_id);







/*-------------------------------------- Tabela KORISNIK -------------------------------------------*/
GO
Create PROC dbo.Korisnik_Email
@email nvarchar(50),
@loz nvarchar(100)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 email FROM Korisnik
	WHERE email = @email and lozinka_hash=@loz)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO


GO
Alter PROC Korisnik_Insert
@ime_korisnik nvarchar(100),
@prezime_korisnik nvarchar(100),
@lozinka_hash nvarchar(255),
@email nvarchar(255),
@drzava nvarchar(100),
@grad nvarchar(100),
@opstina nvarchar(100),
@postanski_br int,
@adresa nvarchar(255),
@tip_korisnik_id int,
@pol nvarchar(10)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 email FROM Korisnik
	WHERE email = @email and lozinka_hash=@lozinka_hash)
	Return 1
	else
	Insert Into Korisnik(ime_korisnik,prezime_korisnik,lozinka_hash,email,drzava,grad,opstina,postanski_br,adresa,tip_korisnik_id,pol)
	Values(@ime_korisnik,@prezime_korisnik,@lozinka_hash,@email,@drzava,@grad,@opstina,@postanski_br,@adresa,@tip_korisnik_id,@pol)
		RETURN 0;
END TRY
	
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO



/**/

/*Nova procedura*/
GO
Create PROC Korisnici_Svi
As
BEGIN TRY
	Select * from Korisnik
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO


/**/

GO
Create PROC dbo.Korisnik_Email_Admin
@email nvarchar(50),
@loz nvarchar(100)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 email FROM Korisnik
	WHERE email = @email and lozinka_hash=@loz and tip_korisnik_id=1)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO

/**/
GO
Create PROC Korisnik_Update
@korisnik_id int,
@ime_korisnik nvarchar(100),
@prezime_korisnik nvarchar(100),
@lozinka_hash nvarchar(255),
@email nvarchar(255),
@drzava nvarchar(100),
@grad nvarchar(100),
@opstina nvarchar(100),
@postanski_br int,
@adresa nvarchar(255),
@tip_korisnik_id int,
@pol nvarchar(10)
AS
SET LOCK_TIMEOUT 3000;

BEGIN TRY
	IF EXISTS (SELECT TOP 1 ime_korisnik FROM Korisnik
	WHERE korisnik_id = @korisnik_id)

	BEGIN
	
	Update Korisnik Set ime_korisnik=@ime_korisnik, prezime_korisnik=@prezime_korisnik, lozinka_hash=@lozinka_hash, email=@email, @drzava=@drzava, grad=@grad, opstina=@opstina, postanski_br=@postanski_br, adresa=@adresa, tip_korisnik_id=@tip_korisnik_id, pol=@pol where korisnik_id = @korisnik_id
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Go
Create Proc Korisnik_Delete
@korisnik_id int
as
Begin TRY
Delete from Korisnik where korisnik_id = @korisnik_id
RETURN 0
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO




/*-------------------------------------- Tabela Artikal -------------------------------------------*/

GO
Create PROC dbo.Artikal_Magacin
@ime nvarchar(255),
@magacin int
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 ime FROM Artikal
	WHERE ime = @ime and magacin = @magacin)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO

GO
Create PROC Artikal_Insert
@ime nvarchar(255),
@cena int,
@statusArtikla_id int,
@kategorija_id int,
@opis nvarchar(250),
@magacin int,
@link nvarchar(max)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 ime FROM Artikal
	WHERE ime = @ime and magacin = @magacin)
	Return 1
	else
	Insert Into Artikal(ime, cena, statusArtikla_id, kategorija_id, opis, magacin,link)
	Values(@ime, @cena, @statusArtikla_id, @kategorija_id, @opis, @magacin,@link)
		RETURN 0;
END TRY
	
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO



GO
Create PROC Arikal_Update
@artikal_id int,
@ime nvarchar(255),
@cena int,
@statusArtikla_id int,
@kategorija_id int,
@opis nvarchar(250),
@magacin int
AS
SET LOCK_TIMEOUT 3000;

BEGIN TRY
	IF EXISTS (SELECT TOP 1 ime FROM Artikal
	WHERE artikal_id = @artikal_id )

	BEGIN
	
	Update Artikal Set ime=@ime, cena=@cena, statusArtikla_id=@statusArtikla_id, kategorija_id=@kategorija_id , opis=@opis, magacin=@magacin where artikal_id=@artikal_id
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

go
Create Proc Artikal_Delete
@artikal_id int,
@ime nvarchar(255)
as
Begin TRY
Delete from Artikal where ime=@ime and artikal_id=@artikal_id
RETURN 0
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Create proc Artikal_Svi
As
BEGIN TRY
	Select * from Artikal
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO


Create proc Artikal_Pregled
as
Select  a.artikal_id,a.ime,a.cena,a.link,a.opis, s.is_vidljivo,k.kategorija_ime from Artikal as a
inner join StatusArtikla as s
on
a.statusArtikla_id=s.statusArtikla_id
inner join Kategorija as k
on
a.kategorija_id=k.kategorija_id
where 
k.kategorija_id=1


Alter proc Artikal_Pregled_ID
@id int
as
Select  a.artikal_id,a.ime,a.cena,a.link,a.opis, s.is_vidljivo,k.kategorija_ime,p.slika_ref from Artikal as a
inner join StatusArtikla as s
on
a.statusArtikla_id=s.statusArtikla_id
inner join Kategorija as k
on
a.kategorija_id=k.kategorija_id
inner join (SELECT DISTINCT naziv,slika_ref FROM Slika) as p
on
a.link=p.naziv
where
a.artikal_id=@id 


go
Alter proc Artikal_Pregled_Slika
as
Select distinct a.artikal_id, a.ime,a.cena,a.link,a.opis,a.link,s.is_vidljivo,k.kategorija_ime from Artikal as a
inner join StatusArtikla as s
on
a.statusArtikla_id=s.statusArtikla_id
inner join Kategorija as k
on
a.kategorija_id=k.kategorija_id
inner join (SELECT DISTINCT naziv FROM Slika) as p
on
a.link=p.naziv

/* ----------------------Tabela Kategorija -------------------- */
GO
Create PROC dbo.Kategorija_Ime
@kategorija_ime nvarchar(100)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 kategorija_ime FROM Kategorija
	WHERE kategorija_ime = @kategorija_ime)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO


GO
CREATE PROC Kategorija_Insert
@kategorija_ime nvarchar(100)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 kategorija_ime FROM Kategorija
	WHERE kategorija_ime = @kategorija_ime)
	Return 1
	else
	Insert Into Kategorija(kategorija_ime)
	Values(@kategorija_ime)
		RETURN 0;
END TRY
	
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

GO
Create PROC Kategorija_Update
@kategorija_id int,
@kategorija_ime nvarchar(100)
AS
SET LOCK_TIMEOUT 3000;

BEGIN TRY
	IF EXISTS (SELECT TOP 1 kategorija_ime FROM Kategorija
	WHERE kategorija_id = @kategorija_id)
	BEGIN
	Update Kategorija Set kategorija_ime = @kategorija_ime where kategorija_id = @kategorija_id
		RETURN 0;
	END
	RETURN -1;
END TRY

BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Go
Create Proc Kategorija_Delete
@kategorija_id int,
@kategorija_ime nvarchar(100)
as
Begin TRY
Delete from Kategorija where kategorija_ime = @kategorija_ime and kategorija_id = @kategorija_id
RETURN 0
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Create proc Kategorija_Svi
As
BEGIN TRY
	Select * from Kategorija
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO


/* ---------------------- Tabela StatusArtikla -------------------- */
GO
Create PROC dbo.StatusArtikla_Status
@is_vidljivo nvarchar (2)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 is_vidljivo FROM StatusArtikla
	WHERE is_vidljivo = @is_vidljivo)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO


GO
CREATE PROC StatusArtikla_Insert
@is_vidljivo nvarchar (2)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 is_vidljivo FROM StatusArtikla
	WHERE is_vidljivo = @is_vidljivo)
	Return 1
	else
	Insert Into StatusArtikla(is_vidljivo)
	Values(@is_vidljivo)
		RETURN 0;
END TRY
	
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

GO
Create PROC StatusArtikla_Update
@statusArtikla_id int,
@is_vidljivo BIT
AS
SET LOCK_TIMEOUT 3000;

BEGIN TRY
	IF EXISTS (SELECT TOP 1 is_vidljivo FROM StatusArtikla
	WHERE statusArtikla_id = @statusArtikla_id )

	BEGIN
	
	Update StatusArtikla Set is_vidljivo = @is_vidljivo where statusArtikla_id = @statusArtikla_id
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Go
Create Proc StatusArtikla_Delete
@statusArtikla_id int
as
Begin TRY
Delete from StatusArtikla where statusArtikla_id = @statusArtikla_id
RETURN 0
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO


Create proc StatusArtikla_Svi
As
BEGIN TRY
	Select * from StatusArtikla
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO




/* ---------------------- Tabela Slika ---------------------- */
GO
Create PROC dbo.Slika_Ref
@slika_ref nvarchar(150)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 slika_ref FROM Slika
	WHERE slika_ref = @slika_ref)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO


GO
Create PROC Slika_Insert
@naziv nvarchar(max),
@slika_ref nvarchar(max)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 slika_ref FROM Slika
	WHERE slika_ref = @slika_ref)
	Return 1
	else
	Insert Into Slika(naziv,slika_ref)
	Values(@naziv,@slika_ref)
		RETURN 0;
END TRY
	
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

GO
Create PROC Slika_Update
@slika_id nvarchar(255),                /* Ovde je bio int */
@slika_ref nvarchar(150)
AS
SET LOCK_TIMEOUT 3000;

BEGIN TRY
	IF EXISTS (SELECT TOP 1 slika_ref FROM Slika
	WHERE slika_id = @slika_id )

	BEGIN
	
	Update Slika Set slika_ref = @slika_ref where slika_id = @slika_id
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Go
Create Proc Slika_Delete
@slika_id nvarchar(255)               /*Ovde je bio int*/
as
Begin TRY
Delete from Slika where slika_id = @slika_id
RETURN 0
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Create proc Slika_Svi
As
BEGIN TRY
	Select * from Slika
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Create proc Slika_naziv
@naziv nvarchar(max)
As
BEGIN TRY
	Select * from Slika where naziv=@naziv
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

exec Slika_Svi


/* ---------------------- Tabela Porudzbina ---------------------- */
GO
Create PROC dbo.Porudzbina_Artikal
@korisnik_id INT,
@artikal_id INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 korisnik_id FROM Porudzbina
	WHERE korisnik_id = @korisnik_id and artikal_id = @artikal_id)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO


GO
Create PROC Porudzbina_Insert
@korisnik_email nvarchar(250),
@artikal_id INT,
@is_zavrseno BIT,
@vreme_porudzbina DATETIME,
@kolicina_kupovine INT
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 korisnik_email FROM Porudzbina
	WHERE korisnik_email = @korisnik_email and artikal_id = @artikal_id)
	Return 1
	else
	Insert Into Porudzbina(korisnik_email, artikal_id, is_zavrseno, vreme_porudzbina, kolicina_kupovine)
	Values(@korisnik_email, @artikal_id, @is_zavrseno, @vreme_porudzbina, @kolicina_kupovine)
		RETURN 0;
END TRY
	
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

GO
Create PROC Porudzbina_Update
@porudzbina_id INT,
@korisnik_id INT,
@artikal_id INT,
@is_zavrseno BIT,
@vreme_porudzbina DATETIME,
@kolicina_kupovine INT
AS
SET LOCK_TIMEOUT 3000;

BEGIN TRY
	IF EXISTS (SELECT TOP 1 korisnik_id FROM Porudzbina
	WHERE porudzbina_id = @porudzbina_id )

	BEGIN
	
	Update Porudzbina Set korisnik_id=@korisnik_id, artikal_id=@artikal_id, is_zavrseno=@is_zavrseno, vreme_porudzbina=@vreme_porudzbina, kolicina_kupovine=@kolicina_kupovine where porudzbina_id = @porudzbina_id
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

go
Create Proc Porudzbina_Delete
@porudzbina_id INT
as
Begin TRY
Delete from Porudzbina where porudzbina_id = @porudzbina_id
RETURN 0
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

/*Nova procedura*/
Create proc Porudzbina_Svi
As
BEGIN TRY
	Select * from Porudzbina
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

exec Porudzbina_Svi

/* ---------------------- Tabela TipKorisnik ---------------------- */
GO
Create PROC dbo.TipKorisnik_Korisnik
@is_administrator nvarchar (2)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 is_administrator FROM TipKorisnik
	WHERE is_administrator = @is_administrator)
	Begin
	RETURN 0
	end
	RETURN 1
END TRY
BEGIN CATCH
	RETURN @@error;
END CATCH
GO


GO
CREATE PROC TipKorisnik_Insert
@is_administrator  nvarchar (2)
AS
SET LOCK_TIMEOUT 3000;
BEGIN TRY
	IF EXISTS(SELECT TOP 1 is_administrator FROM TipKorisnik
	WHERE is_administrator = @is_administrator)
	Return 1
	else
	Insert Into TipKorisnik(is_administrator)
	Values(@is_administrator)
		RETURN 0;
END TRY
	
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO


GO
Create PROC TipKorisnik_Update
@tip_korisnik_id int,
@is_administrator BIT 
AS
SET LOCK_TIMEOUT 3000;

BEGIN TRY
	IF EXISTS (SELECT TOP 1 is_administrator FROM TipKorisnik
	WHERE tip_korisnik_id = @tip_korisnik_id )

	BEGIN
	
	Update TipKorisnik Set is_administrator = @is_administrator where tip_korisnik_id = @tip_korisnik_id
		RETURN 0;
	END
	RETURN -1;
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

go
Create Proc TipKorisnik_Delete
@tip_korisnik_id int
as
Begin TRY
Delete from TipKorisnik where tip_korisnik_id = @tip_korisnik_id
RETURN 0
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO

Create proc TipKorisnik_Svi
As
BEGIN TRY
	Select * from TipKorisnik
END TRY
BEGIN CATCH
	RETURN @@ERROR;
END CATCH
GO



/**/
Create proc Pregled_Status
as
Select statusArtikla_id,is_vidljivo from StatusArtikla
go
exec Pregled_Status
go

Create proc Pregled_Kategorija
as
Select kategorija_id,kategorija_ime from Kategorija



/*Izvrsenje procedura*/
exec Kategorija_Insert 'Odeca'
exec Kategorija_Svi

exec StatusArtikla_Insert'da'
exec StatusArtikla_Insert 'ne'
exec StatusArtikla_Svi

exec TipKorisnik_Insert 'da'
exec TipKorisnik_Insert 'ne'
exec TipKorisnik_Svi

exec Korisnik_Insert 'Alek','Gera','12345','gera.alek@prvabeogim.edu.rs','Srbija','Beograd',N'??ukarica',11000,'Cara Dusan 61',1,'Musko'
exec Korisnici_Svi

exec Artikal_Insert 'Kozna jakna ',15,1,1,'Kozna',10,'koznajakna'

exec Artikal_Pregled

exec Artikal_Svi

Select *  from slika

exec Slika_Insert 'Proba','proba'

Delete  from Artikal

Delete  from Slika


exec Artikal_Pregled_Slika


exec Korisnik_Insert 'Maja','Gera','12345','maja_gera@yahoo.com','Srbija','Beograd',N'??ukarica',11000,'Cara Dusan 61',2,'Zensko'

exec Korisnik_Insert 'Neda','Gera','12345','neda_gera@yahoo.com','Srbija','Beograd',N'??ukarica',11000,'Cara Dusan 61',2,'Zensko'

Delete  from Korisnik

exec Kategorija_Svi


exec Artikal_Pregled_ID '14'

exec Artikal_Svi