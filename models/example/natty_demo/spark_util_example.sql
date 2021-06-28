{{ config(materialized='view') }}

with source_data as (

    select 1 as id, 'this is a string' as string_col
    union all
    select 1 as id, 'this is another string' as string_col

), 

with_surrogate as (
    select 
      {{ dbt_utils.surrogate_key(['id']) }} as surrogate,
      id,
      string_col
    from source_data

)

select *
from with_surrogate
