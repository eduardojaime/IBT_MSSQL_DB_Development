-- SELECT, FROM, AS
-- Basic data retrieval
-- select star/everything from..
SELECT * FROM Students;
-- as long as you use the default schema (dbo)
SELECT * FROM dbo.Students;

-- KEYWORDS or Reserved Words
-- SELECT with column names
-- FROM with table names
-- not case sensitive
select * from students;
--- keywords ALL CAPS
-- tables and columns will be Capitalized
SELECT * FROM Students;

-- statements can be multi line
-- any white space will be ignored
SELECT *
FROM dbo.Students;

-- 2 types of comments: single-line and multi-line
/* any text and 
number of lines of
text
*/
SELECT * FROM Students;

-- Goal: send a mass email, I need all their email addresses
SELECT EmailAddr
FROM Students

-- Goal: I want to organize events for my students, I want to know their names and countries of origin
SELECT FirstName, LastName, Country
FROM Students

-- Can there be spaces in the column name? FirstName >> First Name??
-- It is allowed. But it's no bueno. Not a good practice.
-- Recommendation when naming columns: never use spaces or _, 
SELECT FirstName -- capitalize first letter of every word in column names
FROM Students; -- capitalize first letter of every word in table names

-- Full SELECT statement
/*
	SELECT columnlist
	FROM tablelist
	WHERE condition << filters: country = canada connected by AND, OR
	GROUP BY columnlist << allows for grouping data
	HAVING condition << filters groups of data
	ORDER BY columnlist << 
*/
SELECT FirstName
FROM Students
ORDER BY FirstName;


-- Calculated fields and aliases
SELECT FirstName, LastName, Country
FROM Students;

-- Literal values - static value enclosed in single quotes
-- use this to display specific words or values
SELECT 'IBT COLLEGE', FirstName, LastName, Country
FROM Students;

-- when using calculated fields, SQL does not provide a column name

-- Arithmetic calculations
-- * multiply
-- + add
-- - substract
-- / divide
SELECT Amount, (Amount * 1.13) -- same way you would do it in a programming language like C#
FROM [Restaurant].[Payment]

-- Concatenating fields
-- use the + sign to concatenate fields
SELECT 'Full Name: ' + FirstName + ' ' + LastName, EmailAddr
FROM Students;
-- GoraudLomis <<< space??

-- Aliases for columns >> for calculated and existing columns
SELECT FirstName + ' ' + LastName AS 'Full Name', EmailAddr AS 'Primary Email Address'
FROM Students;


