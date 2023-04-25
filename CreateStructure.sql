create table dbo.SKU  
(
    ID int identity(1, 1) primary key
    ,Code as ('s'+ cast(ID as varchar(12))) unique
    ,Name varchar(20)
);

create table dbo.Family 
(
    ID int identity(1, 1) primary key
    ,SurName varchar(20)
    ,BudgetValue money
);

create table dbo.Basket 
(
    ID int identity(1, 1)
    ,ID_SKU int foreign key references dbo.SKU(ID) on delete cascade
    ,ID_Family int foreign key references dbo.Family(ID) on delete cascade
    ,Quantity float check (Quantity >= 0)
    ,Value float check (Value >= 0)
    ,PurchaseDate date default (sysdatetime())
    ,DiscountValue float
);
