CREATE TABLE Examples.Orders (
	OrderId INT NOT NULL PRIMARY KEY,
	OrderDate DATETIME NULL,
	Amount DECIMAL(10,2) NULL
)

CREATE TABLE Examples.LogOrders (
	LogId INT IDENTITY(1,1) PRIMARY KEY,
	OrderId INT NOT NULL,
	SystemName NVARCHAR(30) NOT NULL,
	TransactionDate DATETIME NOT NULL
)

SELECT * FROM Examples.Orders;
SELECT * FROM Examples.LogOrders;

INSERT INTO Examples.Orders VALUES (100, null, null);
GO

CREATE TRIGGER Examples.LogOrderWithDefaultDate
ON Examples.Orders
AFTER INSERT
AS
	BEGIN
		BEGIN TRY
			UPDATE Orders
			SET OrderDate = CURRENT_TIMESTAMP
			WHERE OrderId = inserted.OrderId

			INSERT INTO Examples.LogOrders (OrderId, SystemName, TransactionDate)
			VALUES (inserted.OrderId, 'System A', CURRENT_TIMESTAMP)
		END TRY
		BEGIN CATCH
			IF XACT_STATE() <> 0
				ROLLBACK TRANSACTION;
		END CATCH
	END
GO

CREATE TABLE UserDetails 
(
	UserId INT NOT NULL PRIMARY KEY,
	FullName NVARCHAR(300) NOT NULL,
	BirthDate DATETIME NOT NULL,
	UserTypeId INT NOT NULL -- ideally a fk constraint here
)

CREATE TABLE UserType 
(
	UserTypeId INT NOT NULL,
	Description NVARCHAR(100)
)

-- Insert your catalog values manually
INSERT INTO UserType VALUES
(1, 'TEACHER'),
(2, 'STUDENT'),
(3, 'STAFF')

SELECT * FROM UserType; -- User type id has to have a value in the range of 1 to 3

insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (1, 'Blanch Hadwick', '1996-07-31', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (2, 'Taffy Caffin', '1992-12-07', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (3, 'Rianon Ker', '1993-01-03', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (4, 'Roddy Van Driel', '1981-07-09', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (5, 'Deva Kroger', '1997-06-05', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (6, 'Andras Ramalhete', '1983-09-30', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (7, 'Donovan Doiley', '1995-01-16', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (8, 'Christiane Frensche', '1984-11-18', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (9, 'Birgitta Brecknall', '1989-05-08', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (10, 'Thorn Killimister', '1989-04-01', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (11, 'Tedman Izzat', '1989-04-20', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (12, 'Wendell Borkett', '1986-09-26', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (13, 'Emmalynne Anyene', '1992-09-12', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (14, 'Olin Grishunin', '1983-07-31', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (15, 'Benedict Gendricke', '1999-12-29', 2);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (16, 'Francklin Andriveau', '1999-05-11', 2);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (17, 'Demeter Stoodale', '1987-12-27', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (18, 'Sonia Lightbourn', '1998-06-25', 2);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (19, 'Anette Chastan', '1993-03-04', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (20, 'Spence Bloomer', '1982-10-06', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (21, 'Garrett Dannel', '1997-09-07', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (22, 'Gonzalo Bidder', '1994-01-24', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (23, 'Terence Swindlehurst', '1999-11-15', 2);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (24, 'Amelie Aslie', '1990-01-17', 3);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (25, 'Eda Samples', '1981-05-04', 1);
insert into UserDetails (UserId, FullName, BirthDate, UserTypeId) values (26, 'Adena Dreghorn', '1996-03-04', 1);

SELECT * 
FROM dbo.UserDetails as a
JOIN dbo.UserType as b ON a.UserTypeId = b.UserTypeId 