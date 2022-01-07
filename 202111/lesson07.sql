-- Chapter 9 Summarizing data
-- SUM AVG MIN MAX 
-- DISTINCT
-- COUNT GROUP BY HAVING ORDER BY
SELECT * FROM MovieTitles;
SELECT * FROM Fees;
SELECT * FROM Grades;

-- Eliminating Duplicates
-- How many fee types are there and what are they?
SELECT * FROM Fees ORDER BY FeeType -- Expected 4 types
SELECT DISTINCT FeeType FROM Fees ORDER BY FeeType -- Expected 4 types only

-- Aggregate Functions << what does aggregate mean? add up, group
-- COUNT SUM AVG MIN MAX
-- How many people have homework assigned?
SELECT COUNT(*) FROM Grades WHERE GradeType = 'Homework' -- 508
SELECT COUNT(*) FROM Grades WHERE GradeType = 'Quiz' -- 492
SELECT COUNT(*) FROM Grades -- total rows in table 1000
-- How many people have got a grade?
SELECT COUNT(Grade) FROM Grades WHERE GradeType = 'Homework' -- 387 (excluding NULL values)
SELECT COUNT(Grade) FROM Grades WHERE GradeType = 'Quiz' -- 374 (excluding NULL values)
-- How many people don't have a grade yet?
SELECT COUNT(*) FROM Grades WHERE GradeType = 'Homework' AND Grade IS NULL -- 121
SELECT COUNT(*) FROM Grades WHERE GradeType = 'Quiz' AND Grade IS NULL -- 118

-- SUM how much revenue did we get from fees?
SELECT SUM(Fee) AS 'Revenue' FROM Fees -- WHERE PaidDate BETWEEN start AND end -- 30,143.73
-- How much revenue per fee type?

-- AVG MAX MIN
SELECT 'Homework' AS 'Type', AVG(Grade) AS 'Average', MAX(Grade) AS 'Highest Score', MIN(Grade) AS 'Lowest Score' FROM Grades WHERE GradeType = 'Homework'
UNION ALL
SELECT 'Quiz' AS 'Type', AVG(Grade) AS 'Average', MAX(Grade) AS 'Highest Score', MIN(Grade) AS 'Lowest Score' FROM Grades WHERE GradeType = 'Quiz'

-- AVG MAX MIN INCLUDING NULL VALUES >> ISNULL(column, default value)
SELECT 'Homework' AS 'Type', AVG(ISNULL(Grade, 0)) AS 'Average', MAX(ISNULL(Grade, 0)) AS 'Highest Score', MIN(ISNULL(Grade, 0)) AS 'Lowest Score' FROM Grades WHERE GradeType = 'Homework'
UNION ALL
SELECT 'Quiz' AS 'Type', AVG(ISNULL(Grade, 0)) AS 'Average', MAX(ISNULL(Grade, 0)) AS 'Highest Score', MIN(ISNULL(Grade, 0)) AS 'Lowest Score' FROM Grades WHERE GradeType = 'Quiz'

-- Grouping data
SELECT AVG(ISNULL(Grade,0)) AS 'Final Score', COUNT(*) AS 'Grade Count', Student 
FROM Grades
-- filter WHERE
-- GROUP
GROUP BY Student
-- ORDER
ORDER BY 'Grade Count' DESC, Student

-- SELECTION CRITERIA ON AGGREGATES (filtering aggregate columns)
-- Only take into consideration students who passed
-- Filter out individual records BEFORE calculating the AVG
SELECT AVG(ISNULL(Grade,0)) AS 'Final Score', COUNT(*) AS 'Grade Count', Student 
FROM Grades
-- filter WHERE
WHERE Grade > 70 --filter individual columns, so any record with less than 70 is not aggregated
-- GROUP
GROUP BY Student
-- ORDER
ORDER BY 'Grade Count' DESC, Student

-- Filter out groups after final score was calculated
SELECT AVG(ISNULL(Grade,0)) AS 'Final Score', COUNT(*) AS 'Grade Count', Student 
FROM Grades
-- filter WHERE
-- GROUP
GROUP BY Student
-- FILTER GROUPS
HAVING AVG(ISNULL(Grade,0)) >= 70
-- ORDER
ORDER BY 'Grade Count' DESC, 'Final Score' DESC, Student