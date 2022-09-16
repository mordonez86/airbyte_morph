{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('morph_questionsview_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        adapter.quote('from'),
        'status',
        'item_id',
        'seller_id',
        'answer_text',
        'date_created',
        'question_text',
        'answer_date_created',
    ]) }} as _airbyte_morph_questionsview_hashid,
    tmp.*
from {{ ref('morph_questionsview_ab2') }} tmp
-- morph_questionsview
where 1 = 1

