{% macro deprecate_generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- set target_database = target.database -%}

    {%- if (target.name == 'prod' or target.name == 'qa') and custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}
    {%- else -%}

        {%- if default_database | trim == '' -%}
            hive_metastore.{{ custom_schema_name | trim }}
        {%- else -%}
            {{ target_database }}.{{ default_schema }}
        {%- endif -%}

    {%- endif -%}

{%- endmacro %}