-- Day 30/100 Challenge
-- Google Data Analyst Interview Question



DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);



INSERT INTO Employees (id, name, manager_id)
VALUES
    (1, 'Alice', NULL),
    (2, 'Bob', 1),
    (3, 'Charlie', 2),
    (4, 'David', 2),
    (5, 'Eve', 3),
    (6, 'Frank', 3),
    (7, 'Grace', 4);


SELECT * FROM Employees

/*
Question:

Write a SQL query to show each employee's name along with their level in the company hierarchy. 
The level should start at 1 for employees who don’t have a manager (they are at the top of the hierarchy).


-- Expected output
id	name	level
1	Alice	1
2	Bob	2
3	Charlie	3
4	David	3
5	Eve	4
6	Frank	4
7	Grace	4

*/


SELECT * FROM employees;

SELECT e1.id, e1.name, 
       CASE 
           WHEN e1.manager_id IS NULL THEN 1
           WHEN e2.manager_id IS NULL THEN 2
           WHEN e3.manager_id IS NULL THEN 3
           WHEN e4.manager_id IS NULL THEN 4
           ELSE 5  -- Just in case the hierarchy is deeper
       END AS level
FROM Employees e1
LEFT JOIN Employees e2 ON e1.manager_id = e2.id
LEFT JOIN Employees e3 ON e2.manager_id = e3.id
LEFT JOIN Employees e4 ON e3.manager_id = e4.id
ORDER BY e1.id;
