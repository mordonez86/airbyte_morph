{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_morph_ordersview') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['currency_id'], ['currency_id']) }} as currency_id,
    {{ json_extract_scalar('_airbyte_data', ['date_closed'], ['date_closed']) }} as date_closed,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_last_updated'], ['date_last_updated']) }} as date_last_updated,
    {{ json_extract_scalar('_airbyte_data', ['paid_amount_aibyte_transform'], ['paid_amount_aibyte_transform']) }} as paid_amount_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_morph_ordersview') }} as table_alias
-- morph_ordersview
where 1 = 1

