{{ config(materialized='table', file_format='parquet') }}

select "Hello World" as hi_there