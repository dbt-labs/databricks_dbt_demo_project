
with row_numbered as (
        select
            _inner.*,
            row_number() over (
                partition by o_custkey
                order by o_orderdate desc
            ) as rn
        from dbt_isobral.source_limit as _inner
    )

    select
        distinct data.*
    from dbt_isobral.source_limit as data
    
    natural join row_numbered
    where row_numbered.rn = 1
limit 500