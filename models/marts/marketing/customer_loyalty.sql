with cust as (

    select *     
    from {{ ref('dim_customers') }}

)

, ord as (

  select *     
   from {{ ref('fct_orders') }}

)

, cust_ord as ( 

    select c.customer_key, sum(net_item_sales_amount) as total_price_usd 
            from ord o 
            inner join cust c 
            on o.customer_key = c.customer_key
            where true 
            group by 1

)

, business_logic as (
select 
  customer_key
, case when total_price_usd >= 3500000 then 'gold'
       when total_price_usd between 2000000 and 3499999 then 'silver'
       else 'bronze'
   end as medallion_level
,  round(total_price_usd / 10000) as points_amount

   from cust_ord 
)

select * from business_logic
