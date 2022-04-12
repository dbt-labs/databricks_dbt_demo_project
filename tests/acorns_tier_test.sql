
select * 
from {{ref('dim_current_tier')}}
where subscription_rank < 1
