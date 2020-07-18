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