{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_morph_questionsview') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('_airbyte_data', ['from'], ['from']) }} as {{ adapter.quote('from') }},
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['item_id'], ['item_id']) }} as item_id,
    {{ json_extract_scalar('_airbyte_data', ['seller_id'], ['seller_id']) }} as seller_id,
    {{ json_extract_scalar('_airbyte_data', ['answer_text'], ['answer_text']) }} as answer_text,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['question_text'], ['question_text']) }} as question_text,
    {{ json_extract_scalar('_airbyte_data', ['answer_date_created'], ['answer_date_created']) }} as answer_date_created,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_morph_questionsview') }} as table_alias
-- morph_questionsview
where 1 = 1

