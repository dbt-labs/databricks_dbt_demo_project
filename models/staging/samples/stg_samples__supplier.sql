{{
    config(
        materialized='incremental',
        unique_key='supplier_key'
    )
}}
with 

source as (

    select * from {{ source('samples', 'supplier') }}

),

renamed as (

    select
        s_suppkey as supplier_key,
        s_name,
        s_address,
        s_nationkey,
        s_phone,
        s_acctbal,
        ltrim(rtrim(s_comment)) as comment

    from source

)

select * from renamed

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where supplier_key > (select max(supplier_key) from {{ this }}) 
{% endif %}