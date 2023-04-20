/*  This is a model config block. With it, you can create model specific configurations and override the configurations set on the dbt_project.yml. 
*/
{{ config(
    materialized="table",
    tags="hourly"
) }}

/* This is a dbt model  which means that it fits 2 requirements:
- Is a select statement
- Defined in a .sql file under the models directory
When you run the dbt model, dbt will wrap the correct DDL and DML to create the object in Snowflake. This allows users to
focus on writing the SQL without worry about the create statement. 
Full documention: https://docs.getdbt.com/docs/building-a-dbt-project/building-models
*/
with source as (

    select * from {{ source('tpch', 'customer') }}

),

renamed as (

    select
    
        c_custkey as customer_key,
        c_name as name,
        c_address as address, 
        c_nationkey as nation_key,
        c_phone as phone_number,
        c_acctbal as account_balance,
        c_mktsegment as market_segment,
        c_comment as comment

    from source

)

select * from renamed