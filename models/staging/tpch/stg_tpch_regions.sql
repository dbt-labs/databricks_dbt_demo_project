with source as (

    select * from {{ source('tpch', 'region') }}

),

rename as (

    select
    
        r_regionkey as region_key,
        -- r_name as name,
        r_comment as comment

    from source

)

select * from rename