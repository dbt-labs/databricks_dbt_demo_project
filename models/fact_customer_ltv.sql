{{ config(materialized="incremental", file_format="delta", unique_key="customer_id") }}

select
    customer_id,
    sum(price_paid) as lifetime_value,
    count(distinct order_id) as lifetime_order_placed

from {{ ref("staging_orders") }}

group by 1
