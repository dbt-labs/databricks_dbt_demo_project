select o_orderkey as order_id, o_custkey as customer_id, o_totalprice as price_paid
from {{ source("tpch", "orders") }}
