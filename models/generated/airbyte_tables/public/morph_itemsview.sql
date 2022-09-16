{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('morph_itemsview_ab3') }}
select
    {{ adapter.quote('id') }},
    title,
    status,
    end_time,
    seller_id,
    start_time,
    category_id,
    date_created,
    last_updated,
    free_shipping,
    logistic_type,
    shipping_mode,
    sold_quantity,
    catalog_listing,
    initial_quantity,
    available_quantity,
    price,
    health,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_morph_itemsview_hashid
from {{ ref('morph_itemsview_ab3') }}
-- morph_itemsview from {{ source('public', '_airbyte_raw_morph_itemsview') }}
where 1 = 1

