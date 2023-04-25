create function GetSKUPrice ( @ID_SKU AS INT )
returns decimal(18, 2)
as

begin
    declare @Price decimal(18, 2);
    
    select 
        @Price = sum(b.Value/b.Quantity)
    from dbo.Basket as b
    where b.ID_SKU=@ID_SKU;
    
    return @Price;
end;
