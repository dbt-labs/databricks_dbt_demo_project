with fct_orders as (
    select * from `sa_dev`.`dbt_isobral`.`fct_orders`
)


select 
    date_trunc('MONTH', fct_orders.order_date) as order_month
    , sum(fct_orders.gross_item_sales_amount) as gross_revenue
from fct_orders
group by 1