with agg_listings as (

  select

  neighborhood_cleansed,
  count(listing_id) as total_listings

  from {{ ref('stg_airbnb_listings') }}
  group by 1

),

neighborhoods as (

  select * from {{ ref('stg_airbnb_neighborhoods') }}

),

joined as (

  select

  neighborhoods.*,
  total_listings

  from neighborhoods
  left join agg_listings

)

select * from joined