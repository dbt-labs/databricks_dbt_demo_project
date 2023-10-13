{{ config(materialized='table') }}

with source as (

  select * from {{ source('airbnb','neighbourhoods') }}

),

renamed as (

  select
    {{ dbt_utils.generate_surrogate_key([
        'neighbourhood'
    ]) }} as neighborhood_id,
    neighbourhood_group as neighborhood_group,
    neighbourhood as neighborhood_name
  from source

)

select * from renamed
