        select
            _inner.*,
            row_number() over (
                partition by o_custkey
                order by o_orderdate desc
            ) as rn
        from {{ ref('source_limit') }} as _inner


-- partition by customer key and order it in the order the table is in
-- all good in code

 