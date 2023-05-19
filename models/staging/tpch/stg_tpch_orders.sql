with source as (

    select * from {{ source('tpch', 'orders') }}

),


renamed as (

    select
    
        o_orderkey as order_key,
        o_custkey as customer_key,
        o_orderstatus as status_code,
        cast((dateadd(year,20,o_orderdate)) as DATE) as order_date,
        o_orderpriority as priority_code,
        o_clerk as clerk_name,
        o_shippriority as ship_priority,
        o_comment as comment

    from source

)

select * from renamed
limit 100000