{% set old_etl_relation_query %}
    select * from dbt_isobral.order_items
{% endset %}

{% set new_etl_relation_query %}
    select * from {{ ref('stg_tpch_orders') }}
{% endset %}

{% set audit_query = audit_helper.compare_column_values(
    a_query=old_etl_relation_query,
    b_query=new_etl_relation_query,
    primary_key="order_key",
    column_to_compare="order_key"
) %}

{{ audit_query }}