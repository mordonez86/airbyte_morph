{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('morph_questionsview_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('id') }},
    cast({{ adapter.quote('from') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('from') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(item_id as {{ dbt_utils.type_string() }}) as item_id,
    cast(seller_id as {{ dbt_utils.type_float() }}) as seller_id,
    cast(answer_text as {{ dbt_utils.type_string() }}) as answer_text,
    cast(date_created as {{ dbt_utils.type_string() }}) as date_created,
    cast(question_text as {{ dbt_utils.type_string() }}) as question_text,
    cast(answer_date_created as {{ dbt_utils.type_string() }}) as answer_date_created,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('morph_questionsview_ab1') }}
-- morph_questionsview
where 1 = 1

