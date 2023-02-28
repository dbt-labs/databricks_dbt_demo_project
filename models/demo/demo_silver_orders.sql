select 
 o_orderkey as order_id,
 o_custkey as customer_id,
 o_totalprice{{ money(o_totalprice) }} as price 
from {{ source('tpch', 'orders') }}