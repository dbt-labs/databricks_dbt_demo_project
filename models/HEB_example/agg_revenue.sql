{{
    config(
        docs={'node_color': 'gold'}
    )
}}

SELECT
    status_name
    ,sum(revenue) as total_revenue

FROM {{ ref('revenue') }}
GROUP BY 
    status_name