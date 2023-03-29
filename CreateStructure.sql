CREATE TABLE dbo.SKU  
(
    ID INT IDENTITY(1, 1) PRIMARY KEY, 
    Code AS ('s'+ CAST(ID AS VARCHAR(12))) UNIQUE, 
    Name VARCHAR(20)
);

CREATE TABLE dbo.Family 
(
    ID INT IDENTITY(1, 1) PRIMARY KEY, 
    SurName VARCHAR(20), 
    BudgetValue MONEY
);

CREATE TABLE dbo.Basket 
(
    ID INT IDENTITY(1, 1), 
    ID_SKU INT FOREIGN KEY REFERENCES dbo.SKU(ID) ON DELETE CASCADE, 
    ID_Family INT FOREIGN KEY REFERENCES dbo.Family(ID) ON DELETE CASCADE, 
    Quantity FLOAT CHECK (Quantity >= 0), 
    Value FLOAT CHECK (Value >= 0), 
    PurchaseDate DATE DEFAULT (SYSDATETIME()), 
    DiscountValue FLOAT
);
