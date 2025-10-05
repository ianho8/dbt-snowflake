-- What tables exist?
SHOW TABLES IN SCHEMA DEV;

-- What is the scale of data? 
SELECT COUNT(*) FROM DEV.RAW_POS_ORDER_HEADER;

-- Understand a query that might be used in a mart
SELECT 
    cl.customer_id,
    cl.city,
    cl.country,
    cl.first_name,
    cl.last_name,
    cl.phone_number,
    cl.e_mail,
    SUM(oh.order_total) AS total_sales,
    ARRAY_AGG(DISTINCT oh.location_id) AS visited_location_ids_array
FROM DEV.RAW_CUSTOMER_CUSTOMER_LOYALTY cl
JOIN DEV.RAW_POS_ORDER_HEADER oh
ON cl.customer_id = oh.customer_id
GROUP BY cl.customer_id, cl.city, cl.country, cl.first_name,
cl.last_name, cl.phone_number, cl.e_mail;