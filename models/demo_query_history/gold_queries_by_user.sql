{{
    config(
        docs={'node_color': 'gold'}
    )
}}

with table_times_altered as (
    select * from {{ ref('silver_query_history') }}
)

select
    table_name,
    last_altered_by,
    times_altered,
    dense_rank() over (partition by table_name order by times_altered) as rank
from table_times_altered
group by 1, 2,3
