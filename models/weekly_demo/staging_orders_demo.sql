select 

o_orderkey as order_key,
o_custkey as customer_key,
o_totalprice as price_paid

from {{ source('tpch', 'orders') }}