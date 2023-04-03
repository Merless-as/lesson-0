CREATE FUNCTION GetSKUPrice ( @ID_SKU AS INT )
RETURNS TABLE
AS

BEGIN
    DECLARE @Price DECIMAL(18, 2);
    SELECT @Price = SUM(b.Value/b.Quantity)
    FROM dbo.Basket as b
    WHERE b.ID_SKU=@ID_SKU;
    RETURN @Price;
END;
