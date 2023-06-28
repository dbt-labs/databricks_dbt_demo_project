{{
    config(
        materialized='table'
    )
}}

select 
country, 
year,
  {{ dbt_utils.pivot(
      'gho',
      dbt_utils.get_column_values(ref('fct_health_indicators'), 'gho')
  , agg='sum'
  , then_value='value'
  , else_value='null') }}

from {{ ref('fct_health_indicators') }}
group by country, year