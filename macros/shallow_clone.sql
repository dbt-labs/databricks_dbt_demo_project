{% macro shallow_clone() %}

{% set sql %}
    {% do log(target.schema, info=true) %}
    CREATE OR REPLACE TABLE dbt_isobral.my_test SHALLOW CLONE dbt_isobral.order_items;

{% endset %}

{% do run_query(sql) %}


{% endmacro %}


