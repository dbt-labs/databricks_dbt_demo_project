{{
    config(
        materialized='table'
    )
}}

with raw_indicators as (
    select * from {{ ref('stg_health_indicators') }}
)
,
cleaned_indicators as (
    select *
    from raw_indicators
    where 
--removing codes related to life expectancy since that is what we want to predict
    GHO_CODE != "WHOSIS_000015"
    and PUBLISHSTATECODE  = "PUBLISHED"
    and STARTYEAR > 2000
)
, final as (
    select 
    GHO_CODE as GHO,
    STARTYEAR as year,
    COUNTRY_CODE as country,
    nvl(numeric , Display_Value ) as value
    from cleaned_indicators
    where Display_Value > 0 
)

select 
gho,
year,
country,
avg(value) as value
from final
group by gho, year, country
order by year desc
