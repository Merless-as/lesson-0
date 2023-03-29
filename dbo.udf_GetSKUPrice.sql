CREATE FUNCTION GetSKUPrice ( @ID_SKU AS INT )
RETURNS decimal(18, 2)
AS

BEGIN
    DECLARE @Cost decimal(18, 2);
    SELECT @Cost = b.Value/b.Quantity
    FROM dbo.Basket as b
    WHERE b.ID_SKU=@ID_SKU;
    RETURN @Cost;
END;