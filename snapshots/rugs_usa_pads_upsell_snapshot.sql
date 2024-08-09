{% snapshot rugs_usa_pads_upsell_snapshot %}
{{
  config(
    target_schema='snapshots',
    unique_key='pad_id',
    strategy='timestamp',
    updated_at='dw_insert_timestamp'
  )
}}

SELECT
  p_id,
  pad_id,
  size,
  shape,
  price,
  width,
  sqft,
  type,
  stock,
  height,
  variant,
  dw_insert_timestamp
FROM {{ ref('rugs_usa_pads_upsell') }}

{% endsnapshot %}
