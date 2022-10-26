SELECT 

     status_code
    ,status_name

FROM {{ ref('status') }}