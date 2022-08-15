CREATE TABLE [dbo].[Customers]
(
	ID [int] IDENTITY(1,1) NOT NULL,
	Name nvarchar(200),
	CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
	(
	  ID ASC
	)
)

CREATE TABLE [dbo].[Orders]
(
	ID [int] IDENTITY(1,1) NOT NULL,
	CustomerId int,
	CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
	(
	  ID ASC
	)
)

ALTER TABLE [dbo].[Orders]
   ADD CONSTRAINT FK_CustomerId FOREIGN KEY (CustomerId)
      REFERENCES [dbo].[Customers] (ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

INSERT INTO Customers (Name) 
VALUES ('Max')
, ('Pavel')
, ('Ivan')
, ('Leonid')

INSERT INTO Orders (CustomerId)
VALUES (2)
, (4)

-- the task:
-- ???????? ????? ???? ??????????? ?? ??????????? ?? ????? ??????? ? ??????? 
-- | Customers |
-- |      Max       |
-- |      Ivan       |

-- the 1st way:
DECLARE @BuyersIds TABLE (ID int)
INSERT INTO @BuyersIds 
SELECT c.ID
FROM Customers c
INNER JOIN Orders o on o.CustomerId = c.ID

SELECT c.Name as Customers 
FROM Customers c
WHERE c.ID NOT IN (SELECT * FROM @BuyersIds)
-- end of the 1st way

-- the 2nd way:
SELECT c.Name as Customers FROM Customers c
LEFT JOIN Orders o on o.CustomerId = c.ID
WHERE o.CustomerId IS NULL
-- end of the 2nd way