{{
    config(
        materialized='table'
    )
}}

select
    manufacturer,
    count(part_key) as partsTotal
from {{ ref("stg_tpch_parts") }}
group by 1
