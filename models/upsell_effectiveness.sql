-- models/upsell_effectiveness.sql for Operations

WITH upsell_analysis AS (
    SELECT
        upsell.p_id AS original_pid,
        upsell.pad_id AS upsell_pid,
        COUNT(*) AS upsell_count,
        SUM(CASE WHEN variant.pid = upsell.pad_id THEN variant.price ELSE 0 END) AS upsell_sales
    FROM {{ ref('rugs_usa_pads_upsell') }} AS upsell
    JOIN {{ ref('rugs_usa_variant') }} AS variant
    ON upsell.pad_id = variant.pid
    GROUP BY upsell.p_id, upsell.pad_id
)

SELECT
    original_pid,
    upsell_pid,
    upsell_count,
    upsell_sales,
    ROUND(CAST(upsell_sales AS NUMERIC) / NULLIF(upsell_count, 0), 2) AS avg_upsell_sales
FROM upsell_analysis
ORDER BY avg_upsell_sales DESC
