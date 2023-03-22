{{
    config(
        materialized='incremental',
        unique_key='review_id',
    )
}}

select
    review_id,
    listing_id,
    reviewer_id,
    reviewer_name,
    comments,
    reviewed_at
from {{ ref('stg_airbnb_reviews') }}

{% if is_incremental() %}
where reviewed_at >= (select max(reviewed_at) from {{ this }})
{% endif %}
