{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('morph_itemsview_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        'title',
        'status',
        'end_time',
        'seller_id',
        'start_time',
        'category_id',
        'date_created',
        'last_updated',
        boolean_to_string('free_shipping'),
        'logistic_type',
        'shipping_mode',
        'sold_quantity',
        boolean_to_string('catalog_listing'),
        'initial_quantity',
        'available_quantity',
        'price_aibyte_transform',
        'health_aibyte_transform',
    ]) }} as _airbyte_morph_itemsview_hashid,
    tmp.*
from {{ ref('morph_itemsview_ab2') }} tmp
-- morph_itemsview
where 1 = 1

