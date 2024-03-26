select 
* from {{ ref('dim_customers') }}
where account_balance < 0