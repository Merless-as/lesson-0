CREATE PROC MakeFamilyPurchase (@FamilySurName varchar(255))
    AS
    IF (@FamilySurName NOT IN (
        SELECT SurName
        FROM dbo.Family
        )
    )
        BEGIN
            RAISERROR (N'No such dbo.Family.SurName exists', 
            10, 
            1
            );
        END;
    ELSE 
        UPDATE dbo.Family 
        SET BudgetValue = (
            SELECT SUM(dbo.Basket.Value) 
            FROM dbo.Basket, dbo.Family 
            WHERE dbo.Family.SurName=@FamilySurName
        )
        WHERE SurName=@FamilySurName;
