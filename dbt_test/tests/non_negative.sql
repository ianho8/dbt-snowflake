SELECT *
FROM {{ ref('explore') }}
WHERE PROFIT < 0