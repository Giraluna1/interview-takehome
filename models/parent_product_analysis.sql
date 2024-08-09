-- models/parent_product_analysis.sql

WITH parent_summary AS (
    SELECT
        parent.parent_id,
        parent.product_name,
        COUNT(variant.pid) AS variant_count,
        SUM(variant.stock_level) AS total_stock,
        AVG(variant.price) AS avg_price
    FROM {{ ref('rugs_usa_parent') }} AS parent
    JOIN {{ ref('rugs_usa_variant') }} AS variant
    ON parent.parent_id = variant.pid
    GROUP BY parent.parent_id, parent.product_name
)

SELECT
    parent_id,
    product_name,
    variant_count,
    total_stock,
    avg_price,
    RANK() OVER (ORDER BY variant_count DESC) AS rank_by_variant_count,
    RANK() OVER (ORDER BY total_stock DESC) AS rank_by_total_stock
FROM parent_summary
ORDER BY rank_by_variant_count, rank_by_total_stock;
