{% snapshot orders %}
    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='order_key',
          check_cols=['order_date', 'priority_code'],
        )
    }}

    select * from {{ ref('fct_orders') }}
 {% endsnapshot %}