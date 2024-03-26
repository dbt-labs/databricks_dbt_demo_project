select 
    orders.*,
    customer.nation,
    customer.region

from {{ ref('fct_orders') }} orders left join {{ ref('dim_customers') }} customer
on orders.customer_key = customer.customer_key