select 
sum(price_paid) as ltv,
customer_id 

 from {{ ref('staging_orders') }}
 group by 2