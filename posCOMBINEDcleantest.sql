/* Attempting to Combine CleanTest with POS_test (SUVOAS) */


/* 7/3/2019 Combined Garment Delete and Deleted Garments to reduce table count but still has the same information needed. */
/* Do not use Alter Constraints at the bottom until tables are properly established. */
/* All alters are properly working but do not have all combined tables.*/ 
/* Will Add SUVOAS Alters in next few days and combine functions. */


DROP DATABASE TestPlusSUV;

CREATE DATABASE TestPlusSUV;

USE TestPlusSUV;

CREATE TABLE Employee( 
	EmpID INT NOT NULL
	, FirstName VARCHAR(MAX) NOT NULL
	, LastName VARCHAR(MAX) NOT NULL
	, MiddleInitial VARCHAR(MAX)
	, Gender VARCHAR(MAX)
	, GarmType VARCHAR(MAX)
	, GarmSize VARCHAR(MAX)
	, GarmLength VARCHAR(MAX)
	, EmpAddress VARCHAR(MAX) NOT NULL
	, PhoneNmber VARCHAR(MAX) NOT NULL
	, Email VARCHAR(MAX) NOT NULL
	, JobHierarchyID TINYINT	
	, AltID INT	
	, ReturnID INT
	, AlterationInstructions VARCHAR(MAX)
	, CONSTRAINT PKEmpID PRIMARY KEY (EmpID)

);


CREATE TABLE EmpJobGarm(
	EmpJobGarmID INT NOT NULL
	, EmpID INT
	, JobHierarchyID TINYINT 
	, GarmentID INT
	, GarmActivityID INT
	, GarmDefaultID INT
	, EqEmpGarms INT
	, CONSTRAINT PKGarmID PRIMARY KEY (GarmentID)

);


CREATE TABLE EmpOrder(
	EmpOrderID INT IDENTITY (1,1) PRIMARY KEY NOT NULL
	, EmpID INT
	, RFID INT
	, Barcode INT
	, Garment INT
	, Hierarchy TINYINT
	, GarmentSize VARCHAR(MAX) NOT NULL
	, OrderAmount INT 
	, Total DECIMAL(3,2)
	, GarmDepreciationSales DECIMAL(3,2)
	, GarmDeprecPercentage TINYINT

);


CREATE TABLE CustomerCreate(
--	CusCreateID INT IDENTITY(1,1) PRIMARY KEY NOT NULL
	AccountNumber INT NOT NULL
	, Phone VARCHAR(12) NULL 
	, LastName VARCHAR(MAX) NOT NULL 
	, FirstName VARCHAR(MAX) NOT NULL 
	, Address VARCHAR(60) NULL
	, Address2 VARCHAR(20) NULL
	, City VARCHAR(MAX) NULL 
	, State CHAR(3) NULL 
	, ZipCode VARCHAR(MAX) NULL 
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL
	, CONSTRAINT CustomerCreateID PRIMARY KEY (AccountNumber)
);



CREATE TABLE TicketCreate(
	 TicCusAcctID INT NOT NULL  --pulled cus ID
	, TicketNumber INT NOT NULL  --IDENTITY NOT NULL PRIMARY KEY 
	, PickupDate DATE NULL
	, PickupTime TIME(0) NULL
	, PlantID INT NULL
	, RouteID INT NULL
	, StoreID INT NULL
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL
	, CONSTRAINT PKTicketID PRIMARY KEY (TicketNumber)
	, CONSTRAINT FKCusInfoID FOREIGN KEY(TicCusAcctID)
		REFERENCES CustomerCreate(AccountNumber)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


CREATE TABLE TicketModify(
	 TicCusAcctID INT NOT NULL
	, TicketNumber INT NOT NULL 
	, PickupDate DATE NULL
	, PickupTime TIME(0) NULL
	, PlantID INT NULL
	, RouteID INT NULL
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL
);


CREATE TABLE Hierarchy( 
	JobHierarchyID TINYINT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, Division VARCHAR(MAX)
	, Department VARCHAR(MAX)
	, Job VARCHAR(MAX)
	, Gender VARCHAR(MAX)
	, ParLevel TINYINT
	, NumOfReserveStock DECIMAL(3,2)
	, DesignatedSlots INT

);




CREATE TABLE GarmentCreate(
	GarmCusAcctID INT NOT NULL 
	, TicketNumber INT NOT NULL 
	, GarmentNumber INT NOT NULL 
	, GarmDescription VARCHAR(MAX) NULL
	, ServicePrice NVARCHAR NULL
	, ServiceType VARCHAR(MAX) NULL
	, GarmType NVARCHAR(50) NULL
	, GarmColor VARCHAR(10) NULL
	, GarmFabric VARCHAR(50) NULL
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL 
	, CONSTRAINT PKGarmNumberID PRIMARY KEY (GarmentNumber)
	, CONSTRAINT FKCusAcctID FOREIGN KEY (GarmCusAcctID)
		REFERENCES CustomerCreate(AccountNumber)
	 , CONSTRAINT FKTicNumID FOREIGN KEY (TicketNumber)
		REFERENCES TicketCreate(TicketNumber)		
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


CREATE TABLE GarmentModify(
	GarmCusAcctID INT NOT NULL 
	, TicketNumber INT NOT NULL 
	, GarmentNumber INT NOT NULL 
	, GarmDescription VARCHAR(25) NULL
	, ServicePrice DECIMAL(3,2) NULL
	, ServiceType VARCHAR(10) NULL
	, GarmColor VARCHAR(10) NULL
	, TransactionDate DATE NOT NULL 
	, TransactionTime TIME(0) NOT NULL 
);




CREATE TABLE GarmDefaultValues(
	GarmDefaultID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, Gender VARCHAR(MAX)
	, GarmType VARCHAR(MAX)
	, GarmSize VARCHAR(MAX)
	, GarmLength VARCHAR(MAX)
	, GarmCost DECIMAL(3,2)
	, GarmWeight INT 
	, MultiUse VARCHAR(MAX)
	, EqEmpGarm INT
	, EqGarmAmount INT
	, LifeExpectancy TINYINT
	, MaxNumOfCleanings TINYINT
	, GarmDescription VARCHAR(MAX)
	, JobHierarchyID TINYINT
	, GarmManuID INT 
);


CREATE TABLE GarmDepreciation(
	GarmDeprecID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, EmpID INT
	, GarmentID INT 
	, GarmActivityID INT
	, CleaningActivityID INT
	, RepairsID INT
	, GarmMaxNumOfCleanings INT
	, GarmNumOfCleanings INT
	, GarmDepreciationCost DECIMAL(3,2)
	, GarmAlterCost DECIMAL(3,2)
	, PercentOfDepreciation TINYINT
);



CREATE TABLE PreTaggedGarments(
	PreTaggedGarmID INT
	, AccountingID INT
	, ItemsMissing INT
	, CONSTRAINT PreTaggedID PRIMARY KEY (PreTaggedGarmID)

);



------------- Scan ----------------------------

/*  NOT SURE IF WE NEED!

CREATE TABLE Scan( 

	ScanID INT NOT NULL

	, PreTaggedGarmID INT

	, RFID INT

	, BARCODE VARCHAR(MAX)

	, ScanTime DATETIME

	, CONSTRAINT ScanNumID PRIMARY KEY (ScanID)

	, CONSTRAINT barcode UNIQUE (BARCODE)

	, CONSTRAINT rfid UNIQUE (RFID)

);

*/


CREATE TABLE GarmActivity(
	GarmActivityID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, EmpID INT
	, GarmentID INT
	, SlotNum TINYINT
	, ScanID INT
	, Conveyor TINYINT
	, CleaningActivityID INT
	, PickupTime TIME
	, PickupDate DATE
	, DropoffTime TIME
	, DropoffDate DATE
	, Assigned BIT
	, Loaned BIT
	, OneForOne BIT
	, Missing DATETIME
);


CREATE TABLE MissingGarments(
	MissingGarmID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, EmpID INT
	, GarmentID INT
	, MissingDateTime DATETIME
	, GarmActivityID INT
	, GarmDefaultValueID INT
);


CREATE TABLE DeletedGarments(
	DeletedGarmsID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, GarmentID INT
	, EmpID INT
	, MissingGarmID INT
	, NonTaggedID INT
	, AccountNumber INT
	, TicketNumber INT
);


CREATE TABLE NonTaggedGarm( 
	NonTaggedGarmID INT NOT NULL
	, GarmentID INT
	, InventoryID INT
	, EmpID INT
	, GarmActivityID INT
	, Sold BIT
	, CONSTRAINT NoTagsID PRIMARY KEY (NonTaggedGarmID)
);


CREATE TABLE Manufacturer(
	ManufacturerID INT NOT NULL IDENTITY (1,1) PRIMARY KEY
	, ManuName VARCHAR(MAX) 
	, ManuAddress VARCHAR(MAX)
	, ManuPhone VARCHAR(MAX)
	, ManuEmail VARCHAR(MAX)
);



CREATE TABLE CleanerInfo(
	CleanerID INT IDENTITY (1,1) PRIMARY KEY NOT NULL
	, CleanerName INT NOT NULL
	, CleanerAddress VARCHAR(MAX)
	, CleanerPhone VARCHAR (MAX) NULL
	, CleanerEmail VARCHAR(MAX)
);


CREATE TABLE CleaningActivity(
	CleaningActID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, CleanerID INT
	, GarmActivityID INT
	, EmpID INT
	, SlotNum TINYINT
	, CheckIn BIT
	, CheckInTime TIME
	, CheckInDate Date
	, CheckOutTime TIME 
	, CheckOutDate DATE
	, DelinquentGarm BIT
);



CREATE TABLE Repairs(
	RepairID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, EmpID INT
	, GarmentID INT
	, CleaningActivityID INT
	, GarmActivityID INT
	, RepairType VARCHAR(MAX)
	, RepairPerson VARCHAR(MAX)
	, Received DATETIME
	, Completed DATETIME
	, RepairCost DECIMAL(3,2)
);




CREATE TABLE Locker(
	LockerNumber TINYINT NOT NULL
	, SerialNum INT 
	, Combonation VARCHAR(MAX) 
	, EmpID INT
	, Reasons VARCHAR(MAX)
	, CONSTRAINT LockNum PRIMARY KEY (LockerNumber)
);


CREATE TABLE Accounting(
	AccountingID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, PurchaseOrderID INT
	, SalesID INT
	, ManufacturerID INT
	, EmpOrderID INT
	, TotalSales DECIMAL(6,2)
	, TotalPurchases DECIMAL(6,2)
	, TotalEmpOrder DECIMAL(6,2)
	, TotalCombinedPurchases DECIMAL(6,2)
);




CREATE TABLE PurchaseOrder(
	PurchaseOrderID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, GarmentDefaultValue INT
	, Garmsize VARCHAR(MAX)
	, OrderAmount INT
	, AccountingID INT
	, Total DECIMAL(3,2)
	, PurchaseDate DATE
	, ExpectedDate DATE
	, Reason VARCHAR(MAX)
	, ManufacturerID INT
	, ReceivedOrder BIT 
);



CREATE TABLE Sales(
	SalesID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, GarmentID INT
	, EmpID INT
	, SalesPrice Decimal(3,2)
	, AccountingID INT
	, InventoryID INT
	, PurchaseOrderID INT
	, ManufacturerID INT
	, EmpOrderID INT
	, GarmDefaultID INT
	, PurchaseDate DATE
	, PurchaseCost DECIMAL(3,2)
	, PurchasedAmount INT
	, SalesTax DECIMAL(3,2)
);



CREATE TABLE ReturnedSales(
	ReturnedID INT IDENTITY (1,1) NOT NULL PRIMARY KEY 
	, SalesID INT
	, PurchaseOrderID INT 
	, EmpOrderID INT
	, Reimbursement DECIMAL(3,2)
	, EmpID INT
);



CREATE TABLE DeviceOptions(
	DeviceOptionID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, SigPad VARCHAR(MAX)
	, LabelPrinter VARCHAR(MAX)
	, TouchScreen VARCHAR(MAX)
	, BulkScanner VARCHAR(MAX)
);


CREATE TABLE Aging(
	AgingID INT IDENTITY (1,1) NOT NULL PRIMARY KEY
	, ScanID INT
	, LoadTime DATETIME NULL
	, UnloadTime DATETIME NULL
	, CurrentTime DATETIME
	, TicketItems INT NOT NULL
	--, FOREIGN KEY (ScanID) REFERENCES ScanInfo(ScanID)
);



CREATE TABLE TicketDelete(
	AccountNumber INT NOT NULL
	, TicketNumber INT NOT NULL
);


CREATE TABLE TicketClosed(
	TicketClosedID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, TicketNumber INT
	, CustomerID INT
	, TransactionDate DATE
	, TransactionTime TIME
);

CREATE TABLE GarmentClosed(
	GarmClosedID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, GarmNumber INT
	, TicketNumber INT
	, CustomerID INT
	, TransactiolDate DATE
	, TransactionTime TIME
);

CREATE TABLE AlarmHistory(
	AlarmType VARCHAR
	, DateTimeStamp TIMESTAMP
);


/* ALL CAN BE UUPLOADED Time to shrink the db size */



 /* Constraints for now From CleanTest */


 
ALTER TABLE Employee

ADD CONSTRAINT FKHierarchyEmp

FOREIGN KEY (JobHierarchyID) REFERENCES Hierarchy(JobHierarchyID);



ALTER TABLE Employee

ADD CONSTRAINT FKReturnIDEmp

FOREIGN KEY (ReturnID) REFERENCES ReturnedSales(ReturnedID);





------------- EmpJobGarm -----------------------



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKHierarchyJG

FOREIGN KEY (JobHierarchyID) REFERENCES Hierarchy(JobHierarchyID);



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKGarmActivityJG

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID);



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKGarmDefJG

FOREIGN KEY (GarmDefaultID) REFERENCES GarmDefaultValues(GarmDefaultID);



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKEmpidJG

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)

		ON DELETE CASCADE

		ON UPDATE CASCADE





------------ GarmDefaultValues ------------

ALTER TABLE GarmDefaultValues

ADD CONSTRAINT FKGarmManuDV

FOREIGN KEY (GarmManuID) REFERENCES Manufacturer(ManufacturerID)



ALTER TABLE GarmDefaultValues

ADD CONSTRAINT FKJobHierarchyIdDV

FOREIGN KEY (JobHierarchyID) REFERENCES Hierarchy(JobHierarchyID)





----------- Garm Depreciation --------------------



ALTER TABLE GarmDepreciation

ADD CONSTRAINT FKEmpIDDG

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE GarmDepreciation

ADD CONSTRAINT FKGarmentIDDG

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE GarmDepreciation

ADD CONSTRAINT FKGarmActivityIDDG

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)



--------- PreTagged Garments ----------------------



ALTER TABLE PreTaggedGarments

ADD CONSTRAINT AccountingIDPT

FOREIGN KEY (AccountingID) REFERENCES Accounting(AccountingID)



------------- Scan ----------------------------



ALTER TABLE Scan

ADD CONSTRAINT FKPreTaggedScan

FOREIGN KEY (PreTaggedGarmID) REFERENCES PreTaggedGarments(PreTaggedGarmID)





-----------	Garm Activity ------------------------



ALTER TABLE GarmActivity

ADD CONSTRAINT FKEmpIDGAF

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE GarmActivity

ADD CONSTRAINT FKGarmIDGAF

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE GarmActivity

ADD CONSTRAINT FKScanIDGAF

FOREIGN KEY (ScanID) REFERENCES Scan(ScanID)



ALTER TABLE GarmActivity

ADD CONSTRAINT FKCleaningIDGAF

FOREIGN KEY (CleaningActivityID) REFERENCES CleaningActivity(CleaningActID)



-------- Missing Garments ---------------------



ALTER TABLE MissingGarments -- need to think over CASCADE options later

ADD CONSTRAINT FKGarmIDMG

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE MissingGarments

ADD CONSTRAINT FKEmpIDMG

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKGarmActivityMG

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)



ALTER TABLE MissingGarments

ADD CONSTRAINT FKGarmDefaultValueMG

FOREIGN KEY (GarmDefaultValueID) REFERENCES GarmDefaultValues(GarmDefaultID)





-------- Deleted Garments ----------------



ALTER TABLE DeletedGarments

ADD CONSTRAINT FKGarmIDDelGarm

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE DeletedGarments

ADD CONSTRAINT FKEmpIDDelGarm

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE DeletedGarments

ADD CONSTRAINT FKMissingGarmDelGarm

FOREIGN KEY (MissingGarmID) REFERENCES MissingGarments(MissingGarmID)



ALTER TABLE DeletedGarments

ADD CONSTRAINT FKNonTaggedDelGarm

FOREIGN KEY (NontaggedID) REFERENCES NonTaggedGarm(NonTaggedGarmID)





--------- NonTagged Garments -------------------



ALTER TABLE NonTaggedGarm

ADD CONSTRAINT FKGarmNT

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKGarmActivityNT

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)



ALTER TABLE NonTaggedGarm

ADD CONSTRAINT FKEmpIDNT

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



/*

ALTER TABLE NonTaggedGarm

ADD CONSTRAINT FKInventoryIDNT

FOREIGN KEY(InventoryID) REFERENCES Inventory(InventoryID)

*/



-------- Accounting -----------------------------------



ALTER TABLE Accounting

ADD CONSTRAINT FKPurchaseOrderIDAcct

FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID)



ALTER TABLE Accounting

ADD CONSTRAINT FKEmpOrderAcct

FOREIGN KEY (EmpOrderID) REFERENCES EmpOrder(EmpOrderID)



ALTER TABLE Accounting

ADD CONSTRAINT FKSalesIDAcct

FOREIGN KEY (SalesID) REFERENCES Sales(SalesID)



ALTER TABLE Accounting

ADD CONSTRAINT FKManuIDAcct

FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)





------------- Sales ----------------------------



ALTER TABLE Sales

ADD CONSTRAINT FKEmpJobGarmSales

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



/*

ALTER TABLE Sales

ADD CONSTRAINT FKInventorySales

FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)

*/



ALTER TABLE Sales

ADD CONSTRAINT FKEmpIDSales

FOREIGN KEY(EmpID) REFERENCES Employee(EmpID)



ALTER TABLE Sales

ADD CONSTRAINT FKPurchaseOrderSales

FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID)



ALTER TABLE Sales

ADD CONSTRAINT FKGarmentDefaultValuesSales

FOREIGN KEY (GarmDefaultID) REFERENCES GarmDefaultValues(GarmDefaultID)



ALTER TABLE Sales

ADD CONSTRAINT FKAccountingSales

FOREIGN KEY (AccountingID) REFERENCES Accounting(AccountingID)



ALTER TABLE Sales

ADD CONSTRAINT FKManuIDSales

FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)





-------------- Returned Sales --------------------



ALTER TABLE ReturnedSales

ADD CONSTRAINT FKSalesRS

FOREIGN KEY (SalesID) REFERENCES Sales(SalesID)



ALTER TABLE ReturnedSales

ADD CONSTRAINT FKPurchaseOrderRS

FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID)



ALTER TABLE ReturnedSales

ADD CONSTRAINT FKEmpOrderRS

FOREIGN KEY (EmpOrderID) REFERENCES EmpOrder(EmpOrderID)



ALTER TABLE ReturnedSales

ADD CONSTRAINT FKEmpRS

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



----------- Purchase Order -------------------------



ALTER TABLE PurchaseOrder

ADD CONSTRAINT FKGarmDefaultPO

FOREIGN KEY (GarmentDefaultValue) REFERENCES GarmDefaultValues(GarmDefaultID)



ALTER TABLE PurchaseOrder

ADD CONSTRAINT FKAccountingPO

FOREIGN KEY (AccountingID) REFERENCES Accounting(AccountingID)



ALTER TABLE PurchaseOrder

ADD CONSTRAINT FKManuIDPO

FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)



------------ Employee Order -------------------



ALTER TABLE EmpOrder

ADD CONSTRAINT FKEmpIDEO

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE EmpOrder

ADD CONSTRAINT FKHierarchyEO

FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)





------------- Cleaning Activity --------------------------------



ALTER TABLE CleaningActivity

ADD CONSTRAINT FKCleanerIDCA

FOREIGN KEY (CleanerID) REFERENCES CleanerInfo(CleanerID)



ALTER TABLE CleaningActivity

ADD CONSTRAINT FKEmpIDCA

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE CleaningActivity

ADD CONSTRAINT FKGarmCA

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)



--------- Repairs --------------------------------------



ALTER TABLE Repairs

ADD CONSTRAINT FKEmpRepair

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE Repairs

ADD CONSTRAINT FKGarmRepair

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE Repairs

ADD CONSTRAINT FKCkeaningActivityRepair

FOREIGN KEY (CleaningActivityID) REFERENCES CleaningActivity(CleaningActID)



ALTER TABLE Repairs

ADD CONSTRAINT FKGarmActivityRepair

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)
