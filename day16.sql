-- Day 16 of 100 days challenge

--write a query to find users whose transactions has breached their credit limit
DROP TABLE IF EXISTS users;

create table users
(
	user_id int,
	user_name varchar(20),
	credit_limit int
);

create table transactions
(
	trans_id int,
	paid_by int,
	paid_to int,
	amount int,
	trans_date date
);

insert into users(user_id,user_name,credit_limit)values
(1,'Peter',100),
(2,'Roger',200),
(3,'Jack',10000),
(4,'John',800);

insert into transactions(trans_id,paid_by,paid_to,amount,trans_date)values
(1,1,3,400,'01-01-2024'),
(2,3,2,500,'02-01-2024'),
(3,2,1,200,'02-01-2024');
select * from users
select * from transactions
--write a query to find users whose transactions has breached their credit limit
/*Steps:

Sum the transaction amounts for each user (grouped by paid_by).
Join the result with the users table to get the credit limit.
Filter the users where their total spending exceeds their credit limit.*/
SELECT 
    u.user_id, 
    u.user_name, 
    u.credit_limit, 
    COALESCE(SUM(t.amount), 0) AS total_spent
FROM users AS u
LEFT JOIN transactions AS t
    ON u.user_id = t.paid_by
GROUP BY 1,2,3
HAVING COALESCE(SUM(t.amount), 0) > u.credit_limit