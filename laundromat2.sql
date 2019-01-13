USE master
GO

IF DB_ID('LaundomatTest') IS NOT NULL
	DROP DATABASE LaundromatTest

CREATE DATABASE LaundromatTest1;

USE LaundromatTest1;

CREATE TABLE Customer(
	CustomerID INT NOT NULL PRIMARY KEY
	, FirstName VARCHAR(MAX) NOT NULL
	, LastName VARCHAR(MAX) NOT NULL
	, Address VARCHAR(MAX) NOT NULL
	, PhoneNumber VARCHAR(15)
	, Email VARCHAR(MAX)
)

CREATE TABLE Cleaners(
	CleanersID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, CleanerName VARCHAR(MAX)
	, CleanerAddress VARCHAR(MAX)
	, CleanerPhone VARCHAR(15)
	, CleanerEmail VARCHAR(MAX)
	, TurnAroundTime TIME
	, Garm INT --FK, Garment
	, Repairs INT --FK, Repairs
	, CONSTRAINT FKGarm FOREIGN KEY (Garm)
		REFERENCES GarmentCreate(GarmentNumber)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	, CONSTRAINT FKRepairs FOREIGN KEY (Repairs)
		REFERENCES Repairs(RepairID)
)

CREATE TABLE CusOrder( -- Changed to View; Deleted Assignment Column
	CusOrderID INT NOT NULL
	, CusID INT -- FK CustomerID
	, Garm INT -- FK Garm
	, CONSTRAINT CusOrdID PRIMARY KEY (CusOrderID)
)

CREATE TABLE SlotAssignment(
	SlotAssignmentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, SlotNumber INT NOT NULL
	, ConveyourNum INT NOT NULL
	, CusID INT NOT NULL
	, GarmID INT NOT NULL
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
	, CusID INT NOT NULL -- fk to customer
	, GarmID INT -- FK, Garment
	, RepairType VARCHAR(MAX)
	, RepairPerson VARCHAR(MAX)
	, RepairTime TIMESTAMP
	, CONSTRAINT FKCusInfo FOREIGN KEY(CusID)
		REFERENCES Customer(Customerid)
		ON DELETE CASCADE    
		ON UPDATE CASCADE
)

CREATE TABLE GarmDefaultValues(
	GarmDefaultID INT IDENTITY(1,1) PRIMARY KEY NOT NULL
	, GarmType VARCHAR(MAX)
	, GarmSize VARCHAR(MAX)
	, GarmLength VARCHAR(MAX)
	, GarmCost VARCHAR(MAX)
	, GarmColor BIT
	, GarmDescription VARCHAR(MAX)
)

CREATE TABLE Accounting( --probably need to add more in future
	AccoutingID INT IDENTITY(1,1) NOT NULL PRIMARY KEY 
	, CusID INT
	, TicketNum INT
	, GarmNum INT
	, TotalCost INT  
	, CONSTRAINT FKCusID FOREIGN KEY (CusID)
		REFERENCES Customer(CustomerID)
		ON DELETE CASCADE
	, CONSTRAINT FKTicketNum FOREIGN KEY (TicketNum)
		REFERENCES TicketCreate(TicketNumber)
	, CONSTRAINT FKGarmNum FOREIGN KEY (GarmNum)
		REFERENCES GarmentCreate(GarmentNumber)
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

CREATE TABLE GarmentCreate(
	GarmCusAcctID INT NOT NULL 
	, TicketNumber INT NOT NULL 
	, GarmentNumber INT NOT NULL 
	, GarmDescription VARCHAR(25) NULL
	, ServicePrice DECIMAL(3,2) NULL
	, ServiceType VARCHAR(10) NULL
	, GarmColor VARCHAR(10) NULL
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL 
	, CONSTRAINT PKGarmID PRIMARY KEY (GarmentNumber)
	, CONSTRAINT FKCusAcctID FOREIGN KEY (GarmCusAcctID)
		REFERENCES Customer(CustomerID)
	 , CONSTRAINT FKTicNumID FOREIGN KEY (TicketNumber)
		REFERENCES TicketCreate(TicketNumber)		
		ON DELETE CASCADE
		ON UPDATE CASCADE
)






-- research Accouting Table - may need to be updated
-- SlotAssignment Table - Will be encoded on the machine code 
-- Added GarmDefaultVaules and Accounting Tables
-- Deleted the Assignment Coulmn from Cleaners Table