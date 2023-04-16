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
        Begin
            WITH cte AS (
                SELECT ID_Family, SUM(Value) as sum
                FROM dbo.Basket
                WHERE SurName=@FamilySurName
                GROUP BY ID_Family
            )
            UPDATE Fam 
            SET BudgetValue -= cte.sum 
            FROM dbo.Family as Fam 
            JOIN cte 
            ON Fam.ID=cte.ID_Family;
        END;
