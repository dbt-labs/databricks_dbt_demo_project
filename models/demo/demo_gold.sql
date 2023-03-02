{{ config(materialized="table") }}

select
    customer_id,
    count(distinct order_id) as lifetime_orders,
    sum(price) as lifetime_value
from {{ ref("demo_silver_orders") }}
group by 1
