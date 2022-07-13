{{
    config(
        materialized='table'
    )
}}

with top_customer as (

    select customer_key,
           sum(gross_item_sales_amount) as total
    from {{ ref('fct_orders') }}
    group by customer_key
    order by total
    limit 10
)

select top_customer.*, customers.name
from top_customer
inner join {{ ref('stg_tpch_customers') }} customers
on top_customer.customer_key = customers.customer_key
order by total