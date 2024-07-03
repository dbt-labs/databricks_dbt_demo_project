{{
    config(
        materialized='table',
        tags=['summary','sales']
    )
}}


select
    sum(net_item_sales_amount) as total_sales,
    date_trunc('MM', order_date) as m
from {{ ref('fct_orders') }} orders
inner join {{ ref('dim_customers') }} customers
on orders.customer_key == customers.customer_key
group by m