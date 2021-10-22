-- CREATE TABLES

-- db-schema.sql > contains all the scripts to generate a database from scratch
-- CREATE TABLE
USE master;
GO

DROP DATABASE IF EXISTS IBTCOLLEGE01;
GO

CREATE DATABASE IBTCOLLEGE01;
GO

USE IBTCOLLEGE01;
GO

---- we can create tables now
CREATE TABLE Students (
	-- specify columns
	StudentId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY, -- AUTO-GENERATED ID
	FirstName NVARCHAR(200) NOT NULL, -- DOESN'T NEED IDENTITY OR DEFAULT VALUES
	LastName NVARCHAR(200) NOT NULL,
	RegistrationDate DATETIME NOT NULL DEFAULT(GETDATE())
);
GO

-- HOW DO I IDENTIFY STUDENTS UNIQUELY IN MY TABLE? PK
SELECT * FROM Students;
INSERT INTO Students (FirstName, LastName) VALUES ('Mezli', 'Cabrera');
INSERT INTO Students (FirstName, LastName) VALUES ('Roman', 'Perez');

SELECT NEWID()

-- INDEX > 

