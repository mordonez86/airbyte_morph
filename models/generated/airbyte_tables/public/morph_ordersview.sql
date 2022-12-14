{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('morph_ordersview_ab3') }}
select
    {{ adapter.quote('id') }},
    currency_id,
    date_closed,
    date_created,
    date_last_updated,
    paid_amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_morph_ordersview_hashid
from {{ ref('morph_ordersview_ab3') }}
-- morph_ordersview from {{ source('public', '_airbyte_raw_morph_ordersview') }}
where 1 = 1

