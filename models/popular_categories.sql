-- models/popular_categories.sql for marketing team

WITH category_sales AS (
    SELECT
        category_map.category_value AS category_name,
        COUNT(DISTINCT variant.pid) AS product_count,
        SUM(variant.price) AS total_sales
    FROM {{ ref('rugs_usa_variant') }} AS variant
    JOIN {{ ref('rugs_usa_category_map') }} AS category_map
    ON variant.pid = category_map.pid
    GROUP BY category_map.category_value
)

SELECT
    category_name,
    product_count,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM category_sales
ORDER BY total_sales DESC
