select	region,
	nation,	
    market_segment,
 --   avg(account_balance) as avg_act_balance
    avg(account_balance) as act_balanceqa
from {{ ref('dim_customers') }}
group by 1, 2, 3