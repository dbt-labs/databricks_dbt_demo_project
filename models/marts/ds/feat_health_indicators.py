import pandas as pd

def model(dbt, session):

    dbt.config(materialized="table",
        submission_method="all_purpose_cluster",
        create_notebook=True,
        cluster_id="0426-154059-dox4kjfg")
  
    my_sql_model_df = dbt.ref("fct_health_indicators_pivot")
    
    input_pd = my_sql_model_df.orderBy("year").toPandas()
    input_pd = pd.concat([input_pd['country'], input_pd.groupby('country').ffill()], axis=1)
    input_pd = pd.concat([input_pd['country'], input_pd.groupby('country').bfill()], axis=1)
    final_df = spark.createDataFrame(input_pd)

    return final_df