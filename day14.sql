-- Day 14/100 

WITH monthly_purchases AS (
    SELECT
        customer_id,
        date_trunc('month', purchase_date) AS month
    FROM 
        amazon_sales
    WHERE 
        EXTRACT(YEAR FROM purchase_date) = 2024
),
month_count AS (
    SELECT
        customer_id,
        COUNT(DISTINCT month) AS month_count
    FROM 
        monthly_purchases
    GROUP BY 
        customer_id
    HAVING COUNT(DISTINCT month) = EXTRACT(MONTH FROM CURRENT_DATE)
)
SELECT 
    DISTINCT customer_id
FROM 
    month_count;
