CREATE TRIGGER TR_Basket_insert_update ON dbo.Basket
AFTER INSERT
AS

DECLARE @ROWS INT;
SET @ROWS = @@ROWCOUNT;

IF EXISTS ( 
            SELECT  ID_SKU
            FROM inserted
            GROUP BY ID_SKU
            HAVING COUNT(Value) > 1
            )
    BEGIN
    UPDATE dbo.Basket
    SET DiscountValue = Value * 0.05
    WHERE ID IN (
                SELECT TOP (@ROWS) ID
                FROM dbo.Basket 
                ORDER BY ID DESC
            )
            AND ID_SKU IN (
                SELECT  ID_SKU
                FROM inserted
                GROUP BY ID_SKU
                HAVING COUNT(Value) > 1
            );
    END;
ELSE
    BEGIN 
    UPDATE dbo.Basket
    SET DiscountValue = 0
    WHERE ID IN (
                SELECT TOP (@ROWS) ID
                FROM dbo.Basket 
                ORDER BY ID DESC
            );
    END;
    
   
   
   
-- version 2

CREATE TRIGGER TR_Basket_insert_update ON dbo.Basket
AFTER INSERT
AS

UPDATE dbo.Basket
SET DiscountValue = (
    CASE 
        WHEN EXISTS ( 
            SELECT  ID_SKU
            FROM inserted
            GROUP BY ID_SKU
            HAVING COUNT(Value) > 1
            )
            Then Value * 0.05
        ELSE 0
    END
)
WHERE ID_SKU IN (
        SELECT ID_SKU
        FROM  inserted
);
