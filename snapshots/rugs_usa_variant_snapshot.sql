{% snapshot rugs_usa_variant_snapshot %}
{{
  config(
    strategy='timestamp',
    unique_key='pid',
    target_schema='snapshots',
    updated_at='dw_insert_timestamp',
  )
}}

SELECT
  pid,
  variant,
  actual_size,
  weave_feature,
  weave_cat,
  size_grp,
  shipping_size,
  shape,
  msrp,
  stock_level,
  depletion_level,
  low_stock,
  weight,
  other_stock_core,
  other_stock_compass,
  price,
  estimated_delivery_date,
  this_isd_range,
  status,
  origin,
  new_arrival,
  stockMsg,
  stockEddMsg,
  dw_insert_timestamp
FROM {{ ref('rugs_usa_variant') }}

{% endsnapshot %}
