with source as (

    select * from {{ source('tpch', 'part') }}

),

renamed as (

    select
    
        p_name as name,
        p_mfgr as manufacturer,
        p_brand as brand,
        p_type as type,
        p_size as size,
        p_container as container,
        p_retailprice as retail_price,
        p_retailprice * 2 as retail_price_euro,
        p_comment as comment

    from source

)

select * from renamed