create database days_Interview_questions;
-- day 05/100 days SQL Interview questions

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    store_name VARCHAR(50),
    sale_date DATE,
    sales_amount DECIMAL(10, 2)
);


INSERT INTO sales (store_name, sale_date, sales_amount) 
VALUES
('A', '2024-01-01', 1000.00),
('A', '2024-02-01', 1500.00),
('A', '2024-03-01', 2000.00),
('A', '2024-04-01', 3000.00),
('A', '2024-05-01', 4500.00),
('A', '2024-06-01', 6000.00),
('B', '2024-01-01', 2000.00),
('B', '2024-02-01', 2200.00),
('B', '2024-03-01', 2400.00),
('B', '2024-04-01', 2600.00),
('B', '2024-05-01', 2800.00),
('B', '2024-06-01', 3000.00),
('C', '2024-01-01', 3000.00),
('C', '2024-02-01', 3100.00),
('C', '2024-03-01', 3200.00),
('C', '2024-04-01', 3300.00),
('C', '2024-05-01', 3400.00),
('C', '2024-06-01', 3500.00);

/* 
-- Walmart SQL question for Data Analyst
Calculate each store running total
Growth ratio compare to previous month
return store name, sales amount, running total, growth ratio
*/
select * from sales

-- 1.1 Calculate each store running total--
select * ,
	sum(sales_amount)over(partition by store_name order by sale_date )as running_total
	
from sales;
	
--1.2 Growth ratio compare to previous month return store name, sales amount, running total, growth ratio--
WITH cte_monthly_sale
AS
(
SELECT *,
    SUM(sales_amount) OVER(PARTITION BY store_name ORDER  BY sale_date) as running_total,
    LAG(sales_amount, 1) OVER(PARTITION BY store_name ORDER  BY sale_date) as last_month_sale
FROM sales
)
SELECT
    store_name,
    sale_date,
    sales_amount,
    running_total,
    last_month_sale,
    round ((sales_amount - last_month_sale)/last_month_sale * 100) as Growth_ratio
FROM cte_monthly_sale



