with 

source as (

      select * from {{ ref('stg_registrations_tier_subscriptions') }}
)

select
    user_id,
    price_amount as current_tier,
    rank() over (partition by user_id order by create_date desc ) as subscription_rank
from source
where price_amount != 0