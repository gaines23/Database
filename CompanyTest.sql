USE master
GO

IF DB_ID('CompanyTest') IS NOT NULL	
	DROP DATABASE CompanyTest

CREATE DATABASE CompanyTest
GO

USE CompanyTest
GO

-- Placed each section in the order I believe everything would read off the other tables
	-- Will help determine PKs and FKs

-- TO DO:
	-- Have to rename all definitions if they are too much like InvoTech
	-- Need to focus on PAR Level logic
	-- Merge Garment Definitions
	-- Function to have equal Physical and System Inventory
	-- Scheduling Procedures
		-- Updates, Deletes, Modifications
	-- Think about how to do Garm, Emp updates (mispelled name, wrong size, etc)


-- Changes I made to DB recently:
	-- Changed up some methods for creating FKs, you will see below
	-- Changed Garm Cost to DECIMAL(3,2) from MONEY 
	-- Chnged MONEY(s) to DECIMAL (3,2) IN GarmDepreciation 
	-- Added RepairsCost for customers that charged for repairs or get charged
	-- Added new way Purchase Order will be ID'ed
	-- Added GarmDefaultValue and OrderAmount to PurchaseOrder for better tracking and cost calculations
	-- Added FK Constraints to RFID and Barcode in Inventory for all new garments that are purchased 
	-- Added EmpID, TicketNumber, GarmentNumber to GarmentDepreciation to track specific garment
		-- Added Cascade constraints to EmpID
	-- Thought that Inventory should be a whole inventory that lays out every employees garments

	-- NonTagged Inventory will hold all of the non tags that can be placed in inventory if an Emp needs a new garment
	-- Added Total for each garmentID in Purchase Order
	-- Added PAR Level on Inventory that will calculate total garms per Garm
	-- Added PAR Level on Hierarchy for total per each garm
	-- Added Sex on Hierarchy 
	-- Addded Percentage of reserve stock needed for each garment in Hierarchy
		--can change to GarmDefault if more logical
	-- Added LifeExpectancy and GarmWeight to GarmDefaultValues
	-- Added DesignatedSlots to Hierarchy -- Will need a Proc or Func to determine slots

	-- Added EmpJobGarm to track emp specific garms
	-- Added Cleaner Business info and Cleaning Acitivty

	-- Added PreTagged Table
	-- Added Accounting and Sales Tables under Accounting section
	-- Changed everything from TIMESTAMP to DATE and TIME - Timestamp doesn't always work properly
	-- Deleted "RepairTime", added Received and Completed as DATETIME
	-- Added DelinquentGarm to GarmActivity; Then placed in MissingGarm
	-- Added MissingGarm and DeletedGarm Tables
	-- 



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
	, AltID INT -- FK UserOptions
	, Reimbursement INT -- FK, ReturnedSales
	, AlteractionInstructions VARCHAR(MAX) 
	, CONSTRAINT FKHierarchyEmp FOREIGN KEY (Hierarchy)
		REFERENCES Hierarchy(JobHierarchyID)
)

CREATE TABLE EmpJobGarm( -- Has specific garm info/inventory for specific emp; Overall info of garm, non logistical specifics
-- Employee, Hierarchy
-- GarmentNumber or Autoincrement PK?
	EmpJobGarmID INT IDENTITY (1,1) NOT NULL PRIMARY KEY -- Autoincrement
	, EmpID INT -- Employee 
	, GarmNum INT -- FK, GarmActivity
	, GarmActivity INT -- GarmActivity information
	, GarmType VARCHAR(MAX)-- specific to garm
	, Size VARCHAR(MAX) -- specific to garm
	, GarmLength VARCHAR(MAX) -- specific to garm
	, EmpPAR_Level INT -- employee accountability of garments per emp; if emp has 3, then there has to be 3 at all times
)

CREATE TABLE Locker(
	LockerNumber INT NOT NULL
	, SerialNum INT 
	, Combonation VARCHAR(8) -- INT doesnt let you properly add combination, changed to varchar(8)
	, EmpID INT --FK, Emp
	, Reasons VARCHAR(MAX)
	, CONSTRAINT LockNum PRIMARY KEY (LockerNumber)
	, CONSTRAINT FKEmpIDLocker FOREIGN KEY (EmpID)
		REFERENCES Employee(EmpID) -- ADDED CONSTRAINT
		ON DELETE CASCADE
		ON UPDATE CASCADE
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
	, Garm INT --FK, Garment
	, GarmCost DECIMAL(3,2) --FK, Default values
	, CONSTRAINT FKGarmManu FOREIGN KEY (Garm)
		REFERENCES GarmDefaultValues(GarmDefaultID)
	, FOREIGN KEY (GarmCost) REFERENCES GarmDefaultValues(GarmCost)
)

CREATE TABLE CleanerInfo(
	CompanyID INT IDENTITY(1,1) PRIMARY KEY NOT NULL
	, CompName INT NOT NULL
	, CompAddress VARCHAR(MAX)
	, CompPhone VARCHAR (15) NULL
	, CompEmail VARCHAR(MAX)
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

--check to see if we can pull Hierarchy data without adding Dept and Division columns
CREATE TABLE GarmDefaultValues( --Specified for each Manufacturer for each garment; Sized may have different costs
-- Type, Size, Length are ALL PREDEFINED; Added customizable options for missing values
	GarmDefaultID INT IDENTITY(1,1) NOT NULL PRIMARY KEY --PK
	, Gender VARCHAR(1) -- added
	, GarmType VARCHAR(MAX)
	, GarmSize VARCHAR(MAX)
	, GarmLength VARCHAR(MAX)
	, GarmCost DECIMAL(3,2) -- Can be edited for either historical costs or current date forward
	, GarmWeight INT 
	, MultiUse VARCHAR(1) -- (Y , N)
	, PAR_Level INT -- Defined for specific garm
	, LifeExpectancy INT -- number of days used before worn out
	, GarmDescription VARCHAR(MAX) -- Used if there is a multiuse, mention other departnebts its for
	, JobHierarchyID INT -- FK, ADDED

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

DROP TABLE GarmDefaultValues
SELECT * FROM GarmDefaultValues

--------------------------------------------------------------------------
-- GarmDefaultValues ADDED Foreign Keys ----------------------------------
-- Some tables needed to be created before FKs----------------------------

ALTER TABLE GarmDefaultValues
ADD FOREIGN KEY (Manufacturer) REFERENCES Manufacturer(ManuName)

ALTER TABLE GarmDefaultValues
ADD FOREIGN KEY (Department) REFERENCES Hierarchy(Department)

ALTER TABLE GarmDefaultValues
ADD CONSTRAINT (FKHierarchy)
FOREIGN KEY (JobHierarchyID) REFERENCES Heirarchy(JobHierarchyID)

--------------------------------------------------------------------------

CREATE TABLE GarmDepreciation(--Calculated depreciation costs and rates
-- Reaches specific rate - add to purchase order?
-- PurchaseOrder, GarmDefault, EmpJobGarm
	GarmDeprecID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, EmpID INT
	, TicketNumber INT
	, GarmentNumber INT
	, GarmNumOfCleanings INT
	, GarmDepreciationCost DECIMAL(3,2)
	, GarmAlterDerep DECIMAL(3,2)
	, CONSTRAINT FKEmpID FOREIGN KEY(EmpID)
		REFERENCES Employee(EmpID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	, CONSTRAINT FKTicketID FOREIGN KEY(TicketNumber)
		REFERENCES TicketCreate(TicketNumber)
	, CONSTRAINT FKGarmentID FOREIGN KEY(GarmentNumber)
		REFERENCES GarmentCreate(GarmentNumber)
)

----- Garment Inventory and Tracking -----------------------------------------------------

CREATE TABLE PreTaggedGarments( -- Garments received from PurchaseOrder, not barcoded or chipped
-- Once Tagged, item is automatically subtracted
	PreTaggedGarmID INT -- IDs created by Purchase Order Amount subtracted by actual amount (60 shirts - 50 = 1 thru 10 IDs)
	, PurchaseOrder INT -- FK, PurchaseOrder
	, ItemsMissing INT -- item removed from box but not entered into system
)

CREATE TABLE Scan( 
	ScanID INT NOT NULL
	, RFID INT
	, BARCODE VARCHAR(MAX)
	, ScanTime DATETIME NOT NULL
	, CONSTRAINT ScanNumID PRIMARY KEY (ScanID, ScanTime)
)

CREATE TABLE Inventory( --Overall inventory; Always be updating
-- If tagged, assigns GarmNum to EmpID
-- Hand in hand with GarmActivity -- tracks specific garment if assigned
--ADD, FIND, DELETE - 3 CATEGORIES
	GarmentID INT -- assigned once assigned to emp; FK GarmActivity
	, EmpID INT -- FK, Employee, only when assigned
	, SlotNum INT -- FK, GarmActivity
	, Conveyor INT -- FK, GarmActivity
	, GarmActivityID INT -- FK, GarmActivity
	, GarmDefaultID INT -- FK, GarmDefaultValue
	, ManufacturerID INT -- FK, Manufacturer
	, GarmCost INT -- FK, DefaultValues
	, AssignmentStatus INT --FK, Cleaner
	, Barcode INT --Scan
	, RFID INT -- Scan
	, GarmLocation VARCHAR(MAX) -- Storage, laundry, etc (probably)
	, EmpResponsible INT -- May just be EmpID as well, FK Emp
)

CREATE TABLE GarmActivity(-- Per day/per use
-- Would activity influence Depreciation value? (yes?)
-- Once in inventory, will be assigned, loaned, w/e
	GarmActivityID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, EmpID INT -- FK Emp
	, GarmID INT --Assigned from Inventory once tagged
	, SlotNum INT -- Slot assigned to specific garm;
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
	, Missing DATETIME
	, CONSTRAINT FKGarmActivity FOREIGN KEY (Garm)
		REFERENCES GarmDefaultValues(GarmDefaultID)
	, CONSTRAINT FKEmpIDActivity FOREIGN KEY (EmpID)
		REFERENCES Employee(EmpID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)

CREATE TABLE MissingGarments(
	MissingGarmID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmID INT -- FK, Inventory
	, MissingDateTime DATETIME -- FK, GarmActivity, Or GarmActivity
	, GarmActivityID INT --FK, GarmActivity
	, GarmDefaultValueID INT -- FK, GarmDefaultValue
	, DelinquentGarm BIT -- FK, GarmActivity
)

CREATE TABLE DeletedGarments(
	DeletedGarmsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmID INT -- FK, Inventory
	, MissingGarmID INT -- FK, MissingGarment
	, NonTaggedID INT -- FK, NonTaggedGarm
)

CREATE TABLE NonTaggedGarm( --ID calculated from TOTAL ORDERED - TOTAL NOT TAGGED (50-40=10 new IDs)
-- Items scanned, but not tagged for Emp use
-- Still has GarmID
-- May have to define further
	NonTaggedGarmID INT NOT NULL
	, Garm INT -- FK
	, Assigned VARCHAR(MAX) -- fk, temp assignment
	, EmpID INT
	, Loaned BIT --May be VARCHAR, depending on how we define this (by name?, YES/NO?)
	, Sold BIT
	, GarmLocation -- FK, Inventory
	, CONSTRAINT NoTagsID PRIMARY KEY (NonTaggedGarmID)
	, CONSTRAINT FKGarmNT FOREIGN KEY (Garm)
		REFERENCES GarmDefaultValues(GarmDefaultID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)

----------- Accounting/Sales -----------------------------------
--- Purchases identify need for additional inventory
--- Make PAR Levels perfect to avoid excess purchases

CREATE TABLE Accounting(
	AccountingID INT
	, PurchaseOrderID INT
	, EmpOrder INT
	, TotalSales DECIMAL(6,2)
	, TotalPurchases DECIMAL(6,2)
	, TotalEmpOrder DECIMAL(6,2)
	, TotalCombinedPurchases DECIMAL(6,2) -- Combined Emp and Purchase Order
)

CREATE TABLE Sales( -- Probably have to add more
	SalesID INT 
	, Inventory INT
	, SalesPrice INT
	, PurchaseOrderID INT 
	, EmpOrderID INT
	, GarmentDefaultValue INT
	, PurchaseDate DATE
	, PurchaseCost DECIMAL(3,2)
	, PurchasedAmount INT
)

CREATE TABLE ReturnedSales(
	ReturnedID INT -- PK, 
	, SalesID INT --FK, Sales
	, PurchaseOrderID INT --FK, PurchaseOrder
	, EmpOrderID INT --FK, EmpOrder
	, Reimbursement DECIMAL(3,2)
	, EmpID INT -- FK, EmpOrder
)

CREATE TABLE PurchaseOrder( --Companies place order to manufactures for specific amount of each garment; 
--Ties in per type and amount of Garms ordered by company 
	PurchaseOrderID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmentDefaultValue INT
	, Garmsize VARCHAR(MAX) -- FK, Garmdefaultvalue
	, OrderAmount INT
	, TotalPerGarmID DECIMAL(3,2)
	, PurchaseDate DATE
	, ExpectedDate DATE
	, Reason VARCHAR(MAX) -- May just be drop down task
	, ShippingInfo INT -- FK, Laundry, Manufacturer
	, ReceivedOrder BIT -- PreTaggedGarments
	, CONSTRAINT FKGarmDefaultValue FOREIGN KEY(GarmDefaultValue)
		REFERENCES GarmDefaultValues(GarmDefaultID)
) -- PURCAHSE ORDER ID MIGHT CHANGE BECAUSE HOW COMPANIES TRACK

CREATE TABLE EmpOrder( --Luandry Matts; What each employee needs ordered for themselves
	EmpOrderID INT NOT NULL
	, EmpID INT -- FK EmployeeID
	, RFID INT
	, Barcode INT
	, Garment INT -- FK Garm
	, Hierarchy INT -- FK Hierarchy 
	, CONSTRAINT EmpOrdID PRIMARY KEY (EmpOrderID)
	, CONSTRAINT FKHierarchy FOREIGN KEY (Hierarchy) -- ALL constraints are new
		REFERENCES Hierarachy(JobHierarchyID)
	, CONSTRAINT FKGarm FOREIGN KEY (Garm)
		REFERENCES GarmDefaultValuees(GarmDefaultID)
	, CONSTRAINT FKEmpID FOREIGN KEY (EmpID)
		REFERENCES Employee(EmpID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	, CONSTRAINT FKRfid FOREIGN KEY (RFID)
		REFERENCES PurchaseOrder(RFID)
	, CONSTRAINT FKBarcode FOREIGN KEY (Barcode)
		REFERENCES PurchaseOrder(Barcode) 
) -- TRY RUNNING AT HOME


------ Cleaning and Repair Information ---------------------------------------------------------
-- Check-In, Ship, Receive, Check-In & Ship, Re-Clean

CREATE TABLE CleaningActivity( -- Needs to be cleaned(tehe) up
	CleaningActID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, CleanerInfo INT -- FK, CleanerInfo
	, GarmID INT -- FK, GarmActivity
	, RFID INT -- FK, Inventory
	, Barcode INT -- FK, Inventory
	, CheckIn BIT -- Yes, No; if Yes, then "At Cleaner"; No, then "At Checkin"
	, CheckInTime TIME
	, CheckInDate Date
	, CheckoutTime TIME --
	, CheckOutDate DATE
	, DelinquentGarms BIT -- When not Checkedout for a period of time, Yes/No
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
	, CONSTRAINT FKGarmRepair FOREIGN KEY (Garm)
		REFERENCES GarmDefaultValues(GarmDefaultID)
	, CONSTRAINT FKEmpIDRepairs FOREIGN KEY (EmpID)
		REFERENCES Employee(EmpID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
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
