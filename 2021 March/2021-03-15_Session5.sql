USE Eduardo;
GO

CREATE TABLE Examples.GadgetType
(
	GadgetType VARCHAR(10) NOT NULL PRIMARY KEY,
	Description VARCHAR(200) NOT NULL
);
GO

SELECT * FROM Examples.GadgetType;

INSERT INTO Examples.GadgetType (GadgetType, Description)
VALUES ('Manual', 'No batteries'),
		('Electronic', 'Lots of batteries');

ALTER TABLE Examples.Gadget
	ADD CONSTRAINT FKGadget_GadgetType
	FOREIGN KEY (GadgetType) REFERENCES Examples.GadgetType (GadgetType);
GO

CREATE VIEW Examples.GadgetExtension
AS
	SELECT Gadget.GadgetId, Gadget.GadgetNumber, Gadget.GadgetType,
			GadgetType.GadgetType AS DomainGadgetType, GadgetType.Description AS GadgetTypeDescription
	FROM Examples.Gadget JOIN Examples.GadgetType ON Gadget.GadgetType = GadgetType.GadgetType;
GO

SELECT * FROM Examples.GadgetExtension;

INSERT INTO Examples.GadgetExtension(GadgetId, GadgetNumber, GadgetType, DomainGadgetType, GadgetTypeDescription)
VALUES(7,'00000007','Acoustic','Acoustic','Sound');
GO

-- Both columns belong to GadgetType
INSERT INTO Examples.GadgetExtension(DomainGadgetType, GadgetTypeDescription)
VALUES('Acoustic','Sound');
GO
-- SELECT * FROM Examples.GadgetType;

-- SELECT * FROM Examples.Gadget
INSERT INTO Examples.GadgetExtension(GadgetId, GadgetNumber, GadgetType)
VALUES(7,'00000007','Acoustic');
GO

-- UPDATE specify which columns to modify
UPDATE Examples.GadgetExtension
SET GadgetTypeDescription = 'Uses AA batteries'
WHERE GadgetId = 1;

-- NOT POSSIBLE if you are deleting from a view that JOINs multiple tables
DELETE FROM Examples.GadgetExtension 
WHERE GadgetId = 1;

-- Partitioned Views
CREATE TABLE Examples.Invoices_NorthAmerica
(
	InvoiceId INT NOT NULL PRIMARY KEY 
		CONSTRAINT CHK_Invoices_PartKey1 CHECK (InvoiceId BETWEEN 1 AND 10000),
	CustomerId INT NOT NULL,
	InvoiceDate DATE NOT NULL
);
GO

CREATE TABLE Examples.Invoices_Europe
(
	InvoiceId INT NOT NULL PRIMARY KEY 
		CONSTRAINT CHK_Invoices_PartKey2 CHECK (InvoiceId BETWEEN 10001 AND 20000),
	CustomerId INT NOT NULL,
	InvoiceDate DATE NOT NULL
);
GO

-- IMPORT DATA FROM ANOTHER DATABASE
INSERT INTO Examples.Invoices_NorthAmerica (InvoiceId, CustomerId, InvoiceDate)
SELECT InvoiceId, CustomerId, InvoiceDate
FROM WideWorldImporters.Sales.Invoices -- DATABASE.SCHEMA.TABLE
WHERE InvoiceId BETWEEN 1 AND 10000;

INSERT INTO Examples.Invoices_Europe (InvoiceId, CustomerId, InvoiceDate)
SELECT InvoiceId, CustomerId, InvoiceDate
FROM WideWorldImporters.Sales.Invoices
WHERE InvoiceID BETWEEN 10001 AND 20000;

SELECT * FROM Examples.Invoices_NorthAmerica;
SELECT * FROM Examples.Invoices_Europe;