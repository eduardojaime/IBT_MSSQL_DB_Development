USE Eduardo;
GO

DROP TABLE IF EXISTS Examples.Widget;
CREATE TABLE Examples.Widget
(
    WidgetId    int CONSTRAINT PKWidget PRIMARY KEY,
    RowLastModifiedTime datetime2(0) NOT NULL
);
GO

INSERT INTO Examples.Widget (WidgetId, RowLastModifiedTime)
VALUES (1, SYSDATETIME());
INSERT INTO Examples.Widget (WidgetId)
VALUES (1);

ALTER TABLE Examples.Widget
  ADD CONSTRAINT DFLTWidget_RowLastModifiedTime 
         DEFAULT (SYSDATETIME()) FOR RowLastModifiedTime;
GO

-- SELECT * FROM Examples.Widget;
INSERT INTO Examples.Widget(WidgetId)
VALUES (2);
INSERT INTO Examples.Widget(WidgetId)
VALUES (3);
GO

UPDATE Examples.Widget
SET RowLastModifiedTime = DEFAULT;
-- NO ID SO I'LL UPDATE ALL THE RECORDS IN THE TABLE

ALTER TABLE Examples.Widget
	ADD EnabledFlag BIT NOT NULL CONSTRAINT DFLTWidget_EnabledFlag DEFAULT(1);

CREATE TABLE Examples.AllDefaulted
(
	AllDefaultedId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	RowCreatedTime DATETIME2(0) NOT NULL CONSTRAINT DFLTAllDefaulted_RowCreatedTime DEFAULT(SYSDATETIME()),
	RowModifiedTime DATETIME2(0) NOT NULL CONSTRAINT DFLTAllDefaulted_RowModifiedTime DEFAULT(SYSDATETIME())
);
GO

-- run a couple of times
INSERT INTO Examples.AllDefaulted 
DEFAULT VALUES;

SELECT * FROM Examples.AllDefaulted;

CREATE TABLE Examples.GadgetCatalog
(
	GadgetId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	GadgetCode VARCHAR(10) NOT NULL
);
GO

-- still not unique...
INSERT INTO Examples.GadgetCatalog
VALUES ('Gadget'),('Gadget'),('Gadget');
GO

SELECT * FROM Examples.GadgetCatalog;

DELETE FROM Examples.GadgetCatalog WHERE GadgetId IN (2,3);

ALTER TABLE Examples.GadgetCatalog
	ADD CONSTRAINT AKGadgetCatalog UNIQUE (GadgetCode);

INSERT INTO Examples.GadgetCatalog
VALUES ('Widget'),('Box'),('Tool');

-- BY USING INT we are limiting -2 billion to +2 billion
-- what about quantity for a store?

-- TINYINT range -214,748.3648 to 214,748.3647
-- can you sell a product for 214k?? probably not

-- Limit the range of a value
CREATE TABLE Examples.GroceryItem
(
	ItemCost SMALLMONEY NULL
		CONSTRAINT CHKGroceryItem_ItemCost_ValidRange CHECK (ItemCost > 0 AND ItemCost < 1000)
);
GO

-- Fails with message: The INSERT statement conflicted with the CHECK constraint "CHKGroceryItem_ItemCost_ValidRange".
INSERT INTO Examples.GroceryItem VALUES (3000.95);
-- Successful
INSERT INTO Examples.GroceryItem VALUES (100.99);

-- Limit the format of a Value
CREATE TABLE Examples.Message
(
	MessageTag CHAR(5) NOT NULL,
	Comment NVARCHAR(MAX) NULL
);
GO

SELECT * FROM Examples.Message;

ALTER TABLE Examples.Message
	ADD CONSTRAINT CHKMessage_MessageTagFormat CHECK (MessageTag LIKE '[A-Z]-[0-9][0-9][0-9]');

ALTER TABLE Examples.Message
	ADD CONSTRAINT CHKMessage_CommentNotEmpty CHECK (LEN(Comment) > 0);

-- INCORRECT MESSAGE TAG AND EMPTY COMMENT
-- Fails with message: The INSERT statement conflicted with the CHECK constraint "CHKMessage_MessageTagFormat"
INSERT INTO Examples.Message (MessageTag, Comment) VALUES ('BAD', '');
-- Successful
INSERT INTO Examples.Message (MessageTag, Comment) VALUES ('A-123', 'no comment');

-- Coordinating values in two columns
CREATE TABLE Examples.Customer
(
	ForcedDisabledFlag BIT NOT NULL,
	ForcedEnabledFlag BIT NOT NULL,
	-- 0-0 and 1-1 combinations don't make sense
	CONSTRAINT CHKCustomer_ForceStatusFlagCheckTrue CHECK (NOT (ForcedDisabledFlag = 1 AND ForcedEnabledFlag = 1)),
	CONSTRAINT CHKCustomer_ForceStatusFlagCheckFalse CHECK (NOT (ForcedDisabledFlag = 0 AND ForcedEnabledFlag = 0))
);
GO
-- Fail with message: The INSERT statement conflicted with the CHECK constraint "CHKCustomer_ForceStatusFlagCheckFalse".
INSERT INTO Examples.Customer VALUES (0,0);
INSERT INTO Examples.Customer VALUES (1,1);
-- Successful
INSERT INTO Examples.Customer VALUES (0,1);

SELECT * FROM Examples.Customer;

-- Fails with message: The UPDATE statement conflicted with the CHECK constraint "CHKCustomer_ForceStatusFlagCheckFalse".
UPDATE Examples.Customer SET ForcedEnabledFlag = 0;
-- Successful
UPDATE Examples.Customer SET ForcedEnabledFlag = 0, ForcedDisabledFlag = 1;

-- Stopping point skill 2.1 slide 44