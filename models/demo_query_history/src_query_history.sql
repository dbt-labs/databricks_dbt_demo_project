{{ config(
    docs={"node_color": "#CD7F32"}
) }}

select
    table_catalog,
    table_schema,
    table_name,
    table_type,
    table_owner,
    created,
    created_by,
from system.information_schema.tables
order by last_altered desc
