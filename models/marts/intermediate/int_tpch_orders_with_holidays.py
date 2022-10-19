import holidays

def is_holiday(date_col):
    us_holidays = holidays.US()
    is_holiday = (date_col in us_holidays)
    return is_holiday

def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["holidays"] #import pypi holidays package
        create_notebook=True # writes to /Shared/dbt_python_model/
    )

    orders_df = dbt.ref("stg_tpch_orders")

    df = orders_df.to_pandas_on_spark() 

    # apply our function
    df["is_holiday"] = df["order_date"].apply(is_holiday)

    # convert back to PySpark
    df = df.to_spark()             

    # return final dataset (PySpark DataFrame)
    return df