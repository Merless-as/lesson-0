create view SKUPrice as
    select
        ID
        ,Code
        ,Name
        ,dbo.GetSKUPrice(ID) as Price
    from dbo.SKU;
