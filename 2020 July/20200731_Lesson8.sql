------Test READ COMITTED isolation level - Session 2
SELECT RowId, ColumnText
FROM Examples.IsolationLevels;

------Test READ UNCOMITTED isolation level - Session 2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT RowId, ColumnText
FROM Examples.IsolationLevels;

------Test READ UNCOMITTED using NOLOCK table hint
SELECT RowId, ColumnText
FROM Examples.IsolationLevels
WITH (NOLOCK); -- READ UNCOMMITTED

------Test REPEATABLE READ isolation level - Session 2
UPDATE Examples.IsolationLevels
    SET ColumnText = 'Row 1 Updated'
    WHERE RowId = 1;

------Create a phantom read - Session 2
INSERT INTO Examples.IsolationLevels(RowId, ColumnText)
VALUES (5, 'Row 5');

------Test the SERIALIZABLE isolation level - Session 2
INSERT INTO Examples.IsolationLevels(RowId, ColumnText)
VALUES (6, 'Row 6');

------Test the SNAPSHOT isolation level  - Session 2
INSERT INTO Examples.IsolationLevels(RowId, ColumnText)
VALUES (7, 'Row 7');
