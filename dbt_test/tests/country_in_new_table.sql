SELECT *
FROM {{ ref('raw_pos_country') }}
WHERE COUNTRY NOT IN (
    SELECT DISTINCT COUNTRY 
    FROM {{ ref('explore') }}
)