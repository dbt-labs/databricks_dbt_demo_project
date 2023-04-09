{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

select * from {{ ref('src_query_history') }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where event_time > (select max(event_time) from {{ this }}) 
{% endif %}