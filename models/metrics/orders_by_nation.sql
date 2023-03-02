with orders as (

    select * from {{ ref('fct_orders') }}

), customers as (

    select * from {{ ref('dim_customers') }}

), final as (

    select
        orders.*,
        customers.nation
    from orders
    left join customers on orders.customer_key = customers.customer_key

)

select * from final
