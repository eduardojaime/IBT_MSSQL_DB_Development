-- Table that will be referenced by other tables
CREATE TABLE Examples.Parent (
	ParentId INT NOT NULL PRIMARY KEY
);
GO

-- Table that needs a FK 
CREATE TABLE Examples.Child (
	ChildId INT NOT NULL PRIMARY KEY,
	ParentId INT NULL -- COLUMN ALLOWS NULLS
);
GO

ALTER TABLE Examples.Child
	ADD CONSTRAINT FK_PARENT_PARENTID
		FOREIGN KEY (ParentId) 
		REFERENCES Examples.Parent (ParentId);
GO

INSERT INTO Examples.Parent VALUES (1),(2),(3);
SELECT * FROM Examples.Parent;

INSERT INTO Examples.Child (ChildId, ParentId) VALUES (1, 1); -- Success 1 exists in Parent table
INSERT INTO Examples.Child (ChildId, ParentId) VALUES (2, 99); -- Fail 99 does not exist in Parent table
INSERT INTO Examples.Child (ChildId, ParentId) VALUES (3, NULL); -- Success because ParentId allows NULL and checks do not protect against NULLs
SELECT * FROM Examples.Child;

DROP TABLE IF EXISTS Examples.Attendees;
CREATE TABLE Examples.Attendees (
	Name VARCHAR(300) NOT NULL,
	ShirtSize VARCHAR(8) NULL
);

INSERT INTO Examples.Attendees (Name, ShirtSize) VALUES ('John','Q');
DELETE FROM EXAMPLES.Attendees;

SELECT * FROM Examples.Attendees;

ALTER TABLE Examples.Attendees
	ADD CONSTRAINT CHK_SHIRT_SIZES
		CHECK (ShirtSize IN ('S','M','L','XL','XXL'))
		
INSERT INTO Examples.Attendees (Name, ShirtSize) VALUES ('Mark', 'S');

-- Catalog table, just to store sizes available in my system
CREATE TABLE Examples.ShirtSizes (
	ShirtSize VARCHAR(8) NOT NULL PRIMARY KEY
);
INSERT INTO Examples.ShirtSizes (ShirtSize) 
VALUES ('S'), ('M'), ('L'), ('XL'), ('XXL')

SELECT * FROM Examples.ShirtSizes;

-- Now DROP previous CHECK CONSTRAINT and ADD FOREIGN KEY CONSTRAINT
ALTER TABLE Examples.Attendees
	DROP CONSTRAINT CHK_SHIRT_SIZES;

ALTER TABLE Examples.Attendees
	ADD CONSTRAINT FK_SHIRT_SIZES
		FOREIGN KEY (ShirtSize)
		REFERENCES Examples.ShirtSizes (ShirtSize);

INSERT INTO Examples.Attendees (Name, ShirtSize)
VALUES ('John', 'XS');

INSERT INTO Examples.Attendees (Name, ShirtSize)
VALUES ('Mary', 'M');

INSERT INTO Examples.ShirtSizes (ShirtSize) VALUES ('XS');