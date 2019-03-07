USE master
GO

IF DB_ID('CompanyTest') IS NOT NULL	
	DROP DATABASE CompanyTest

CREATE DATABASE CompanyTest
GO

USE CompanyTest
GO


------ Employee information and related tables ------------------

CREATE TABLE Employee( --Basic emp information; Info for Hierarchy and Garms
	EmpID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, FirstName VARCHAR(MAX) NOT NULL
	, LastName VARCHAR(MAX) NOT NULL
	, MiddleInitial VARCHAR(1)
	, Gender VARCHAR(1)
	, GarmType VARCHAR(MAX)
	, GarmSize VARCHAR(MAX)
	, GarmLength VARCHAR(MAX)
	, Address VARCHAR(MAX) NOT NULL
	, PhoneNmber VARCHAR(12) NOT NULL
	, Email VARCHAR(MAX) NOT NULL
	, Hierarchy INT --FK Hierarchy
	, AltID INT -- FK UserOptions, don't have this yet!
	, ReturnID INT -- FK, ReturnedSales, ID
	, AlterationInstructions VARCHAR(MAX) 
	--, CONSTRAINT FKHierarchyEmp FOREIGN KEY (Hierarchy)
	--	REFERENCES Hierarchy(JobHierarchyID)
)

/*
DROP TABLE Employee
SELECT * FROM Employee
*/

-- This is where GarmID is created; scanned -> inventory -> assigned to emp -> activity
CREATE TABLE EmpJobGarm( -- Has specific garm info/inventory for specific emp; Overall info of garm, non logistical specifics
-- Employee, Hierarchy
-- GarmentNumber or Autoincrement PK?
	EmpJobGarmID INT NOT NULL
	, EmpID INT -- FK, Employee
	, Hierarchy INT -- Hiearchy IDn
	, GarmentID INT -- once Scanned, assigned to Emp and receives new GarmID
	, GarmActivity INT -- GarmActivity information
	, SlotNum INT -- FK, GarmActivity
	, GarmType VARCHAR(MAX)-- specific to garm
	, Size VARCHAR(MAX) -- specific to garm
	, GarmLength VARCHAR(MAX) -- specific to garm
	, EqEmpGarms INT -- employee accountability of garments per emp; if emp has 3, then there has to be 3 at all times
	, CONSTRAINT PKEmpJobGarm PRIMARY KEY (EmpID, GarmentID)
)

/*
DROP TABLE EmpJobGarm
SELECT * FROM EmpJobGarm
*/

CREATE TABLE Locker(
	LockerNumber INT NOT NULL
	, SerialNum INT 
	, Combonation VARCHAR(8) -- INT doesnt let you properly add combination, changed to varchar(8)
	, EmpID INT --FK, Emp
	, Reasons VARCHAR(MAX)
	, CONSTRAINT LockNum PRIMARY KEY (LockerNumber)
/*	, CONSTRAINT FKEmpIDLocker FOREIGN KEY (EmpID)
		REFERENCES Employee(EmpID) -- ADDED CONSTRAINT
		ON DELETE CASCADE
		ON UPDATE CASCADE
*/
)

-------- Company, Manufacturer, Cleaning Information -----------------------------

CREATE TABLE CompanyInfo( -- Basic company information
	CompanyID INT IDENTITY(1,1) PRIMARY KEY NOT NULL
	, CompName INT NOT NULL
	, CompAddress VARCHAR(MAX)
	, CompPhone VARCHAR (15) NULL
	, CompEmail VARCHAR(MAX)
) -- used to find cleaners and manufacturers

CREATE TABLE Manufacturer( --For companies that buy their clothing from outside companies/vendors
--PurchaseOrder, GarmDefaultValues
	ManufacturerID INT IDENTITY NOT NULL PRIMARY KEY
	, ManuName VARCHAR(MAX) 
	, ManuAddress VARCHAR(MAX)
	, ManuPhone VARCHAR(MAX)
	, ManuEmail VARCHAR(MAX)
/*
	, Garm INT --FK, Garment
	, GarmCost DECIMAL(3,2) --FK, Default values
*/
/*	, CONSTRAINT FKGarmManu FOREIGN KEY (Garm)
		REFERENCES GarmDefaultValues(GarmDefaultID)
	, FOREIGN KEY (GarmCost) REFERENCES GarmDefaultValues(GarmCost)
*/
)

CREATE TABLE CleanerInfo(
	CleanerID INT IDENTITY(1,1) PRIMARY KEY NOT NULL
	, CleanerName INT NOT NULL
	, CleanerAddress VARCHAR(MAX)
	, CleanerPhone VARCHAR (15) NULL
	, CleanerEmail VARCHAR(MAX)
)

--------- Garment Information and Assignment Details -------------------------------------------------------

CREATE TABLE Hierarchy(--dictates specific garms for emps, notifies when more of specific garm needs to be ordered
-- Emp, EmpJobGarm, PurchaseOrder, 
	JobHierarchyID INT IDENTITY(1,1) NOT NULL PRIMARY KEY--PK
	, Division VARCHAR(MAX)
	, Department VARCHAR(MAX)
	, Job VARCHAR(MAX)
	, Gender VARCHAR(MAX) -- Male, Female, Unisex
	, ParLevel INT -- How many total per Job
	, NumOfReserveStock DECIMAL(3,2) -- Percentage needed for full reserve stock
	, DesignatedSlots INT -- slot # between slot # for each Dept, Job - slot #; Will be a Procedure or Function
)

/*
DROP TABLE Hierarchy
SELECT * FROM HIERARCHY
*/

--check to see if we can pull Hierarchy data without adding Dept and Division columns
CREATE TABLE GarmDefaultValues( --Specified for each Manufacturer for each garment; Sized may have different costs
-- Type, Size, Length are ALL PREDEFINED; Added customizable options for missing values
	GarmDefaultID INT IDENTITY(1,1) NOT NULL PRIMARY KEY --PK; unless company has specific default values
	, Gender VARCHAR(1) -- added
	, GarmType VARCHAR(MAX)
	, GarmSize VARCHAR(MAX)
	, GarmLength VARCHAR(MAX)
	, GarmCost DECIMAL(3,2) -- Can be edited for either historical costs or current date forward
	, GarmWeight INT 
	, MultiUse VARCHAR(1) -- (Y , N)
	, EqEmpGarm INT -- Defined for specific Emp garm amount; max amount of garms
	, EqGarmAmount INT -- Defined for specific garm; max amount of garms
	, LifeExpectancy INT -- number of days used before worn out
	, MaxNumOfCleanings INT -- number of times can go through wash before worn out 
		--Life expectancy is the total days worn, Max#OfCleanings is total times washed
	, GarmDescription VARCHAR(MAX) -- Used if there is a multiuse, mention other departments its for
	, JobHierarchyID INT -- FK, ADDED
	, GarmManu INT -- FK

--	, Division VARCHAR(MAX) -- ADDED
--	, Department VARCHAR(MAX) -- FK, Hierarchy, !!CHANGED TO VARCHAR FROM INT!!
--	, ManufacturerName VARCHAR(MAX)
/*	, CONSTRAINT FKManufacturer FOREIGN KEY (Manufacturer)
		REFERENCES Manufacturer(ManuName)
	, CONSTRAINT FKDepartment FOREIGN KEY (Department)
		REFERENCES Hierarchy(Department)
	, CONSTRAINT FKHierarchy FOREIGN KEY (JobHierarchyID)
		REFERENCES Hierarchy(JobHierarchyID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	-- test with and without Division and Department, see which is faster processing and maintance control
*/
)

/*
DROP TABLE GarmDefaultValues
SELECT * FROM GarmDefaultValues
*/
--------------------------------------------------------------------------
-- GarmDefaultValues ADDED Foreign Keys ----------------------------------
-- Some tables needed to be created before FKs----------------------------

/*
ALTER TABLE GarmDefaultValues
ADD FOREIGN KEY (Manufacturer) REFERENCES Manufacturer(ManuName)

ALTER TABLE GarmDefaultValues
ADD FOREIGN KEY (Department) REFERENCES Hierarchy(Department)

ALTER TABLE GarmDefaultValues
ADD CONSTRAINT (FKHierarchy)
FOREIGN KEY (JobHierarchyID) REFERENCES Heirarchy(JobHierarchyID)
*/

--------------------------------------------------------------------------

CREATE TABLE GarmDepreciation(--Calculated depreciation costs and rates
-- Reaches specific rate - add to purchase order?
-- PurchaseOrder, GarmDefault, EmpJobGarm
	GarmDeprecID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, EmpID INT -- FK
--	, TicketNumber INT -- FK
	, GarmentID INT --FK
	, GarmMaxNumOfCleanings INT
	, GarmNumOfCleanings INT
	, GarmDepreciationCost DECIMAL(3,2)
	, GarmAlterCost DECIMAL(3,2) -- What is this? JK it's when there are repairs needed to be done on it
	, PercentOfDepreciation INT -- Might have to write calc for this
		-- ((Max#OfCleanings) - (GarmNumOfCleanings))/100.0 = %

/*	, CONSTRAINT FKEmpID FOREIGN KEY(EmpID)
		REFERENCES Employee(EmpID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	, CONSTRAINT FKTicketID FOREIGN KEY(TicketNumber)
		REFERENCES TicketCreate(TicketNumber)
	, CONSTRAINT FKGarmentID FOREIGN KEY(GarmentNumber)
		REFERENCES GarmentCreate(GarmentNumber)
*/
)

----- Garment Inventory and Tracking -----------------------------------------------------
-- Already have a preassigned ID from manufacturer 
CREATE TABLE PreTaggedGarments( -- Garments received from PurchaseOrder, not barcoded or chipped
-- Once Tagged, item is automatically subtracted
	PreTaggedGarmID INT -- IDs created by Purchase Order Amount subtracted by actual amount (60 shirts - 50 = 1 thru 10 IDs)
	, PurchaseOrder INT -- FK, PurchaseOrder
	, ItemsMissing INT -- item removed from box but not entered into system
	, CONSTRAINT PreTaggedID PRIMARY KEY (PreTaggedGarmID)
)

CREATE TABLE Scan( 
	ScanID INT NOT NULL
	, RFID INT
	, BARCODE VARCHAR -- CHANGED FROM MAX, NEED TO SEE IF THIS WORKS WITH INPUT VALUES
	, ScanTime DATETIME NOT NULL
	, CONSTRAINT ScanNumID PRIMARY KEY (ScanID, ScanTime)
	, CONSTRAINT barcode UNIQUE (BARCODE)
	, CONSTRAINT rfid UNIQUE (RFID)
)

-- SELECT * FROM Scan
-- DROP TABLE Scan

CREATE TABLE Inventory( --Overall inventory; Always be updating; This is where everthing will CASCADE from
-- If tagged, assigns GarmNum to EmpID
-- Hand in hand with GarmActivity -- tracks specific garment if assigned
--ADD, FIND, DELETE - 3 CATEGORIES
	GarmentID INT -- assigned once assigned to emp; FK EmpJobGarm
	, EmpID INT -- FK, Employee, only when assigned
	, SlotNum INT -- FK, GarmActivity
	, Conveyor INT -- FK, GarmActivity
	, GarmActivityID INT -- FK, GarmActivity
	, GarmDefaultID INT -- FK, GarmDefaultValue
	, ManufacturerID INT -- FK, Manufacturer
	, GarmCost DECIMAL(3,2) -- FK, DefaultValues
--	, AssignmentStatus INT --FK, (NonTagged, Cleaner, etc) RIGHT?!
		-- Probably have to write PROC since it takes info from different tables to categorize Status
	, Barcode INT --Scan
	, RFID INT -- Scan
	, GarmLocation VARCHAR(MAX) -- Storage, laundry, etc (probably)
	, EmpResponsible INT -- May just be EmpID as well, FK Emp
	, CONSTRAINT GarmID PRIMARY KEY (GarmentID)
)

CREATE TABLE GarmActivity(-- Per day/per use -- Pwe garment 
-- Would activity influence Depreciation value? (yes?)
-- Once in inventory, will be assigned, loaned, w/e
	GarmActivityID INT IDENTITY(1,1) NOT NULL
	, EmpID INT -- FK Emp
	, GarmID INT --FK, EmpJobGarm; assigned to Emp and receives new GarmID
	, SlotNum INT -- Slot assigned to specific garm then updated in inventory 
	, Conveyor INT -- When there's more than 1 coneyor, this gets assigned as well
	, RFID INT -- Inventory
	, Barcode INT -- Inventory
	, CleaningActivityID INT -- FK, CleaningActivity
	, PickupTime TIME
	, PickupDate DATE
	, DropoffTime TIME
	, DropoffDate DATE
	, Assigned BIT
	, Loaned INT -- 
	, OneForOne BIT -- Loan one out to emp
	, Missing DATETIME -- lost or stolen
	, DelinquentGarm BIT -- only if not returned -- Cleaning Activity 
	, CONSTRAINT PKGarmActivityID PRIMARY KEY(EmpID, SlotNum) --Maybe?
)

-- Have to figure out what updates what for missing garment info
-- Missing = lost/stolen; Delinquent = never returned back to company
CREATE TABLE MissingGarments(
	MissingGarmID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmID INT -- FK, EmpJobGarm
	, MissingDateTime DATETIME -- FK, GarmActivity, Or GarmActivity
	, GarmActivityID INT --FK, GarmActivity
	, GarmDefaultValueID INT -- FK, GarmDefaultValue
	, DelinquentGarm BIT -- FK, CleaningActivity
)

CREATE TABLE DeletedGarments( --Will stay in db for 30 days (or have customer 
-- choose time frame?
	DeletedGarmsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmID INT -- FK, Inventory
	, MissingGarmID INT -- FK, MissingGarment
	, NonTaggedID INT -- FK, NonTaggedGarm
)

-- Should Assigned be BIT?
CREATE TABLE NonTaggedGarm( --ID calculated from TOTAL ORDERED - TOTAL NOT TAGGED (50-40=10 new IDs)
-- Items scanned, but not tagged for Emp use
-- Still has GarmID
-- May have to define further
	NonTaggedGarmID INT NOT NULL
	, GarmID INT -- FK
	, Assigned VARCHAR(MAX) -- fk, temp assignment (BIT?)
	, EmpID INT
	, Loaned BIT --May be VARCHAR, depending on how we define this (by name?, YES/NO?)
	, Sold BIT
	, GarmLocation VARCHAR(MAX) -- FK, Inventory
	, CONSTRAINT NoTagsID PRIMARY KEY (NonTaggedGarmID, GarmID)
/*	, CONSTRAINT FKGarmNT FOREIGN KEY (Garm)
		REFERENCES GarmDefaultValues(GarmDefaultID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
*/
)

----------- Accounting/Sales -----------------------------------
--- Purchases identify need for additional inventory
--- Make PAR Levels perfect to avoid excess purchases

CREATE TABLE Accounting(
	AccountingID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, PurchaseOrderID INT -- FK, PurchaseOrder
	, EmpOrderID INT -- FK, EmpOrderID
	, TotalSales DECIMAL(6,2)
	, TotalPurchases DECIMAL(6,2)
	, TotalEmpOrder DECIMAL(6,2)
	, TotalCombinedPurchases DECIMAL(6,2) -- Combined Emp and Purchase Order
)

CREATE TABLE Sales( -- Probably have to add more
-- Sale per garment, at least from what it loo
-- rework - 
	SalesID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmentID INT -- FK, 
	, SalesPrice Decimal(3,2)  -- per garment
	, PurchaseOrderID INT -- dont need because purchase info should already be logged in inv
	, EmpOrderID INT -- fk
	, GarmentDefaultValue INT -- fkz
	, PurchaseDate DATE
	, PurchaseCost DECIMAL(3,2) -- per garment
	, PurchasedAmount INT
	, SalesTax DECIMAL(3,2)
)

CREATE TABLE ReturnedSales(
	ReturnedID INT IDENTITY(1,1) NOT NULL PRIMARY KEY-- PK, 
	, SalesID INT --FK, Sales
	--, PurchaseOrderID INT --FK, PurchaseOrder
	, EmpOrderID INT --FK, EmpOrder
	, Reimbursement DECIMAL(3,2)
	, EmpID INT -- FK, EmpOrder
	, GarmID INT
)

-- DROP TABLE ReturnedSales

CREATE TABLE PurchaseOrder( --Companies place order to manufactures for specific amount of each garment; 
--Ties in per type and amount of Garms ordered by company 
	PurchaseOrderID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmentDefaultValue INT -- FK
	, Garmsize VARCHAR(MAX) -- FK, Garmdefaultvalue
	, OrderAmount INT
	, Total DECIMAL(3,2)
	, PurchaseDate DATE
	, ExpectedDate DATE
	, Reason VARCHAR(MAX) -- May just be drop down task
	, ManufacturerID INT -- FK, Laundry, Manufacturer
	, ReceivedOrder BIT -- PreTaggedGarments
) -- PURCAHSE ORDER ID MIGHT CHANGE BECAUSE HOW COMPANIES TRACK

CREATE TABLE EmpOrder( --Luandry Matts; What each employee needs ordered for themselves
	EmpOrderID INT NOT NULL
	, EmpID INT -- FK EmployeeID
	, RFID INT -- FK
	, Barcode INT -- FK
	, Garment INT -- FK Garm
	, Hierarchy INT -- FK Hierarchy 
	, GarmentSize VARCHAR(MAX)
	, OrderAmount INT 
	, Total DECIMAL(3,2)
	, GarmDepreciationSales DECIMAL(3,2)
	, GarmDeprecPercentage INT
	-- , CONSTRAINT EmpOrdID PRIMARY KEY (EmpOrderID)
		-- Will be a constraint when OrderIDs are assigned, until now, 
		-- ID is (1,1) increment
) -- TRY RUNNING AT HOME


------ Cleaning and Repair Information ---------------------------------------------------------
-- Check-In, Ship, Receive, Check-In & Ship, Re-Clean

CREATE TABLE CleaningActivity( -- Needs to be cleaned(tehe) up
-- Might have to rethink PK
	CleaningActID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, CleanerName INT -- FK, CleanerInfo
	, GarmID INT -- FK, GarmActivity
	, RFID INT -- FK, Inventory
	, Barcode INT -- FK, Inventory
	, CheckIn BIT -- Yes, No; if Yes, then "At Cleaner"; No, then "At Checkin"
	, CheckInTime TIME
	, CheckInDate Date
	, CheckOutTime TIME 
	, CheckOutDate DATE
	, DelinquentGarm BIT -- When not Checkedin for a period of time, Yes/No
		-- If yes, placed in Missing, then deleted 
)

CREATE TABLE Repairs(--Customizable time standards; can assign specific jobs to specific Emps
	RepairID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, EmpID INT -- FK EmployeeID
	, Garm INT -- FK, Garment
	, RepairType VARCHAR(MAX)
	, RepairPerson VARCHAR(MAX)
	, Received DATETIME
	, Completed DATETIME
	, RepairCost DECIMAL(3,2) --Added for now, may not need in furture depending how repairs are done (in house?, cost for time/materials?)
/*	, CONSTRAINT FKGarmRepair FOREIGN KEY (Garm)
		REFERENCES GarmDefaultValues(GarmDefaultID)
	, CONSTRAINT FKEmpIDRepairs FOREIGN KEY (EmpID)
		REFERENCES Employee(EmpID)
		ON DELETE CASCADE
		ON UPDATE CASCADE 
*/
) -- ADDED FK's


------- Miscellaneous -----------------------------------------------------------
CREATE TABLE DeviceOptions(
	DeviceOptionID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, SigPad VARCHAR(MAX)
	, LabelPrinter VARCHAR(MAX)
	, TouchScreen VARCHAR(MAX)
	, BulkScanner VARCHAR(MAX)
)









----- Might Not Need -------------------------------------------------------------

----- Tickets should be used only for Emps that have multiple garments on one 
---- or separate slots

/*
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
/*	, CONSTRAINT FKEmpTicID FOREIGN KEY(AccountNumber)
		REFERENCES Employee(EmpID)
		ON DELETE CASCADE    
		ON UPDATE CASCADE
*/
)
*/
