import pyspark.pandas as ps

from datetime import datetime

from prophet import Prophet
from prophet.serialize import model_to_json


def model(dbt, session):

    # dbt configuration
    dbt.config(materialized="incremental")

    # use current time as index
    trained_at = datetime.now()

    # get upstream data
    revenue = dbt.ref("revenue_weekly_by_nation").pandas_api()

    # rename to match prophet's expected column names
    renames = {
        "date_week": "ds",
        "revenue": "y",
    }
    revenue = revenue.rename(columns=renames)

    # get list of unique nations dynamically
    nations = sorted(list(revenue["nation"].unique().to_numpy()))

    # train the ML models per nation
    models = [
        Prophet().fit(revenue[revenue["nation"] == nation].to_pandas())
        for nation in nations
    ]

    # persist models
    df = ps.DataFrame(
        {
            "trained_at": [trained_at] * len(nations),
            "nation": nations,
            "model": [model_to_json(model) for model in models],
        }
    )

    return df
