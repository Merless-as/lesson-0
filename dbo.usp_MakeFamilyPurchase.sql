CREATE PROC MakeFamilyPurchase (@FamilySurName varchar(255))
    AS
    IF (@FamilySurName NOT IN (
        SELECT SurName
        FROM dbo.Family
        )
    )
        PRINT N'No such dbo.Family.SurName exists';
    ELSE 
        UPDATE dbo.Family 
        SET BudgetValue = (
            SELECT SUM(Value) 
            FROM dbo.Basket
            WHERE dbo.Basket.ID_Family=(
                SELECT ID 
                FROM dbo.Family
                WHERE SurName=@FamilySurName
            )
    );
