{{ config(materialized = 'table') }}

{% for i in range(10) %}

  select {{ i+1 }} as id, to_date('{{ '2021-01-%02d' % (i+1) }}') as date_day {% if not loop.last %} union all {% endif %}

{% endfor %}
