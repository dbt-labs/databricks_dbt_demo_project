with 

source as (

    select * from {{ source('samples', 'customer') }}

),

renamed as (

    select
        c_custkey as customer_key,
        c_name,
        c_address,
        c_nationkey,
        c_phone,
        c_acctbal,
        c_mktsegment,
        ltrim(rtrim(c_comment)) as comment

    from source

)

select * from renamed
