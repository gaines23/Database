CREATE DATABASE LaundromatTest;

USE LaundromatTest;

CREATE TABLE Customer( --Laundry Matt 
	CustomerID INT NOT NULL PRIMARY KEY
	, FirstName VARCHAR(MAX) NOT NULL
	, LastName VARCHAR(MAX) NOT NULL
	, Address VARCHAR(MAX) NOT NULL
	, PhoneNumber VARCHAR(12)
	, Email VARCHAR(MAX)
)

CREATE TABLE Cleaners( --  
	CleanersID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, CleanerName VARCHAR(MAX)
	, CleanerAddress VARCHAR(MAX)
	, CleanerPhone VARCHAR(MAX)
	, CleanerEmail VARCHAR(MAX)
	, TurnAroundTime TIME
	, Garm INT --FK, Garment
	, Repairs INT --FK, Repairs
	, Assingment INT -- FK(pulls in id#, emp#..etc) Employees assinged to specific garments 
)


CREATE TABLE EmpOrder( --Luandry Matts
	EmpOrderID INT NOT NULL
	, EmpID INT -- FK EmployeeID
	, Hierarchy INT -- FK Hierarchy 
	, Garm INT -- FK Garm
	, CONSTRAINT EmpOrdID PRIMARY KEY (EmpOrderID)
)

CREATE TABLE Scan(
	ScanID INT NOT NULL
	, RFID INT
	, BARCODE VARCHAR(MAX)
	, ScanTime TIMESTAMP NOT NULL
	, CONSTRAINT ScanNumID PRIMARY KEY (ScanID, ScanTime)
)


CREATE TABLE Repairs(
	RepairID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, Garm INT -- FK, Garment
	, RepairType VARCHAR(MAX)
	, RepairPerson VARCHAR(MAX)
	, RepairTime TIMESTAMP
)

CREATE TABLE TicketCreate( -- Laundry Matts 
	 TicCusAcctID INT NOT NULL  --pulled cus ID
	, TicketNumber INT NOT NULL  --IDENTITY NOT NULL PRIMARY KEY 
	, PickupDate DATE NULL
	, PickupTime TIME(0) NULL
	, PlantID INT NULL
	, RouteID INT NULL
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL
	, CONSTRAINT PKTicketID PRIMARY KEY (TicketNumber)
	, CONSTRAINT FKCusInfoID FOREIGN KEY(TicCusAcctID)
		REFERENCES Customer(Customerid)
		ON DELETE CASCADE    
		ON UPDATE CASCADE
)

-- LAUNDROMAT DATABASE