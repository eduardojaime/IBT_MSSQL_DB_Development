SELECT * 
FROM Sales.CustomerTransactions
WHERE PaymentMethodID = 4;

SELECT SalespersonPersonID, OrderDate
FROM Sales.Orders
ORDER BY SalespersonPersonID ASC, OrderDate ASC; -- default is ASC

-- SINGLE INDEX
CREATE INDEX SalespersonPersonID ON Sales.Orders (SalespersonPersonID ASC);
--DROP INDEX SalespersonPersonID ON Sales.Orders;

-- COMPOSITE INDEX for Sorting
CREATE INDEX SalespersonPersonID_OrderDate 
ON Sales.Orders 
(SalespersonPersonID ASC, OrderDate ASC);

SELECT * -- returns all columns from all tables
FROM Sales.Orders
JOIN Application.People ON Orders.ContactPersonID = People.PersonID
WHERE PreferredName = 'Aakriti'; -- 1M RECORDS

-- Included columns
SELECT OrderID, OrderDate, ExpectedDeliveryDate, People.FullName
FROM Sales.Orders
JOIN Application.People ON Orders.ContactPersonID = People.PersonID
WHERE PreferredName = 'Aakriti'; -- 1M RECORDS

SELECT ContactPersonId, People.PreferredName
FROM Sales.Orders
JOIN Application.People ON Orders.ContactPersonID = People.PersonID
WHERE PreferredName = 'Aakriti'; -- 1M RECORDS

CREATE NONCLUSTERED INDEX ContactPersonID_Include_OrderDate_ExpectedDeliveryDate
ON Sales.Orders (ContactPersonID)
INCLUDE (ORDERDATE, EXPECTEDDELIVERYDATE)
ON USERDATA;
GO

CREATE NONCLUSTERED INDEX PreferredName_Include_FullName
ON Application.People (PreferredName)
INCLUDE (FullName)
ON USERDATA;
GO

SELECT * FROM Sales.CustomerTransactions WHERE PaymentMethodID = 4;
GO

-- Hiding data for a specific purpose
CREATE VIEW Sales.Orders12MonthsMultipleItems
AS
	-- SELECT STATEMENT
	SELECT OrderID, CustomerID, SalespersonPersonID, OrderDate, ExpectedDeliveryDate
	FROM sales.Orders
	WHERE OrderDate >= DATEADD(YEAR, -1, '2016-01-01')
	AND (SELECT COUNT(*) 
		FROM Sales.OrderLines 
		WHERE OrderLines.OrderID = Orders.OrderID) > 1
GO

/*
SELECT COUNT(*)  --AGGREGATE FUNCTION
FROM Sales.OrderLines -- 231412

SELECT AVG(UnitPrice) -- 45.207065
FROM Sales.OrderLines

SELECT MAX(UnitPrice) -- 1899.00
FROM Sales.OrderLines

SELECT MIN(UnitPrice) -- 0.66
FROM Sales.OrderLines

SELECT *
FROM Sales.OrderLines -- 231,412
*/

SELECT TOP 5 *
FROM Sales.Orders12MonthsMultipleItems
ORDER BY ExpectedDeliveryDate DESC -- NEWEST;

-- bit columns where 1 means TRUE and 0 means FALSE
SELECT PersonID, IsPermittedToLogon, IsEmployee, IsSalesperson
FROM Application.People;
GO

-- Reformatting data
DROP VIEW Application.PeopleEmployeeStatus;
GO
CREATE VIEW Application.PeopleEmployeeStatus
AS
	SELECT PersonID, FullName, IsPermittedToLogon, IsEmployee, IsSalesperson,
		CASE WHEN IsPermittedToLogon = 1 THEN 'Can logon'
			ELSE 'Cannot logon' END AS LogonRights,
		CASE WHEN IsEmployee = 1 and IsSalesperson = 1 THEN 'Sales Person'
			WHEN IsEmployee = 1 and IsSalesperson = 0 THEN 'Regular Employee'
			ELSE 'Not an Employee' END AS EmployeeType
	FROM Application.People
GO

SELECT FullName, LogonRights, EmployeeType FROM Application.PeopleEmployeeStatus