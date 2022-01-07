SELECT * FROM dbo.Students

-- SORTING DATA > ORDER BY - ASC - DESC
SELECT *
FROM dbo.Students
ORDER BY Country -- ASC is the default order

SELECT *
FROM dbo.Students
ORDER BY Country ASC -- it can be made explicit

-- Best practice is to make your code explicit but not too verbose

SELECT * 
FROM dbo.Students
ORDER BY Country, BirthDate -- you can specify more than one column

SELECT LastName + ', ' + FirstName AS 'FullName'
FROM dbo.Students
ORDER BY 'FullName' -- we can order by an alias

SELECT LastName, FirstName
FROM dbo.Students
ORDER BY LastName + ', ' + FirstName

-- When sorting data, keep in mind that:
-- ASC order means NULL values are shown first, then numbers, then character data

-- FILTERING DATA > WHERE - TOP - LIKE
SELECT LastName + ', ' + FirstName AS 'FullName', Country, BirthDate
FROM dbo.Students
--- selection criteria CONDITIONS
WHERE 
Country = 'RUSSIA' AND BirthDate > '2000-01-01'
ORDER BY 'FullName'

SELECT LastName + ', ' + FirstName AS 'FullName', Country, BirthDate
FROM dbo.Students
--- selection criteria CONDITIONS
WHERE 
Country <> 'RUSSIA'
ORDER BY 'FullName'

-- selecting only x number of records/rows
SELECT TOP 5 FirstName, LastName, EmailAddr
FROM dbo.Students
ORDER BY LastName

-- pattern matching LIKE and wildcard %
SELECT FirstName, LastName, EmailAddr
FROM dbo.Students
WHERE LastName LIKE 'C%' -- letter c followed by any character

SELECT FirstName, LastName, EmailAddr
FROM dbo.Students
WHERE EmailAddr LIKE '%@intel%' -- any character to the left and right, string contains @intel

SELECT FirstName, LastName, EmailAddr
FROM dbo.Students
WHERE FirstName LIKE '_aney'


-- Cary, Mary, Gary
SELECT
FirstName,
LastName
FROM Actors
WHERE FirstName LIKE '[CM]ARY' -- Returns: Cary, Mary

SELECT
FirstName,
LastName
FROM Actors
WHERE FirstName LIKE '[^CM]ARY' -- Return: Gary


SELECT *
FROM Percentages
WHERE MyPercentage LIKE '%[%]%' -- returns 100% or 70% etc but not 0

SELECT FirstName, LastName, EmailAddr
FROM dbo.Students
WHERE FirstName LIKE '__[CD]%' -- Ardeen