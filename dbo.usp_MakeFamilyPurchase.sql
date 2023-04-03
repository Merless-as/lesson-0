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
        SET BudgetValue -= Bas.sum 
        FROM dbo.Family as Fam 
        JOIN (
            SELECT ID_Family, SUM(Value) as sum
            FROM dbo.Basket
            GROUP BY ID_Family
        ) as Bas
        ON Fam.ID=Bas.ID_Family
        WHERE SurName=@FamilySurName;
