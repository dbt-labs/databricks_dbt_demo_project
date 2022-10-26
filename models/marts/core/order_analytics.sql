 with
    customers as (select * from {{ ref("dim_customers") }}),

    orders as (select * from {{ ref("fct_orders") }})

select

    customers.name,
    customers.account_balance,
    orders.gross_item_sales_amount,
    orders.order_date as dt

from customers


left join orders on customers.customer_key = orders.customer_key