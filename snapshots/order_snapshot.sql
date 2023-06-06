{% snapshot query_snapshot %}

{{
    config(
      target_database='sa_dev',
      target_schema='dbt_isobral',
      unique_key="table_name||'-'||to_date(last_altered)",
      strategy='timestamp',
      updated_at='last_altered::timestamp',
    )
}}

select * from {{ source('dbt_isobral', 'src_query_history') }}

{% endsnapshot %}

