{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('morph_ordersview_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('id') }},
    cast(currency_id as {{ dbt_utils.type_string() }}) as currency_id,
    cast(date_closed as {{ dbt_utils.type_string() }}) as date_closed,
    cast(date_created as {{ dbt_utils.type_string() }}) as date_created,
    cast(date_last_updated as {{ dbt_utils.type_string() }}) as date_last_updated,
    cast(paid_amount_aibyte_transform as {{ dbt_utils.type_string() }}) as paid_amount_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('morph_ordersview_ab1') }}
-- morph_ordersview
where 1 = 1

