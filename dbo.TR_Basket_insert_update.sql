CREATE TRIGGER TR_Basket_insert_update ON dbo.Basket
AFTER INSERT
AS

UPDATE dbo.Basket
SET DiscountValue = Value * 0.05
WHERE  ID_SKU IN (
                    SELECT  ID_SKU
                    FROM inserted
                    GROUP BY ID_SKU
                    HAVING COUNT(Value) > 1
                );

UPDATE dbo.Basket
SET DiscountValue = 0
WHERE  ID_SKU IN (
                    SELECT  ID_SKU
                    FROM inserted
                    GROUP BY ID_SKU
                    HAVING COUNT(Value) < 2
                );
