with 

source as (

      select * from {{ source('registrations', 'tier_subscriptions') }}
)

/* renaming the columns in from this source table to match the _ syntax used
by the acorns schema for consistency and future joins on user_id.
Staging models are also a great way to standardize date formats, timezones, etc */
,
renamed as (
select
billingfrequency as billing_frequency,
tiergroupid as tiergroup_id,
userid as user_id,
transitionaction as transition_action,
createdat as create_date,
pricecurrency as price_currency,
tierid as tier_id,
tierpriceid as tier_price_id,
createdby as created_by,
priceamount as price_amount,
tierkey as tier_key,
updatedat as update_date,
promotionid as promotion_id,
promotionappliedat as promotion_applied_date
from source
)

select * from renamed

