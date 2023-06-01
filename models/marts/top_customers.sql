select * 
from {{ ref('stg_tpch_customers') }}
order by account_balance desc 
limit 100