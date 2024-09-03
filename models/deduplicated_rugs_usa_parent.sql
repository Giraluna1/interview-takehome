-- models/deduplicated_rugs_usa_parent.sql

WITH ranked_parents AS (
    SELECT
    min_price,
    max_price,
    weave,
    aggregate,
    origin,
    thickness,
    material,
    weave_feature,
    color,
    brand,
    "imageName",
    "imageType",
    "internalName",
    category,
    availability,
    clearance,
    long_description,
    shopbyroom,
    pid,
    dw_insert_timestamp,
    product_type_id,
    name,
    url,
    ROW_NUMBER() OVER (PARTITION BY pid ORDER BY dw_insert_timestamp DESC) AS row_num
    FROM {{ref rugs_usa_parent}}
)

SELECT
    min_price,
    max_price,
    weave,
    aggregate,
    origin,
    thickness,
    material,
    weave_feature,
    color,
    brand,
    "imageName",
    "imageType",
    "internalName",
    category,
    availability,
    clearance,
    long_description,
    shopbyroom,
    pid,
    dw_insert_timestamp,
    product_type_id,
    name,
    url
FROM ranked_parents
WHERE row_num = 1
