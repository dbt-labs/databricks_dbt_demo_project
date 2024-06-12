{{
    config(
        materialized='table'
    )
}}

select
    manufacturer,
    count(part_key) as total
from {{ ref('stg_tpch_parts') }}
group by 1
