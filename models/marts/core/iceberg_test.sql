{{ config(
    materialized='table',
    tblproperties={
        'delta.enableIcebergCompatV2': 'true',
        'delta.columnMapping.mode': 'name',
        'delta.universalFormat.enabledFormats': 'iceberg',
    },
) }}

select customer_key, market_segment
from {{ ref('dim_customers') }}
