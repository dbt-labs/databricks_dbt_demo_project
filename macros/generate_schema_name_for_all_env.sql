{% macro generate_schema_name_for_all_env(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if (target.name == 'prod' or target.name == 'qa') and custom_schema_name is not none -%}

        {{ custom_schema_name | trim }}

    {%- else -%}

        {{ default_schema }}

    {%- endif -%}

{%- endmacro %}