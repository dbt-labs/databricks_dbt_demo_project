{% macro databricks_format_column(column_name) %}
   
   {{ return(column_name.replace('"', ''))}}

{% endmacro %}