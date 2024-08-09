-- models/rugs_usa_variant_model.sql testing model

SELECT COUNT(*)
FROM {{ ref('rugs_usa_variant') }}
