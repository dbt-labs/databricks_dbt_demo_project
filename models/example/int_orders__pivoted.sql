{% set ship_methods = ['AIR','MAIL','TRUCK', 'RAIL'] %}

with final (
   select 
        order_item_key,

        -- pivot macro 
        {% for ship_method in ship_methods -%}
            sum(case when ship_mode = '{{ ship_method }}' then gross_item_sales_amount else 0 end) as {{ship_method}}_gross_amount
            {%- if not loop.last %}, {% endif %}
        {% endfor -%}

    from {{ ref('fct_order_items') }} as fct_orders_items
    group by 1
) 

select * from final 