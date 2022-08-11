select
    distinct data.*
from {{ ref('source_limit') }} as data


-- there are no duplicate rows from the source data, so it returns the same amount of rows
-- rows are re-ordered