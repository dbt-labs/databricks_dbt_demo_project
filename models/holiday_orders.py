import holidays
import pyspark

def is_holiday(date_col):
    # Define holiday parameters
    french_holidays = holidays.France()
    is_holiday = (date_col in french_holidays)
    return is_holiday

def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["holidays"] #import pythin libraries into dbt context
    )
    
    orders_df = dbt.ref("stg_tpch_orders")
    
    df = orders_df.to_pandas()
    
    # apply our function
    # (columns need to be in uppercase on Snowpark)
    df["IS_HOLIDAY"] = df["ORDER_DATE"].apply(is_holiday)
    
    # return final dataset (Pandas DataFrame)
    return df
