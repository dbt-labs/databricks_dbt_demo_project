{% macro dollar_string_to_decimal(column_name) -%}
CAST(regexp_replace({{ column_name }}, '\\$', '') AS DECIMAL(16, 2))
{%- endmacro %}
