

    select * from {{ source('dbt_eongaro', 'employee_record') }}

