
select * 
from {{ ref('dim_listings') }} 
where num_beds < 1