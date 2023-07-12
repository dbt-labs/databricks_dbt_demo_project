{{
    config(
        materialized='incremental',
        unique_key='order_id',
        on_schema_change= "sync_all_columns"
    )
}}

select * from {{ ref('source_schema') }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where modified_at > (select max(modified_at) from {{ this }}) 
{% endif %}


