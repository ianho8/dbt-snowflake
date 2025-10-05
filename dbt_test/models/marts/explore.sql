WITH agg AS (
    SELECT 
        l.COUNTRY,
        m.MENU_ITEM_NAME,
        CASE 
            WHEN m.MENU_ITEM_NAME IS NOT NULL THEN SUM(od.QUANTITY * (m.SALE_PRICE_USD - m.COST_OF_GOODS_USD))
            ELSE 0 
        END AS PROFIT,
    DENSE_RANK() OVER(PARTITION BY l.COUNTRY ORDER BY PROFIT DESC) AS RNK
    FROM  {{ ref('raw_pos_location') }} l
    LEFT JOIN {{ ref('raw_pos_order_header') }} oh
    ON l.LOCATION_ID = oh.LOCATION_ID
    INNER JOIN {{ ref('raw_pos_order_detail') }} od
    ON oh.ORDER_ID = od.ORDER_ID
    INNER JOIN {{ ref('raw_pos_menu') }} m
    ON od.MENU_ITEM_ID = m.MENU_ITEM_ID
    GROUP BY 
        l.COUNTRY,
        m.MENU_ITEM_NAME
)

SELECT COUNTRY, MENU_ITEM_NAME, PROFIT
FROM agg
WHERE RNK <= 2
ORDER BY 
    COUNTRY,
    PROFIT DESC