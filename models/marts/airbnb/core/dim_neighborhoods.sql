{{ config(materialized='table') }}
 
with neighborhoods as (
 
    select * from {{ ref('stg_airbnb_neighborhoods') }}
 
),
 
listings as (
 
  select * from {{ref('stg_airbnb_listings')}}
 
),
 
agg_listings as (
 
  select 
 
  neighborhood_cleansed,
  count(listing_id) as total_listings
 
from listings 
group by 1
 
),
 
joined as (
 
  select 
 
  neighborhoods.*,
  total_listings
 
  from neighborhoods
  left join agg_listings 
  on neighborhoods.neighborhood_name = agg_listings.neighborhood_cleansed
 
)
 
 
select * from joined
 
 
 

