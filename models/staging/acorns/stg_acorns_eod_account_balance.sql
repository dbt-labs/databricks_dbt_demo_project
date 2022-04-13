with 

source as (

      select * from {{ source('acorns', 'eod_account_balance') }}
)

/* Keeping this one simple since we already modified the registraitons 
source to match the acorns source column syntax as
In a production use case you would probably have some light transforms to make*/

select * from source
