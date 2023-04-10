select * 
from {{ ref('silver_query_history') }}
order by last_altered_day desc