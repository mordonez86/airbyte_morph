{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_morph_itemsview') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract_scalar('_airbyte_data', ['seller_id'], ['seller_id']) }} as seller_id,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['category_id'], ['category_id']) }} as category_id,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['last_updated'], ['last_updated']) }} as last_updated,
    {{ json_extract_scalar('_airbyte_data', ['free_shipping'], ['free_shipping']) }} as free_shipping,
    {{ json_extract_scalar('_airbyte_data', ['logistic_type'], ['logistic_type']) }} as logistic_type,
    {{ json_extract_scalar('_airbyte_data', ['shipping_mode'], ['shipping_mode']) }} as shipping_mode,
    {{ json_extract_scalar('_airbyte_data', ['sold_quantity'], ['sold_quantity']) }} as sold_quantity,
    {{ json_extract_scalar('_airbyte_data', ['catalog_listing'], ['catalog_listing']) }} as catalog_listing,
    {{ json_extract_scalar('_airbyte_data', ['initial_quantity'], ['initial_quantity']) }} as initial_quantity,
    {{ json_extract_scalar('_airbyte_data', ['available_quantity'], ['available_quantity']) }} as available_quantity,
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['health_aibyte_transform'], ['health_aibyte_transform']) }} as health_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_morph_itemsview') }} as table_alias
-- morph_itemsview
where 1 = 1

