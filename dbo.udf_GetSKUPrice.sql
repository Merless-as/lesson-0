CREATE FUNCTION GetSKUPrice ( @ID_SKU AS INT )
RETURNS TABLE
AS

RETURN (
    SELECT CAST(b.Value/b.Quantity AS DECIMAL(18, 2)) as Price
    FROM dbo.Basket as b
    WHERE b.ID_SKU=@ID_SKU
);
