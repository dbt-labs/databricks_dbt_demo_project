{% macro extract_month(col) %}
    month(col) + 1
{% endmacro %}