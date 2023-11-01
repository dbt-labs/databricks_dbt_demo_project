import holidays

def is_holiday(date_col):
    # Chez Jaffle
    french_holidays = holidays.France()
    is_holiday = (date_col in french_holidays)
    return is_holiday

def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["holidays"]
    )

    orders_df = dbt.ref("stg_tpch_orders")

    df = orders_df.to_pandas_on_spark()  # Spark 3.2+
    # df = orders_df.toPandas() in earlier versions

    # apply our function
    df["is_holiday"] = df["order_date"].apply(is_holiday)

    # convert back to PySpark
    df = df.to_spark()               # Spark 3.2+
    # df = session.createDataFrame(df) in earlier versions

    # return final dataset (PySpark DataFrame)
    return df