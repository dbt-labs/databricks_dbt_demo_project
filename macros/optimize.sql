{% macro set_auto_optimize() %}
  set spark.databricks.delta.properties.defaults.autoOptimize.optimizeWrite = true;
  set spark.databricks.delta.properties.defaults.autoOptimize.autoCompact = true;
{% endmacro %}