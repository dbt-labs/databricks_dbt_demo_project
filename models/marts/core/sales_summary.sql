
select
    sum(gross_item_sales_amount) as sales,
    customer_key,
    supplier_key,
    year(order_date) as year
from {{ ref('fct_order_items') }}
group by 2,3,4
