CREATE DATABASE LessonDay2;
GO

USE LessonDay2;
GO

CREATE SCHEMA Examples;
GO

-- CREATE TABLE {schema}.{tablename}

CREATE TABLE Examples.Widget2
(
	WidgetCode VARCHAR(10) NOT NULL,
	WidgetName VARCHAR(100) NULL,
	CONSTRAINT PKWidget2 PRIMARY KEY (WidgetCode)
)
/* Example values
10, Lenovo Laptop
11, Acer Laptop
11, Tablet A10 > this will break the insert
12, Acer Laptop > this is okay because widget name is not a pk
*/

ALTER TABLE Examples.Widget2
	ADD SerialNumber VARCHAR(50) NOT NULL;

ALTER TABLE Examples.Widget2
	DROP COLUMN WidgetName;

DROP TABLE Examples.Widget2;

CREATE TABLE Examples.Company
(
	CompanyName Nvarchar(100) NOT NULL
)
-- For testing a design
INSERT INTO Examples.Company VALUES ('AOL');
INSERT INTO Examples.Company VALUES ('Computer Systems Incorporated of North York')
-- truncated means you can't insert this much text
INSERT INTO Examples.Company VALUES ('this is an incredibly long name but not so long but yes very long so long that it might break the insert statement I just wrote')
-- Think about the values
-- AOL
-- BANK OF CANADA
-- LG
-- SAMSUNG

-- AMOUNTS AS INT 100, 40, 20, 10, 5 > IS THIS WHAT WE SEE IN STORES?
-- AMOUNTS AS DECIMAL(30, 20) > IS THIS CORRECT?
-- 90.00 > 100.85, 40.50, 10.00, 5.99 BETTER AS DECIMAL(10, 2)