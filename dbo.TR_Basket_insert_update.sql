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
