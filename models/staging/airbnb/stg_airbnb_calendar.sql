{{ config(materialized='table') }}

with source as (

  select * from {{ source('airbnb','calendar') }}

),

renamed as (

  select
    {{ dbt_utils.generate_surrogate_key([
      'listing_id',
      'date'
    ]) }} as calendar_id,
    listing_id,
    {{ dollar_string_to_decimal('price') }} as price_in_dollars,
    {{ dollar_string_to_decimal('price') }} as adjusted_price_in_dollars,
    minimum_nights,
    maximum_nights,
    boolean(available) as is_available,
    to_date(date) as availability_date
  from source

)

select * from renamed
