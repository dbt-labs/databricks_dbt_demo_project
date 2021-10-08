{{ config(
    materialized='view')
}}

select concat(hi_there, ", and Natty!") as hi_there_natty --, nonexistent_col
from {{ ref('simple_model') }}