{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='customer_key'
    )
}}
select 

customer_key,
sum(price_paid) as lifetime_value,
count(distinct order_key) as lifetime_orders

from {{ ref('staging_orders_demo') }}
group by 1