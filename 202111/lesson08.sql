-- Joining tables
-- 11, 12, 13
-- INNER, OUTTER JOINS, FULL JOINS
-- SELF JOIN < HIERARCHIES
-- VIEWS
-- 1 to M
SELECT * FROM Customers; -- PK CustomerId 50
SELECT * FROM Orders; -- FK CustomerId 

-- INNER JOINS
-- Use case: pull data from both tables at the same time
-- Generate reports
SELECT *
FROM Customers -- first primary
	INNER JOIN Orders -- then secondary
	ON Customers.Id = Orders.CustomerId
ORDER BY Customers.Id
-- Note that customers 41 to 50 haven't purchased anything so they don't apear in this result set

-- Table order doesn't matter in inner joins
SELECT *
FROM Orders -- first primary
	INNER JOIN Customers -- then secondary
	ON Customers.Id = Orders.CustomerId
ORDER BY Customers.Id

-- use aliases to simplify your JOIN
SELECT c.Email, o.CreatedDate, o.Amount
FROM Customers AS c -- first primary
	INNER JOIN Orders AS o -- then secondary
	ON c.Id = o.CustomerId
ORDER BY c.Id

-- Customers 41 to 50 don't have any orders yet, therefore they don't show up in an INNER JOIN

SELECT *
FROM Customers AS c LEFT JOIN Orders o ON c.Id = o.CustomerId
	-- PRIMARY LEFT JOIN SECONDARY
ORDER BY c.Id

-- RIGHT JOIN
SELECT *
FROM Orders AS o RIGHT JOIN Customers c ON c.Id = o.CustomerId
	-- SECONDARY RIGHT JOIN PRIMARY
ORDER BY c.Id

-- UPDATE Orders SET CustomerId = null WHERE OrderId > 900 
-- 100 invalid records without customer
SELECT *
FROM Customers c
	FULL JOIN Orders o
	ON c.Id = o.CustomerId
ORDER BY c.Id

-- CROSS JOIN
SELECT *
FROM Customers
	CROSS JOIN MovieTitles
ORDER BY Customers.FirstName, MovieTitles.Movie

-- SELF JOIN > CONNECTING TABLES TO THEMSELVES
SELECT
Employees.EmployeeName AS 'Employee Name',
Managers.EmployeeName AS 'Manager Name'
FROM Personnel AS Employees
INNER JOIN Personnel AS Managers
ON Employees.ManagerID = Managers.EmployeeID
ORDER BY Employees.EmployeeName
GO

-- CREATING VIEWS << Exam topic
CREATE VIEW CustomersAndOrders 
AS
	-- SELECT STATEMENT
	SELECT c.Email, o.CreatedDate, o.Amount
	FROM Customers AS c -- first primary
		INNER JOIN Orders AS o -- then secondary
		ON c.Id = o.CustomerId
GO

-- call the view as a table
SELECT * 
FROM CustomersAndOrders

-- FILTER THE VIEW
SELECT Email
FROM CustomersAndOrders
WHERE Amount > 400 -- 597 people purchased more than 400 dollars
GO

-- ALTER A VIEW AFTER IT'S CREATED
ALTER VIEW CustomersAndOrders
AS
	SELECT c.FirstName, c.LastName, c.Email, o.CreatedDate, o.Amount
	FROM Customers AS c -- first primary
		INNER JOIN Orders AS o -- then secondary
		ON c.Id = o.CustomerId
GO

-- DELETE THE VIEW
DROP VIEW CustomersAndOrders