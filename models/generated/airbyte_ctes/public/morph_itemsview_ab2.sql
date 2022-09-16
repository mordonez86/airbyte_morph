{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('morph_itemsview_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(end_time as {{ dbt_utils.type_string() }}) as end_time,
    cast(seller_id as {{ dbt_utils.type_float() }}) as seller_id,
    cast(start_time as {{ dbt_utils.type_string() }}) as start_time,
    cast(category_id as {{ dbt_utils.type_string() }}) as category_id,
    cast(date_created as {{ dbt_utils.type_string() }}) as date_created,
    cast(last_updated as {{ dbt_utils.type_string() }}) as last_updated,
    {{ cast_to_boolean('free_shipping') }} as free_shipping,
    cast(logistic_type as {{ dbt_utils.type_string() }}) as logistic_type,
    cast(shipping_mode as {{ dbt_utils.type_string() }}) as shipping_mode,
    cast(sold_quantity as {{ dbt_utils.type_float() }}) as sold_quantity,
    {{ cast_to_boolean('catalog_listing') }} as catalog_listing,
    cast(initial_quantity as {{ dbt_utils.type_float() }}) as initial_quantity,
    cast(available_quantity as {{ dbt_utils.type_float() }}) as available_quantity,
    cast(price_aibyte_transform as {{ dbt_utils.type_string() }}) as price_aibyte_transform,
    cast(health_aibyte_transform as {{ dbt_utils.type_string() }}) as health_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('morph_itemsview_ab1') }}
-- morph_itemsview
where 1 = 1

