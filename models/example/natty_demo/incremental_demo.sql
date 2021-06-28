{{ config(materialized = 'incremental', unique_key='id') }}

select id, date_day
from {{ ref('incremental_source') }}

{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
  where date_day >= (select max(date_day) from {{ this }})
{% endif %}