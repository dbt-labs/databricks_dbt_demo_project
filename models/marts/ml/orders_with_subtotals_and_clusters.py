import mlflow

import pyspark.pandas as ps

from sklearn.cluster import KMeans


def model(dbt, session):

    dbt.config(
        create_notebook=True,
    )

    # MLflow control
    model_name = "dbt-databricks-cluster-demo"
    experiment_name = f"/Shared/{model_name}"
    train_new_model = True
    register_model = train_new_model and True

    # guess at the number of clusters
    n_clusters = 5

    # get upstream data
    orders_with_subtotals = dbt.ref("orders_with_subtotals").toPandas()

    # drop non-numeric columns
    X = orders_with_subtotals.select_dtypes(
        include=["float32", "float64", "int32", "int64"]
    ).to_numpy()

    if train_new_model:
        # log ML stuff
        mlflow.set_experiment(experiment_name)
        mlflow.start_run()
        mlflow.autolog()

        # train model
        kmeans = KMeans(n_clusters=n_clusters)
        model = kmeans.fit(X)

        if register_model:
            # register ML model
            artifact_uri = mlflow.get_artifact_uri()
            mlflow.register_model(artifact_uri + "/model", model_name)

    else:
        # load the latest registered model
        version = get_latest_model_version(model_name)
        model_uri = f"models:/{model_name}/{version}"
        model = mlflow.pyfunc.load_model(model_uri)

    # score model
    cluster_labels = model.predict(X)

    # add cluster labels to orders_with_subtotals
    temp = ps.DataFrame(data=cluster_labels, columns=["cluster_label"]).to_pandas()

    orders_with_subtotals_and_clusters = orders_with_subtotals.merge(
        temp, left_index=True, right_index=True
    )

    return orders_with_subtotals_and_clusters


# stolen from https://docs.databricks.com/_static/notebooks/machine-learning/feature-store-taxi-example.html
def get_latest_model_version(model_name):

    # assume default incremental integer versioning
    latest_version = 1

    # get the MLflow client
    mlflow_client = mlflow.MlflowClient()

    # get the latest model version
    for mv in mlflow_client.search_model_versions(f"name='{model_name}'"):
        version_int = int(mv.version)
        if version_int > latest_version:
            latest_version = version_int

    return latest_version
