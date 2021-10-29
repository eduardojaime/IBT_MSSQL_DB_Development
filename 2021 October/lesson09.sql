-- Ch17 Modifying data > INSERT UPDATE DELETE FROM A TABLE
-- UPDATES and DELETES must be handled with caution

-- ALTER TABLE dbo.Customers
-- DROP COLUMN id
-- ADD CustomerId INT PRIMARY KEY NOT NULL IDENTITY(1,1)


-- Adding new data to my table
-- 1) SPECIFYING DATA
INSERT INTO dbo.Customers (firstName, lastName, email) -- LIST ALL NON-IDENTITY COLUMNS
VALUES ('John', 'Andre', 'jandre@uk.com');

-- DELETE is the simplest
-- DELETE FROM dbo.Customers WHERE CustomerId = 1; -- two records
-- 2) FROM THE RESULTS OF A SELECT STATEMENT >> MIGRATING DATA
-- Students became Customers!
INSERT INTO dbo.Customers (firstName, lastName, email) -- << best practice
-- VALUES KEYWORD NOT REQUIRED
SELECT FirstName, LastName, EmailAddr FROM dbo.Students

-- How to handle NULL values?
-- Students became Customers! and student table accepts null on emailaddresses
INSERT INTO dbo.Customers (firstName, lastName, email) -- << best practice
-- VALUES KEYWORD NOT REQUIRED
SELECT FirstName, LastName, ISNULL(EmailAddr, '') FROM dbo.Students -- Option 1 Provide a default value in case there are NULL VALUES

INSERT INTO dbo.Customers (firstName, lastName, email) -- << best practice
-- VALUES KEYWORD NOT REQUIRED
SELECT FirstName, LastName, EmailAddr FROM dbo.Students WHERE EmailAddr IS NOT NULL -- Option 2 Filter out NULL values

-- What happens if I have only partial data in one of the tables?
INSERT INTO dbo.Customers (firstName, lastName, email)
SELECT FirstName, LastName, 'noemail@ibtcollege.com' -- literal value
FROM dbo.Students

INSERT INTO dbo.Customers (firstName, lastName, email)
SELECT FirstName, LastName, NULL -- literal value
FROM dbo.Students 

-- Can I bring data from multiple tables? yes with a join
INSERT INTO dbo.Customers (firstName, lastName, email)
SELECT FirstName, LastName, c.EmailAddr -- literal value
FROM dbo.Students s
JOIN dbo.ContactInfo c ON s.StudentId = c.StudentId


-- UPDATE data
INSERT INTO dbo.Customers (firstName, lastName, email) -- LIST ALL NON-IDENTITY COLUMNS
VALUES ('John', 'Andre', 'jandre@uk.com');

SELECT * FROM dbo.Customers WHERE CustomerId = 52

UPDATE dbo.Customers
SET
 --- PROVIDE A LIST OF COLUMN = VALUE SEPARATED BY COMMA
 email = 'jandre@amc.com'
WHERE CustomerId = 1

UPDATE dbo.Customers
SET
 --- PROVIDE A LIST OF COLUMN = VALUE SEPARATED BY COMMA
 email = (SELECT EmailAddr FROM dbo.Students WHERE StudentId = 1),
 firstName = (SELECT FirstName FROM dbo.Students WHERE StudentId = 1),
 lastName = (SELECT LastName FROM dbo.Students WHERE StudentId = 1) -- INNER SELECT
WHERE CustomerId = 52

-- DELETE forever
TRUNCATE TABLE dbo.Customers;
GO

-- create stored procedures to wrap these operations
CREATE PROCEDURE AddNewCustomer (
	@firstName varchar(50),
	@lastName varchar(50),
	@email varchar(50)
)
AS
	BEGIN 
		INSERT INTO dbo.Customers (firstName,lastName,email)
		VALUES (@firstName, @lastName, @email)
	END
GO

EXEC AddNewCustomer @firstName = 'Edmund', @lastName = 'Hewlett', @email = 'edmundh@amc.com';
GO

CREATE PROCEDURE DeleteCustomer (
	@CustomerId INT
)
AS
	BEGIN
		DELETE FROM dbo.Customers WHERE CustomerId = @CustomerId;
	END
GO

EXEC DeleteCustomer @CustomerId = 2;