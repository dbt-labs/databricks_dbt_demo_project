# the intent of this .md is to remove redundancy in the documentation


# the below are descriptions from stg_tpch_line_items

{% docs order_item_key %} surrogate key for the model -- combo of order_key + line_number {% enddocs %}

{% docs line_number %} sequence of the order items within the order {% enddocs %}

{% docs return_flag %} letter determining the status of the return (r is returned) {% enddocs %}

{% docs ship_date %} the date the order item is being shipped {% enddocs %}

{% docs commit_date %} the date the order item is being commited {% enddocs %}

{% docs receipt_date %} the receipt date of the order item {% enddocs %}

{% docs ship_mode %} method of shipping {% enddocs %}

{% docs comment %} additional commentary {% enddocs %}

{% docs extended_price %} line item price {% enddocs %}

{% docs discount_percentage %} percentage of the discount {% enddocs %}


# the below are descriptions from stg_tpch_supppliers

{% docs supplier_name %} id of the supplier {% enddocs %}

{% docs supplier_address %} address of the supplier {% enddocs %}

{% docs phone_number %} phone number of the supplier {% enddocs %}

{% docs account_balance %} raw account balance {% enddocs %}

# the below are descriptions from stg_tpch_parts

{% docs retail_price %} raw retail price {% enddocs %}

# the below are descriptions from stg_tpch_part_suppliers

{% docs available_quantity %} raw available quantity {% enddocs %}

{% docs cost %} raw cost {% enddocs %}

{% docs base_price %} since extended_price is the line item total, we back out the price per item {% enddocs %}

{% docs discounted_price %} factoring in the discount_percentage, the line item discount total {% enddocs %}

{% docs tax_rate %} tax rate of the order item {% enddocs %}

{% docs gross_item_sales_amount %} same as extended_price {% enddocs %}

{% docs discounted_item_sales_amount %} line item (includes quantity) discount amount{% enddocs %}

{% docs item_discount_amount %} item level discount amount. this is always a negative number {% enddocs %}

{% docs item_tax_amount %} item level tax total {% enddocs %}

{% docs net_item_sales_amount %} the net total which factors in discount and tax {% enddocs %}