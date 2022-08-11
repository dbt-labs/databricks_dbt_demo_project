{{ dbt_utils.deduplicate(
    relation=ref('source_limit'),
    partition_by='o_custkey',
    order_by='o_orderdate desc',
   )
}}