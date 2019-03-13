/*

This is just for me to use as a new test DB

In the "CompanyTest" DB, we were adding all variables to all the tables,

excactly how we would set up the tables to store specific information

This is why only some of the FKs would work when adding FK relationships



What I am changing:

- Recreating the tables with only what can be connected as FKs and PKs

	- This will help us see what exactly will be left per table for

		purposes

- Compare to CompanyTest Tables and see difference in information

- We can then create new tables (or views, depending on information)

	- with JOIN statements

- Need to see if we don't have to connect all other FKs that aren't true IDs



- Since we are using JOINS, do they update just as much as regular tables?

- Do we have to format PROCs to specifically look at JOIN tables only?



- EmpJobGarm and Inventory both have GarmID as PK

	- PK ejg, FK inv

	- can FK become PK>

... Let's find out

*/



USE master

GO



IF DB_ID('CleanCompanyTest') IS NOT NULL

	DROP DATABASE CleanCompanyTest



CREATE DATABASE CleanCompanyTest

GO



USE CleanCompanyTest

GO





--------------------- Employee -------------------

CREATE TABLE Employee( 

	EmpID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, FirstName VARCHAR(MAX) NOT NULL

	, LastName VARCHAR(MAX) NOT NULL

	, MiddleInitial VARCHAR(1)

	, Gender VARCHAR(1)

	, GarmType VARCHAR(MAX)

	, GarmSize VARCHAR(MAX)

	, GarmLength VARCHAR(MAX)

	, EmpAddress VARCHAR(MAX) NOT NULL

	, PhoneNmber VARCHAR(12) NOT NULL

	, Email VARCHAR(MAX) NOT NULL

	, Hierarchy INT

	, AltID INT

	, ReturnID INT

	, AlterationInstructions VARCHAR(MAX)

)



ALTER TABLE Employee

ADD CONSTRAINT FKHierarchyEmp

FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)



ALTER TABLE Employee

ADD CONSTRAINT FKReturnIDEmp

FOREIGN KEY (ReturnID) REFERENCES ReturnedSales(ReturnedID)





------------- EmpJobGarm -----------------------

CREATE TABLE EmpJobGarm(

	EmpJobGarmID INT NOT NULL

	, EmpID INT

	, Hierarchy INT 

	, GarmentID INT

	, GarmActivityID INT

	, GarmDefaultID INT

	, EqEmpGarms INT

	, CONSTRAINT PKGarmID PRIMARY KEY (GarmentID)

)

/*
	, SlotNum INT

	, GarmType VARCHAR(MAX)

	, Size VARCHAR(MAX)

	, GarmLength VARCHAR(MAX)
*/

ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKHierarchyJG

FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKGarmActivityJG

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKGarmDefJG

FOREIGN KEY (GarmDefaultID) REFERENCES GarmDefaultValues(GarmDefaultID)



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKEmpidJG

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)

		ON DELETE CASCADE

		ON UPDATE CASCADE



------------ Locker -------------------------

CREATE TABLE Locker(

	LockerNumber INT NOT NULL

	, SerialNum INT 

	, Combonation VARCHAR(8) 

	, EmpID INT

	, Reasons VARCHAR(MAX)

	, CONSTRAINT LockNum PRIMARY KEY (LockerNumber)

)



----------- Company Info --------------------

CREATE TABLE CompanyInfo(

	CompanyID INT IDENTITY(1,1) PRIMARY KEY NOT NULL

	, CompName INT NOT NULL

	, CompAddress VARCHAR(MAX)

	, CompPhone VARCHAR (15) NULL

	, CompEmail VARCHAR(MAX)

)



---------- Manufacturer ----------------------

CREATE TABLE Manufacturer(

	ManufacturerID INT IDENTITY NOT NULL PRIMARY KEY

	, ManuName VARCHAR(MAX) 

	, ManuAddress VARCHAR(MAX)

	, ManuPhone VARCHAR(MAX)

	, ManuEmail VARCHAR(MAX)

)



----------- CleanerInfo -----------------------

CREATE TABLE CleanerInfo(

	CleanerID INT IDENTITY(1,1) PRIMARY KEY NOT NULL

	, CleanerName INT NOT NULL

	, CleanerAddress VARCHAR(MAX)

	, CleanerPhone VARCHAR (15) NULL

	, CleanerEmail VARCHAR(MAX)

)





------------ Hierarchy -----------------------



CREATE TABLE Hierarchy( 

	JobHierarchyID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, Division VARCHAR(MAX)

	, Department VARCHAR(MAX)

	, Job VARCHAR(MAX)

	, Gender VARCHAR(MAX)

	, ParLevel INT

	, NumOfReserveStock DECIMAL(3,2)

	, DesignatedSlots INT

)





------------ GarmDefaultValues ------------



CREATE TABLE GarmDefaultValues(

	GarmDefaultID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, Gender VARCHAR(1)

	, GarmType VARCHAR(MAX)

	, GarmSize VARCHAR(MAX)

	, GarmLength VARCHAR(MAX)

	, GarmCost DECIMAL(3,2)

	, GarmWeight INT 

	, MultiUse VARCHAR(1)

	, EqEmpGarm INT

	, EqGarmAmount INT

	, LifeExpectancy INT

	, MaxNumOfCleanings INT

	, GarmDescription VARCHAR(MAX)

	, JobHierarchyID INT

	, GarmManuID INT 

)



ALTER TABLE GarmDefaultValues

ADD CONSTRAINT FKGarmManuDV

FOREIGN KEY (GarmManuID) REFERENCES Manufacturer(ManufacturerID)



ALTER TABLE GarmDefaultValues

ADD CONSTRAINT FKJobHierarchyIdDV

FOREIGN KEY (JobHierarchyID) REFERENCES Hierarchy(JobHierarchyID)



----------- Garm Depreciation --------------------



CREATE TABLE GarmDepreciation(

	GarmDeprecID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, EmpID INT

	, GarmentID INT 

	, GarmActivityID INT

	, CleaningActivityID INT

	, RepairsID INT

	, GarmNumOfCleanings INT

	, GarmDepreciationCost DECIMAL(3,2)

	, GarmAlterCost DECIMAL(3,2)

	, PercentOfDepreciation INT

)

/*

	, GarmMaxNumOfCleanings INT


*/



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



CREATE TABLE PreTaggedGarments(

	PreTaggedGarmID INT

	, AccountingID INT

	, ItemsMissing INT

	, CONSTRAINT PreTaggedID PRIMARY KEY (PreTaggedGarmID)

)



ALTER TABLE PreTaggedGarments

ADD CONSTRAINT AccountingIDPT

FOREIGN KEY (AccountingID) REFERENCES Accounting(AccountingID)



------------- Scan ----------------------------



CREATE TABLE Scan( 

	ScanID INT NOT NULL

	, PreTaggedGarmID INT

	, RFID INT

	, BARCODE VARCHAR

	, ScanTime DATETIME NOT NULL

	, CONSTRAINT ScanNumID PRIMARY KEY (ScanID)

	, CONSTRAINT barcode UNIQUE (BARCODE)

	, CONSTRAINT rfid UNIQUE (RFID)

)



ALTER TABLE Scan

ADD CONSTRAINT FKPreTaggedScan

FOREIGN KEY (PreTaggedGarmID) REFERENCES PreTaggedGarments(PreTaggedGarmID)



------------ Inventory -------------------------



CREATE TABLE Inventory(

	InventoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, GarmentID INT

	, EmpID INT

	, SlotNum INT

	, Conveyor INT

	, GarmActivityID INT

	, GarmDefaultID INT

	, ManufacturerID INT

	, GarmCost DECIMAL(3,2)

	, ScanID INT

	, Barcode INT

	, RFID INT

	, GarmLocation VARCHAR(MAX)

	, EmpResponsible INT

)



ALTER TABLE Inventory

ADD CONSTRAINT FKGarmentIDInventory

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE Inventory

ADD CONSTRAINT FKEmpIDInventory

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE Inventory

ADD CONSTRAINT FKSlotNumInventory

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)



ALTER TABLE INVENTORY

ADD CONSTRAINT FKGarmDefaultValue

FOREIGN KEY (GarmDefaultID) REFERENCES GarmDefaultValues(GarmDefaultID)



ALTER TABLE Inventory

ADD CONSTRAINT FKManufacturerIDInventory

FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)



ALTER TABLE Inventory

ADD CONSTRAINT FKScanIDInventory

FOREIGN KEY(ScanID) REFERENCES Scan(ScanID)





-----------	Garm Activity ------------------------



CREATE TABLE GarmActivity(

	GarmActivityID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, EmpID INT

	, GarmentID INT

	, SlotNum INT

	, ScanID INT

	, Conveyor INT

	, CleaningActivityID INT

	, PickupTime TIME

	, PickupDate DATE

	, DropoffTime TIME

	, DropoffDate DATE

	, Assigned BIT

	, Loaned INT -- 

	, OneForOne BIT

	, Missing DATETIME

)
/*
	, RFID INT

	, Barcode INT
	
	, DelinquentGarm BIT
*/


ALTER TABLE GarmActivity

ADD CONSTRAINT FKEmpIDGAF --tehee

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



CREATE TABLE MissingGarments(

	MissingGarmID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, EmpID INT

	, GarmentID INT

	, MissingDateTime DATETIME

	, GarmActivityID INT

	, GarmDefaultValueID INT
)





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



CREATE TABLE DeletedGarments(

	DeletedGarmsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, GarmentID INT

	, EmpID INT

	, MissingGarmID INT

	, NonTaggedID INT

)





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

CREATE TABLE NonTaggedGarm( 

	NonTaggedGarmID INT NOT NULL

	, GarmentID INT

	, InventoryID INT

	, EmpID INT

	, GarmActivityID INT

	, Sold BIT

	, CONSTRAINT NoTagsID PRIMARY KEY (NonTaggedGarmID)
)
/*
	, Assigned VARCHAR(MAX)

	, Loaned BIT
	
	, GarmLocation VARCHAR(MAX) 
*/



ALTER TABLE NonTaggedGarm

ADD CONSTRAINT FKGarmNT

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE EmpJobGarm

ADD CONSTRAINT FKGarmActivityNT

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)



ALTER TABLE NonTaggedGarm

ADD CONSTRAINT FKEmpIDNT

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE NonTaggedGarm

ADD CONSTRAINT FKInventoryIDNT

FOREIGN KEY(InventoryID) REFERENCES Inventory(InventoryID)





-------- Accounting -----------------------------------

CREATE TABLE Accounting(

	AccountingID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, PurchaseOrderID INT

	, SalesID INT

	, ManufacturerID INT

	, EmpOrderID INT

	, TotalSales DECIMAL(6,2)

	, TotalPurchases DECIMAL(6,2)

	, TotalEmpOrder DECIMAL(6,2)

	, TotalCombinedPurchases DECIMAL(6,2)

)





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



CREATE TABLE Sales(

	SalesID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

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

)





ALTER TABLE Sales

ADD CONSTRAINT FKEmpJobGarmSales

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE Sales

ADD CONSTRAINT FKInventorySales

FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)



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

ADD CONSTRAINT FKEmpOrderSales

FOREIGN KEY (EmpOrderID) REFERENCES EmpOrder(EmpOrderID)




ALTER TABLE Sales

ADD CONSTRAINT FKAccountingSales

FOREIGN KEY (AccountingID) REFERENCES Accounting(AccountingID)



ALTER TABLE Sales

ADD CONSTRAINT FKManuIDSales

FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)





-------------- Returned Sales --------------------



CREATE TABLE ReturnedSales(

	ReturnedID INT IDENTITY(1,1) NOT NULL PRIMARY KEY 

	, SalesID INT

	, PurchaseOrderID INT 

	, EmpOrderID INT

	, Reimbursement DECIMAL(3,2)

	, EmpID INT

)



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



CREATE TABLE PurchaseOrder(

	PurchaseOrderID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

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

)



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



CREATE TABLE EmpOrder(

	EmpOrderID INT IDENTITY(1,1) PRIMARY KEY NOT NULL

	, EmpID INT

	, Garment INT

	, Hierarchy INT

	, GarmentSize VARCHAR(MAX)

	, OrderAmount INT 

	, Total DECIMAL(3,2)

	, GarmDepreciationSales DECIMAL(3,2)
)
/*
	, RFID INT

	, Barcode INT
*/


ALTER TABLE EmpOrder

ADD CONSTRAINT FKEmpIDEO

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE EmpOrder

ADD CONSTRAINT FKHierarchyEO

FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)





------------- Cleaning Activity --------------------------------



CREATE TABLE CleaningActivity(

	CleaningActID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, CleanerID INT

	, GarmActivityID INT

	, EmpID INT

	, SlotNum INT

	, CheckIn BIT

	, CheckInTime TIME

	, CheckInDate Date

	, CheckOutTime TIME 

	, CheckOutDate DATE

	, DelinquentGarm BIT

)

/*

	, RFID INT

	, Barcode INT
*/


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



CREATE TABLE Repairs(

	RepairID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, EmpID INT

	, GarmentID INT

	, CleaningActivityID INT

	, GarmActivityID INT

	, RepairType VARCHAR(MAX)

	, RepairPerson VARCHAR(MAX)

	, Received DATETIME

	, Completed DATETIME

	, RepairCost DECIMAL(3,2)
)




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









------- Miscellaneous -----------------------------------------------------------

CREATE TABLE DeviceOptions(

	DeviceOptionID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, SigPad VARCHAR(MAX)

	, LabelPrinter VARCHAR(MAX)

	, TouchScreen VARCHAR(MAX)

	, BulkScanner VARCHAR(MAX)

)