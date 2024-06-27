select
    count(distinct fct_orders.order_key) as lifetime_orders,
    sum(gross_item_sales_amount) as lifetime_value,  -- this is the LTV which includes returns
    dim_customers.customer_key
from {{ ref("fct_orders") }} fct_orders
left join
    {{ ref("dim_customers") }} dim_customers
    on fct_orders.customer_key = dim_customers.customer_key

group by 3
