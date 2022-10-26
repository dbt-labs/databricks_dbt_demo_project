SELECT 
         o.o_orderkey as order_number
        ,e.status_name as status_name
        ,o.o_totalprice as revenue

FROM {{ source('tpch', 'orders') }} o

JOIN {{ ref('stg_status') }} e on status_code = status_code
