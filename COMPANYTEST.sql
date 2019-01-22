USE master
GO

IF DB_ID('CompanyTest') IS NOT NULL	
	DROP DATABASE CompanyTest

CREATE DATABASE CompanyTest
GO

USE CompanyTest
GO

CREATE TABLE Employee( --Casinos, etc
	EmpID INT NOT NULL PRIMARY KEY
	, FirstName VARCHAR(MAX) NOT NULL
	, LastName VARCHAR(MAX) NOT NULL
	, MiddleInitial VARCHAR(1) -- added
	, Gender VARCHAR(1) -- added
	, GarmType VARCHAR(MAX) --added
	, GarmSize VARCHAR(MAX) -- added
	, GarmLength VARCHAR(MAX) -- added
	, Address VARCHAR(MAX) NOT NULL
	, PhoneNmber VARCHAR(12) NOT NULL
	, Email VARCHAR(MAX) NOT NULL
	, Hierarchy INT --FK Hierarchy
	, AltID INT -- FK UserOptions
)

CREATE TABLE CompanyInfo( -- Works for all
	CompanyID INT IDENTITY(1,1) PRIMARY KEY NOT NULL
	, CompName INT NOT NULL
	, CompAddress VARCHAR(MAX)
	, CompPhone VARCHAR (15) NULL
	, CompEmail VARCHAR(MAX)
) -- used to find cleaners and manufacturers

CREATE TABLE Manufacturer( --For companies that buy their clothing 
	ManufacturerID INT IDENTITY NOT NULL PRIMARY KEY
	, ManuName VARCHAR(MAX) 
	, ManuAddress VARCHAR(MAX)
	, ManuPhone VARCHAR(MAX)
	, ManuEmail VARCHAR(MAX)
	, Garm INT --FK, Garment
	, GarmCost INT --FK, Default values
)


CREATE TABLE GarmDefaultValues(
	GarmDefaultID INT --PK
	, Gender VARCHAR(1) -- added
	, GarmType VARCHAR(MAX)
	, GarmSize VARCHAR(MAX)
	, GarmLength VARCHAR(MAX)
	, GarmCost MONEY
	, MultiUse VARCHAR(1) -- (Y , N)
	, GarmDescription VARCHAR(MAX) -- Used if there is a multiuse, mention other departnebts its for
	, JobHierarchyID INT -- FK, ADDED
	, Division VARCHAR(MAX) -- ADDED
	, Department VARCHAR(MAX) -- FK, Hierarchy, !!CHANGED TO VARCHAR FROM INT!!
	-- test with and without Division and Department, see which is faster processing and maintance control
)

CREATE TABLE GarmDepreciation(
	GarmDeprecID INT --PK
	, GarmNumOfCleanings INT
	, GarmDepreciationCost MONEY
	, GarmAlterDerep MONEY
)

CREATE TABLE GarmActivity(-- 1-1 EMPLOYEE; 1-1 GARM -- 1 Act TO 1 Emp TO 1 Garm
	GarmActivityID INT NOT NULL
	, EmpID INT -- FK Emp
	, Garm INT --FK, Garm
	, PickupTime INT -- INVENTORY
	, DropoffTime INT -- INVENTORY
	, Assigned BIT
	, Loaned BIT 
	, OneForOne BIT -- Loan one out to emp
	, CONSTRAINT GarmActID PRIMARY KEY (GarmActivityID)
)

CREATE TABLE Inventory(
--ADD, FIND, DELETE - 3 CATEGORIES
	InventoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmentID INT -- FK, Garment
	, Assignment INT --FK, Cleaner
	, PickupTime TIME 
	, PickupDate DATE
	, DropoffTime TIME
	, DropoffDate DATE
	, Barcode INT --FK, Scan
	, RFID INT --FK, Scan
)

CREATE TABLE NonTaggedGarm( -- May have to define further
	NonTaggedGarmID INT NOT NULL
	, Garm INT -- FK
	, Assigned VARCHAR(MAX) -- fk
	, Loaned BIT --May be VARCHAR, depending on how we define this
	, Sold BIT
	, CONSTRAINT NoTagsID PRIMARY KEY (NonTaggedGarmID)
)

CREATE TABLE Hierarchy(
	JobHierarchyID INT --PK
	, Division VARCHAR(MAX)
	, Department VARCHAR(MAX)
	, Job VARCHAR(MAX)
	, PAR_Level INT -- employee accountability of garments per emp; if emp has 3, then there has to be 3 at all times
)

CREATE TABLE PurchaseOrder( --Companies
	PurchaseOrderID INT NOT NULL
	, RFID INT -- FK
	, Barcode INT -- FK
	, CONSTRAINT PurchOrdID PRIMARY KEY (PurchaseOrderID)
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
	, EmpID INT -- fk EmployeeID
	, Garm INT -- FK, Garment
	, RepairType VARCHAR(MAX)
	, RepairPerson VARCHAR(MAX)
	, RepairTime TIMESTAMP
)


CREATE TABLE Locker(
	LockerNumber INT NOT NULL
	, SerialNum INT 
	, Combonation VARCHAR(8) -- INT doesnt let you properly add combination, changed to varchar(8)
	, EmpID INT --FK, Emp
	, Reasons VARCHAR(MAX)
	, CONSTRAINT LockNum PRIMARY KEY (LockerNumber)
)

CREATE TABLE TicketCreate( -- Laundry Matts 
	 AccountNumber INT NOT NULL  --pulled cus ID
	, TicketNumber INT NOT NULL  --IDENTITY NOT NULL PRIMARY KEY 
	, PickupDate DATE NULL
	, PickupTime TIME(0) NULL
	, SlotNum INT -- FK Slots, ADDED TO HERE NO LONGER on Employee
	, PlantID INT NULL
	, RouteID INT NULL
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL
	, CONSTRAINT PKTicketID PRIMARY KEY (TicketNumber)
	, CONSTRAINT FKEmpTicID FOREIGN KEY(AccountNumber)
		REFERENCES Employee(EmpID)
		ON DELETE CASCADE    
		ON UPDATE CASCADE
)

CREATE TABLE DeviceOptions(
	DeviceOptionID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, SigPad VARCHAR(MAX)
	, LabelPrinter VARCHAR(MAX)
	, TouchScreen VARCHAR(MAX)
	, BulkScanner VARCHAR(MAX)
)

CREATE TABLE GarmentCreate(
	AccountNumber INT NOT NULL 
	, TicketNumber INT NOT NULL 
	, GarmentNumber INT NOT NULL 
	, GarmDescription VARCHAR(25) NULL
	, ServicePrice DECIMAL(3,2) NULL
	, ServiceType VARCHAR(10) NULL
	, GarmColor VARCHAR(10) NULL
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL 
	, TransDateTime TIMESTAMP NOT NULL 
	, CONSTRAINT PKGarmID PRIMARY KEY (GarmentNumber)
	, CONSTRAINT FKEmpID FOREIGN KEY (AccountNumber)
		REFERENCES Employee(EmpID)
	 , CONSTRAINT FKTicID FOREIGN KEY (TicketNumber)
		REFERENCES TicketCreate(TicketNumber)		
		ON DELETE CASCADE
		ON UPDATE CASCADE
)