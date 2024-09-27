{% snapshot orders_snapshot %}
    {{
        config(
            unique_key='o_orderkey',
            strategy='check',
            check_cols='all',
            target_schema='dbt_lbondkennedy'
        )
    }}

    select * from {{ source('tpch', 'orders') }}
 {% endsnapshot %}