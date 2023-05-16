

select 
o_orderkey as order_id,
o_custkey as customer_id,
{{money('o_totalprice')}} as price_paid,
o_orderdate as date
  
from {{ source('tpch', 'orders') }}