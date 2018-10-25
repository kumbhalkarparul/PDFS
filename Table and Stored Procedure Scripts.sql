create database ProductDB
go

use ProductDB
go

create schema Geetha
go

create table Geetha.Category
(
CategoryId int identity(1,1) primary key,
CategoryName varchar(50) not null unique
)

insert into Geetha.Category 
values ('Watches'),('Laptops'),('Mobiles')

create table Geetha.Product
(
ProductId int identity(1,1) primary key,
ProductName varchar(25) unique not null,
[Description] varchar(250) null,
UnitPrice money not null,
Stock int not null,
Category int not null foreign key references Geetha.Category(CategoryId)
)

create proc Geetha.uspAddProduct
(
@pName varchar(25),
@descp varchar(250),
@up money,
@st int,
@cat int,
@pId int output
)
as
begin
	insert into Geetha.Product
	values(@pName,@descp,@up,@st,@cat)
	set @pId = Scope_Identity()
end

create proc Geetha.uspEditProduct
(
@pId int,
@pName varchar(25),
@descp varchar(250),
@up money,
@st int,
@cat int
)
as
begin
	update Geetha.Product
	set ProductName = @pName,[Description]=@descp,
	UnitPrice=@up,Stock=@st,Category=@cat
	where ProductId = @pid
end

create proc Geetha.uspDeleteProduct
(
@pId int
)
as
begin
	delete from Geetha.Product
	where ProductId = @pid
end

create proc Geetha.uspSearchProduct
(
@pId int
)
as
begin
	select * from Geetha.Product
	where ProductId = @pid
end

create proc Geetha.uspGetProducts
as
begin
	select * from Geetha.Product
end

create proc Geetha.uspGetCategories
as
begin
	select CategoryId,CategoryName 
	from Geetha.Category
	order by CategoryId
end

create proc Geetha.uspNextProductId
as
begin
select IDENT_CURRENT('Geetha.Product') +IDENT_Incr('Geetha.Product') 
end