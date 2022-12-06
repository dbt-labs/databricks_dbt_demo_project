def model(dbt, session):
    dbt.config(
        materialized = "table",
    )
    
    df = dbt.ref("agg_revenue")

    # apply our function
    # (columns need to be in uppercase on Snowpark)
    
    df = df.describe()
    # return final dataset (Pandas DataFrame)
    return df
 