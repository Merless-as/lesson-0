CREATE ViEW SKUPrice AS
    SELECT ID, Code, Name, dbo.GetSKUPrice(ID) 
    FROM dbo.SKU;


