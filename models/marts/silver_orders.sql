select 
customer_id, 
sum(price) as lifetime_value
from {{ ref("bronze_orders") }}
group by 1
