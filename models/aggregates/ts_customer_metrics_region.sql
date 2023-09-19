with customers as (

    select *
    from {{ ref('dim_customers') }}

), orders as (

    select *
    from {{ ref('fct_orders') }}

), sources__joined as (

    select  
        customers.nation
        ,customers.region
        ,customers.market_segment
        ,orders.order_date
        ,sum(order_count) as order_count
        ,sum(orders.net_item_sales_amount) as revenue
    from customers
    join orders
        on customers.customer_key = orders.customer_key
    {{ dbt_utils.group_by(4) }}

)

select *
from sources__joined
