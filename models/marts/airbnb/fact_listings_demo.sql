select 
    host_id,
    count(distinct listing_id) as lifetime_listings

 from {{ ref('stg_airbnb_listings') }}

 group by 1