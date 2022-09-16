{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('morph_questionsview_ab3') }}
select
    {{ adapter.quote('id') }},
    {{ adapter.quote('from') }},
    status,
    item_id,
    seller_id,
    answer_text,
    date_created,
    question_text,
    answer_date_created,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_morph_questionsview_hashid
from {{ ref('morph_questionsview_ab3') }}
-- morph_questionsview from {{ source('public', '_airbyte_raw_morph_questionsview') }}
where 1 = 1

