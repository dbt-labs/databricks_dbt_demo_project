-- SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment
-- FROM {{ source('tpch', 'orders') }}
-- where o_custkey BETWEEN 749998 and 749999
-- UNION
-- SELECT 14982693, 749999, 'F', 63787.83, '1992-05-27','4-NOT SPECIFIED','Clerk#0000024260e',0,'e furiously special, bold deposits'



SELECT o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment, NVL(loaded_at, '1900-00-24') loaded_at
FROM {{ source('tpch', 'orders') }}
where o_custkey BETWEEN 749998 and 749999
