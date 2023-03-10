import pandas as pd
import pyspark.pandas as ps

from prophet import Prophet
from prophet.serialize import model_from_json


def model(dbt, session):

    # get trained ML models
    models = dbt.ref("revenue_by_nation_forecast_train").pandas_api()

    # get most recent trained_at
    most_recent_trained_at = models["trained_at"].max()

    # filter models by most recent trained_at
    models = models[models["trained_at"] == most_recent_trained_at]

    # get list of unique nations dynamically
    nations = sorted(list(models["nation"].unique().to_numpy()))

    # hydrate models as Prophet objects
    models = {
        nation: model_from_json(
            models[models["nation"] == nation]["model"].iloc[0]
        )
        for nation in nations
    }

    # create future dataframe to forecast on
    future = models[nations[0]].make_future_dataframe(periods=52 * 3, freq="W")

    # score model per nation
    forecasts = {nation: models[nation].predict(future) for nation in nations}

    # dataframe magic (use nation to filter forecasts from single table)
    for nation, forecast in forecasts.items():
        forecast["nation"] = nation

    # create a single dataframe to return
    df = pd.concat(forecasts.values())

    return df
