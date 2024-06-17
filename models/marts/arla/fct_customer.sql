{{
    config(
        materialized='incremental',
        unique_key='customer_key'
    )
}}


select 
    orders.customer_key,
    count(distinct orders.order_key) as lifetime_orders,
    max(customer.account_balance) as current_account_balance

from {{ ref('stg_tpch_orders') }} orders
left join {{ ref('dim_customers') }} customer on orders.customer_key = customer.customer_key
group by 1