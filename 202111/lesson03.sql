-- Functions: Allow you to manipulate data, by using data as input but producing a single value
-- Two types: scalar (LTRIM) and aggregate (SUM, AVG)
-- Character functions: nvarchar, varchar, char
-- Functions need arguments that are to be provided inside of the parenthesis
-- LEFT, RIGHT, SUBSTRING, LTRIM, RTRIM, UPPER, LOWER
SELECT 'SUNLIGHT' AS 'The Answer' --don't need to use FROM since this is a literal value

-- Use left to extract x number of characters, starting from the left side of a string
SELECT LEFT('SUNLIGHT', 3) AS 'The Answer'
SELECT LEFT(LastName, 1) AS 'First Letter of Last Name', LastName FROM dbo.Students

-- Use right to extract x number of characters staring from the right side of a string
SELECT RIGHT('SUNLIGHT', 5) AS 'The Answer'
SELECT RIGHT(LastName, 1) AS 'Last Letter of Last Name', LastName FROM dbo.Students

-- Use substring to extract x number of characters starting from position y in a string
SELECT 'thewhitegoat' AS 'The Answer'
SELECT SUBSTRING('thewhitegoat', 4, 5) AS 'The Answer'

-- TRIM functions remove white spaces
SELECT '          THE APPLE       ' AS 'The Answer'
SELECT LTRIM('    THE APPLE      ') AS 'The Answer' -- FROM THE LEFT SIDE 
SELECT RTRIM('    THE APPLE      ') AS 'The Answer' -- FROM THE RIGHT SIDE
SELECT TRIM('    THE APPLE      ') AS 'The Answer' -- FROM BOTH SIDES

-- Use UPPER or LOWER to switch case
SELECT 'Justin Trudeau' as 'The Primer Minister'
SELECT UPPER('Justin Trudeau') as 'The Primer Minister'
SELECT LOWER('Justin Trudeau') as 'The Primer Minister'

-- Composite function: combined functions
SELECT SUBSTRING(UPPER('Justin Trudeau'), 8, 50) as 'The Primer Minister' -- produces  TRUDEAU


-- DATE TIME: 2021-10-18 18:23
-- GETDATE(), DATEPART(), DATEDIFF()
SELECT GETDATE() AS 'Today''s Date' -- 2021-10-18 18:25:03.317

SELECT DATEPART(YEAR, '2021-10-18') AS 'Current Year'
SELECT DATEPART(DAYOFYEAR, GETDATE()) AS 'Day of Year'
SELECT DATEPART(WEEK, GETDATE()) AS 'Week Number'

SELECT DATEDIFF(DAY, GETDATE(), '2021-12-31') AS 'Days to New Year''s Eve';
SELECT DATEDIFF(WEEK, GETDATE(), '2021-12-31') AS 'Weeks to New Year''s Eve';
SELECT DATEDIFF(HOUR, GETDATE(), '2021-12-31 23:59:59') AS 'Hours to New Year';

-- Numeric
-- ROUND, RAND, PI, POWER
SELECT 712.86495 AS 'Fee'
SELECT ROUND(712.86495, 3) AS 'Fee'
SELECT ROUND(712.86495, 2) AS 'Fee'
SELECT ROUND(712.86495, 0) AS 'Fee'

SELECT PI() AS 'PI'
SELECT RAND() AS 'Random Value'
SELECT POWER(5, 2) AS '5 SQUARED'

-- CAST for conversion
SELECT
'2017-04-11' AS 'Original Date', -- '2017-04-11'
CAST('2017-04-11' AS DATETIME) AS 'Converted Date', -- '2017-04-11 00:00:00'
10 AS 'Int',
CAST(10 AS DECIMAL(5,2)) AS 'Decimal',
CAST(11.52 AS INT) AS 'Converted Integer'

SELECT CAST(ROUND(712.86495, 0) AS INT) AS 'Converted Result'