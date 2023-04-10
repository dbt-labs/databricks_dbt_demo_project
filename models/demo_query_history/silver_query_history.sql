{{
    config(
        materialized="incremental",
        unique_key=["table_name", "last_altered_day"],
        incremental_predicates=[
            "DBT_INTERNAL_DEST.last_altered_day > date_sub(current_date(), 7)"
        ],
        docs={"node_color": "silver"},
    )
}}

with query_history as (
    select * from {{ ref('src_query_history') }}
)

select
    table_name,
    last_altered_by,
    to_date(last_altered) as last_altered_day,
    count(to_date(last_altered)) as times_altered
from query_history
group by 1, 2, 3
{% if is_incremental() %}
-- this filter will only be applied on an incremental run
having last_altered_day >= (select max(last_altered_day) from {{ this }})
{% endif %}

