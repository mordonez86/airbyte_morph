{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('morph_ordersview_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'currency_id',
        'date_closed',
        'date_created',
        'date_last_updated',
        'paid_amount',
    ]) }} as _airbyte_morph_ordersview_hashid,
    tmp.*
from {{ ref('morph_ordersview_ab2') }} tmp
-- morph_ordersview
where 1 = 1

