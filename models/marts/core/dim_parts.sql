{{
    config(
        materialized = 'table'
    )
}}
with part as (

    select * from {{ref('stg_tpch_parts')}}

),

final as (
    select 
        part_key,
        manufacturer,
        name,
        brand,
        type,
        size,
        container,
        retail_price,
        size_category
    from
        part
)
select *
from final  
order by part_key