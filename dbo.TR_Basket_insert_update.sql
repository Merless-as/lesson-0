create trigger TR_Basket_insert_update on dbo.Basket
after insert 
as

with cte as (
    select
        ID_SKU
        ,count(*) as count_value
    from inserted
    group by ID_SKU
)

update dbo.Basket
set DiscountValue = (
    case 
        when count_value > 1 
            then b.Value * 0.05
        else 0
    end
)
from dbo.Basket as b
    join cte on cte.ID_SKU=b.ID_SKU
    join inserted as i on i.ID=b.ID;
