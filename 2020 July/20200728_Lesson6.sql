CREATE PROCEDURE Examples.ExampleReturnCodes
AS
	SELECT * FROM Examples.ShirtSizes;
GO

EXECUTE Examples.ExampleReturnCodes;

EXEC Examples.ExampleReturnCodes;

DECLARE @ReturnCode INT;
EXEC @ReturnCode = Examples.ExampleReturnCodes;
SELECT @ReturnCode; -- 0 means that the procedure ran without issues
GO

CREATE PROCEDURE Examples.UpdateShirtSizes
	@Size varchar(1)
AS 
	BEGIN TRY
		UPDATE Examples.ShirtSizes SET ShirtSize = '' WHERE ShirtSize = @Size;
		RETURN 100; -- SUCCESS!
	END TRY
	BEGIN CATCH
		RETURN -100; -- UPDATE FAILED
	END CATCH
GO

-- BATCH IS A SERIES OF STATEMENTS
SELECT * FROM Examples.ShirtSizes;
THROW 50000, 'An error occurred', 1;
SELECT * FROM EXAMPLES.Employee;
GO

SELECT * FROM Examples.ShirtSizes;
RAISERROR('An error occurred', 16, 1);
SELECT * FROM EXAMPLES.Employee;
GO

-- STORED PROCEDURE TEMPLATE
CREATE PROCEDURE MyStoredProcedureName
(
	@Param1 INT
)
AS
	BEGIN TRY
		BEGIN TRANSACTION

		-- ALL YOUR OPERATIONS

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION
	END CATCH
GO