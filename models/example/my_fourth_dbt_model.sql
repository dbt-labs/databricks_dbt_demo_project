
-- Use the `ref` function to select from other models

select *
from {{ ref('my_third_dbt_model') }}
where id = 1
