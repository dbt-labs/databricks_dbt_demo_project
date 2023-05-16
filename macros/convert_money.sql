{% macro money(col) -%}
{{col}}::decimal(16,4)
{%- endmacro %}

