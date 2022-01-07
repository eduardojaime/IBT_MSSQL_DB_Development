-- Boolean Logic > AND - OR - NOT - BETWEEN - IN - ISNULL
-- Extend filters
SELECT * 
FROM dbo.Students 
WHERE BirthDate >= '1999-01-01'

SELECT * 
FROM dbo.Students 
WHERE BirthDate >= '1999-01-01'
AND Country = 'China' -- AND means all conditions must be met

SELECT *
FROM dbo.Students
WHERE Country = 'China' OR Country = 'Indonesia' -- OR means only one condition has to be met

SELECT * 
FROM dbo.Students
WHERE Country = 'China' OR Country = 'Indonesia'
AND BirthDate >= '1999-01-01' -- SQL will always process AND before OR

SELECT * 
FROM dbo.Students
WHERE (Country = 'China' OR Country = 'Indonesia') -- SQL will process expresion inside parenthesis first
AND BirthDate >= '1999-01-01'

SELECT * 
FROM dbo.Students
WHERE ((Country = 'China' OR Country = 'Indonesia') AND BirthDate >= '1999-01-01') -- There can be more parenthesis
OR Country = 'France'


SELECT *
FROM dbo.Students
-- WHERE NOT (Country = 'China' OR Country = 'Indonesia')
-- WHERE NOT Country = 'China' AND NOT Country = 'Indonesia'
WHERE Country <> 'China' AND Country <> 'Indonesia'

SELECT * 
FROM dbo.Students
-- WHERE BirthDate BETWEEN '1990-01-01' AND '1999-12-31'
WHERE StudentId BETWEEN 5 AND 10

SELECT *
FROM dbo.Students
WHERE Country IN ('France', 'China', 'Indonesia') -- Specify a list of values in parenthesis

SELECT * 
FROM dbo.Students
WHERE RegistrationDate IS NULL

SELECT * 
FROM dbo.Students
WHERE RegistrationDate IS NOT NULL

-- Conditional Logic > CASE Statement
-- SELECT, WHERE, GROUP BY, ORDER BY
-- IF-THEN-ELSE
/* 
	CASE ColumnOrExpression
	WHEN value1 THEN result1
	WHEN value2 THEN result2
	(repeat WHEN-THEN any number of times)
	[ELSE DefaultResult]
	END
*/

SELECT *, 
	CASE Country
	WHEN 'France' THEN 'French'
	WHEN 'Russia' THEN 'Russian'
	WHEN 'Argentina' THEN 'Spanish'
	ELSE 'Unknown'
	END AS 'Language'
FROM dbo.Students

SELECT *,
	CASE
	WHEN RegistrationDate IS NOT NULL THEN 'Registered'
	WHEN RegistrationDate IS NULL AND Country = 'Portugal' THEN 'Exempt'
	ELSE 'Not Registered'
	END AS 'Status'
FROM dbo.Students

SELECT *
FROM NorthAmerica
ORDER BY
	Country,
	CASE Country
	WHEN 'US' THEN State
	WHEN 'CA' THEN Province
	ELSE State
	END,
	City

SELECT *
FROM CustomerList
WHERE Income >
		CASE
		WHEN Sex = 'M' AND Age >= 50 THEN 75000
		WHEN Sex = 'F' AND Age >= 35 THEN 60000
		ELSE 50000
END