USE master

GO



IF DB_ID('CleanCompanyTest') IS NOT NULL

	DROP DATABASE CleanCompanyTest



CREATE DATABASE CleanCompanyTest

GO


USE CleanCompanyTest

GO

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



CREATE TABLE Locker(

	LockerNumber INT NOT NULL

	, SerialNum INT 

	, Combonation VARCHAR(8) 

	, EmpID INT

	, Reasons VARCHAR(MAX)

	, CONSTRAINT LockNum PRIMARY KEY (LockerNumber)

)



CREATE TABLE CompanyInfo(

	CompanyID INT IDENTITY(1,1) PRIMARY KEY NOT NULL

	, CompName INT NOT NULL

	, CompAddress VARCHAR(MAX)

	, CompPhone VARCHAR (15) NULL

	, CompEmail VARCHAR(MAX)

)



CREATE TABLE Manufacturer(

	ManufacturerID INT IDENTITY NOT NULL PRIMARY KEY

	, ManuName VARCHAR(MAX) 

	, ManuAddress VARCHAR(MAX)

	, ManuPhone VARCHAR(MAX)

	, ManuEmail VARCHAR(MAX)

)



CREATE TABLE CleanerInfo(

	CleanerID INT IDENTITY(1,1) PRIMARY KEY NOT NULL

	, CleanerName INT NOT NULL

	, CleanerAddress VARCHAR(MAX)

	, CleanerPhone VARCHAR (15) NULL

	, CleanerEmail VARCHAR(MAX)

)




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




CREATE TABLE PreTaggedGarments(

	PreTaggedGarmID INT

	, AccountingID INT

	, ItemsMissing INT

	, CONSTRAINT PreTaggedID PRIMARY KEY (PreTaggedGarmID)

)




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




CREATE TABLE MissingGarments(

	MissingGarmID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, EmpID INT

	, GarmentID INT

	, MissingDateTime DATETIME

	, GarmActivityID INT

	, GarmDefaultValueID INT
)



CREATE TABLE DeletedGarments(

	DeletedGarmsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, GarmentID INT

	, EmpID INT

	, MissingGarmID INT

	, NonTaggedID INT

)





CREATE TABLE NonTaggedGarm( 

	NonTaggedGarmID INT NOT NULL

	, GarmentID INT

	, InventoryID INT

	, EmpID INT

	, GarmActivityID INT

	, Sold BIT

	, CONSTRAINT NoTagsID PRIMARY KEY (NonTaggedGarmID)
)




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




CREATE TABLE ReturnedSales(

	ReturnedID INT IDENTITY(1,1) NOT NULL PRIMARY KEY 

	, SalesID INT

	, PurchaseOrderID INT 

	, EmpOrderID INT

	, Reimbursement DECIMAL(3,2)

	, EmpID INT

)



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




CREATE TABLE DeviceOptions(

	DeviceOptionID INT IDENTITY(1,1) NOT NULL PRIMARY KEY

	, SigPad VARCHAR(MAX)

	, LabelPrinter VARCHAR(MAX)

	, TouchScreen VARCHAR(MAX)

	, BulkScanner VARCHAR(MAX)

)