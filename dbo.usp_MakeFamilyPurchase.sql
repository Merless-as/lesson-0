create proc MakeFamilyPurchase (@FamilySurName varchar(255))
    as
    if (@FamilySurName not in (
            select SurName
            from dbo.Family
        )
    )
        begin
            raiserror (N'No such dbo.Family.SurName exists'
                       ,10
                       ,1
            );
        end;
    else 
        begin
            with cte as (
                select 
                    ID_Family
                    ,SUM(Value) as sum
                from dbo.Basket
                where SurName=@FamilySurName
                group by ID_Family
            )
            
            update Fam 
            set BudgetValue -= cte.sum 
            from dbo.Family as Fam 
                join cte on Fam.ID=cte.ID_Family;
        end;
