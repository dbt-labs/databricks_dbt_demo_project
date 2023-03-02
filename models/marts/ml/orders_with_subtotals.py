def model(dbt, session):
    dbt.config(
        create_notebook=True,
    )

    # get upstream data
    orders = dbt.ref("fct_orders").toPandas()
    parts = dbt.ref("dim_parts").toPandas()
    order_items = dbt.ref("fct_order_items").toPandas()

    # list of unique product types
    product_types = sorted(list(set(parts["type"].unique())))

    # get the subtotal for each product type for each order_key
    order_item_product_subtotals = (
        order_items.merge(parts, on="part_key")
        .groupby(["order_key", "type"])
        .agg(subtotal=("retail_price", "sum"))
        .reset_index()
        .pivot(index="order_key", columns="type", values="subtotal")
        .reset_index()
    )

    # rename the type columns to include "subtotal_"
    order_item_product_subtotals.rename(
        columns={
            product_type: f"subtotal_{product_type.replace(' ', '_')}"
            for product_type in product_types
        },
        inplace=True,
    )

    # fill NaNs with 0s
    order_item_product_subtotals = order_item_product_subtotals.fillna(0)

    # merge with the existing orders mart
    orders_with_subtotals = orders.merge(order_item_product_subtotals, on="order_key")

    return orders_with_subtotals
