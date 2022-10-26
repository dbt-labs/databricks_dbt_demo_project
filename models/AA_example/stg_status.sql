{{
    config(
        docs={'node_color': '#CD7F32'}
    )
}}

SELECT

     status_code
    ,status_name

FROM {{ ref('status') }}