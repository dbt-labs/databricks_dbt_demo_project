select * 
    from {{ metrics.calculate(
        [metric('avg_supplier_cycle_days'),metric('total_shipped_orders')],
        grain='year',
        dimensions = ['supplier_key']
    ) }}


