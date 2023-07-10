{{ config(materialized="table") }}

select
    1 as order_id,
    1 as customer_id,
    'cancelled' as status,
    cast('2018-01-01' as date) as order_date,
    cast('2018-01-01' as date) as modified_at

union select
    2 as order_id,
    1 as customer_id,
    'completed' as status,
    cast('2018-01-02' as date) as order_date,
    cast('2018-01-02' as date) as modified_at

-- -- add a new record
-- union select
--     '3' as order_id,
--     '2' as customer_id,
--     'completed' as status,
--     cast('2018-01-03' as date) as order_date,
--     cast('2018-01-03' as date) as modified_at

-- -- -- add a record that conflicts with a previous order_id
-- union select
--     '1' as order_id,
--     '1' as customer_id,
--     'completed' as status,
--     cast('2018-01-01' as date) as order_date,
--     cast('2018-01-04' as date) as modified_at


{# dbt run-operation drop_vignette_tables --args '{tables_to_drop: [inc_orders,orders_snapshot]}' #}