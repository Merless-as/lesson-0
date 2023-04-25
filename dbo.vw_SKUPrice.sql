CREATE ViEW SKUPrice AS
    SELECT 
        ID
        ,Code
        ,Name
        ,dbo.GetSKUPrice(ID) AS Price
    FROM dbo.SKU;
