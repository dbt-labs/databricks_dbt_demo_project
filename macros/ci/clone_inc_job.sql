-- configure this as a pre-hook 

-- tpch:
   --  +pre-hook:
    --   - " {{ clone_inc_job(from_db='production_db', from_schema='production_schema') }} "

{% macro clone_inc_job(from_db, from_schema) %}

{%- if execute -%}

    {%- if target.name == 'continuous_integration' and model.config.materialized == 'incremental' -%}

        {%- for node in graph.nodes.values() -%}
            {%- if node.resource_type == 'model' -%}
                {%- set from_relation = (adapter.get_relation(database=from_db, schema=from_schema, identifier=node.name)) -%} 
                
                {%- if from_relation.is_table -%}
                -- CLONING DDL
                create or replace table {{ target.database }}.{{ generate_schema_name(custom_schema_name = node.config.schema, node = node.name) }}.{{ node.name }} clone {{ from_db }}.{{ from_schema }}.{{ node.name }};
                {% do log("Cloned incremental model " ~ from_db ~ "." ~ from_schema ~ "." ~ node.name ~ " into target schema.", info=true) %}
                
                {%- endif -%}
            {%- endif -%}
            
        {%- endfor -%}

        select 1;

    {%- else -%}

    select 2; {# hooks will error if they dont have valid SQL in them, this handles that! #}

    {%- endif -%}

{%- endif -%}

{% endmacro %}