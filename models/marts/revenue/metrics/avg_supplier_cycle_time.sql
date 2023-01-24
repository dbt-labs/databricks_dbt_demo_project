with cte as (    
    select * 
    from {{ metrics.calculate(
        metric('avg_supplier_cycle_days'),
        grain='quarter',
        dimensions = ['ship_mode'],
        secondary_calculations = [metrics.rolling(aggregate = "max", interval=4, alias = "max_past_4quarter")]
    ) }}

)

select *
from cte








{# ,
        secondary_calculations = [metrics.rolling(aggregate = "max", interval=4, alias = "max_past_4quarter")]  #}
