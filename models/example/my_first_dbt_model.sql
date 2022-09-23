
select 
    1 as id,
    2 as sale_amount,
    (3 / 4) * 100 as payment_amount

union all

select 
    2 as id,
    5 as sale_amount,
    (1 / 3) * 100 as payment_amount
   

