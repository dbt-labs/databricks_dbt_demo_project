{% test is_numeric(model, column_name) %}  
  
with validation as (  
  
 select  
 {{ column_name }} as numeric_field  
  
 from {{ model }}  
  
),  
  
validation_errors as (  
  
 select  
 numeric_field  
  
 from validation  
 -- if this is true, then numeric_field is not numeric!  
 where numeric_field = '\D'  
  
)  
  
select *  
from validation_errors  
  
{% endtest %}