
{{
    config(
        materialized='incremental',
        unique_key='id'
    )
}}

select * from {{ ref('stg_tpch_line_items') }}