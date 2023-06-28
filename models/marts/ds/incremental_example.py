import pyspark.sql.functions as F

def model(dbt, session):
    dbt.config(materialized = "incremental",
    cluster_id="0426-154059-dox4kjfg")
    df = dbt.ref("stg_tpch_orders")

    if dbt.is_incremental:

        # only new rows compared to max in current table
        max_from_this = f"select max(order_date) from {dbt.this}"
        df = df.filter(df.order_date >= session.sql(max_from_this).collect()[0][0])

    return df