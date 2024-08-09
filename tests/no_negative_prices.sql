SELECT *
FROM {{ ref('rugs_usa_variant') }}
WHERE price < 0
