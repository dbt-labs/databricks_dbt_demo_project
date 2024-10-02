{{
    config(
        materialized = 'incremental',
        unique_key = 'order_key'
    )
}}

SELECT *
FROM {{ ref('fct_orders') }}
{% if is_incremental() %}
    WHERE order_date > (SELECT MAX(order_date) FROM {{ this }})
{% endif %}
