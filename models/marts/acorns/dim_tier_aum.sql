with

aum_base as (

    select * from {{ref('dim_product_aum_base')}}

),

current_tier as (
    select * from {{ref('dim_current_tier')}}
)

,

joined as (
select * 
from aum_base 
left join current_tier
on aum_base.user_uuid = current_tier.user_id
) 


select * from joined
