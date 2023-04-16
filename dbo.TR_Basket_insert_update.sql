CREATE TRIGGER TR_Basket_insert_update ON dbo.Basket
AFTER INSERT
AS

WITH cte AS (
    SELECT ID_SKU, COUNT(*) as count_value
    FROM inserted
    GROUP BY ID_SKU
)

UPDATE dbo.Basket
SET DiscountValue = (
    CASE 
        WHEN count_value > 1 
            Then b.Value * 0.05
        ELSE 0
    END
)
FROM dbo.Basket as b
JOIN cte 
ON cte.ID_SKU=b.ID_SKU
JOIN inserted as i
ON i.ID=b.ID;
