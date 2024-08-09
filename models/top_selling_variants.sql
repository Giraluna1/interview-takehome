-- models/top_selling_variants.sql for Product Team

SELECT
    variant.pid,
    variant.variant,
    variant.actual_size,
    variant.weave_cat,
    variant.size_grp,
    variant.shape,
    variant.price,
    variant.msrp,
    variant.stock_level,
    variant.depletion_level,
    variant.low_stock,
    RANK() OVER (ORDER BY variant.price DESC) AS sales_rank
FROM {{ ref('rugs_usa_variant') }} AS variant
ORDER BY sales_rank
