{{
    config(
        materialized='incremental',
        unique_key='nation_key'
    )
}}

with source as (

    select * from {{ source('tpch', 'nation') }}

),

renamed as (

    select
    
        n_nationkey as nation_key,
        'my_field' as ernesto_field,
        n_name as name,
        n_regionkey as region_key,
        n_comment as comment

    from source

)

select * from renamed