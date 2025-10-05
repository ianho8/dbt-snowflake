SHOW TABLES IN DATABASE tasty_bytes_dbt_db;

SHOW VIEWS IN DATABASE tasty_bytes_dbt_db;

SHOW DBT PROJECTS;

SELECT * FROM tasty_bytes_dbt_db.dev.explore LIMIT 10;
SELECT COUNTRY, COUNT(*) AS CNT FROM tasty_bytes_dbt_db.dev.explore GROUP BY COUNTRY HAVING CNT = 2;

