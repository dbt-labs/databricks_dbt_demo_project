{{
    config(
        materialized='incremental',
        unique_key='order_id',
        cluster_id='0426-154059-dox4kjfg',
        submission_method='all_purpose_cluster',
        file_format='delta'

    )
}}

select * from {{ ref('source_schema') }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where modified_at > (select max(modified_at) from {{ this }}) 
{% endif %}


