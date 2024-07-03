

select total_sales
from {{ ref('sales_summary') }}
where total_sales < 0