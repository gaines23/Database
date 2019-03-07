-- ALTER TABLES 

USE CompanyTest
GO

-- Will start testing out connections
-- Then, start looking at strength of FKs to PKs
-- Might have messed up on where GarmID updates come from (as in wrong tables)
-- 

-- FKs - always need to be just as unique as PKs
	-- In the Constraints, if using a nonunique column,
	-- add the PK as the second identifier to the FK
	-- GarmDefaultValues(MaxNumOfCleanings, GarmDefaultID)

-- PAR LEVEL = EqEmpGarms, EqGarmAmount
	-- There are 2 types of EqEmpGarms:
		-- EqEmpGarms - amount of garm needed for Emp
		-- EqGarmAmount - amount needed in stock per specific garment 

-- Might not need GarmID and GarmCost for Manufacturer table

-- Might not need TicketCreate table, depending how company arranges garments for Emps

-- Garment Assignment comes from EmpJobGarm - Once an Emp is assigned a new Garment, the Garment
	-- receives a new ID that will be tracked through GarmActivity and inventoried in Inventory

-- Made the PK for EmpJobGarm a combined PK of:
	-- EmpID and GarmNum

-- Inventory -> AssignmentStatus 
	-- Probably have to write PROC since it takes info from different tables to categorize Status

-- GarmActivity -> DelinquentGarm
	-- May need to be PROC based off BIT only, not FK

-- Employee

ALTER TABLE Employee
ADD CONSTRAINT FKHierarchyEmp
FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)

ALTER TABLE Employee
ADD CONSTRAINT FKReturnIDEmp
FOREIGN KEY (ReturnID) REFERENCES ReturnedSales(ReturnedID)



-- Employee Job Garm

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKHierarchyJG
FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKEmpJG
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKGarmActivityJG
FOREIGN KEY (GarmActivity) REFERENCES GarmActivity(EmpID, SlotNum)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKSlotNumJG
FOREIGN KEY (SlotNum) REFERENCES GarmActivity(SlotNum)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKGarmSizeJG
FOREIGN KEY (Size) REFERENCES Employee(GarmSize)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKGarmTypeJG
FOREIGN KEY (GarmType) REFERENCES Employee(GarmType, EmpID)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKGarmLengthJG
FOREIGN KEY (GarmLength) REFERENCES Employee(GarmLength, EmpID)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKEqEmpGarmsJG
FOREIGN KEY (EqEmpGarms) REFERENCES GarmDefaultValues(EqEmpGarms, GarmDefaultID)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKEmpidJG
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
		ON DELETE CASCADE
		ON UPDATE CASCADE

/*
-- Locker
-- We'll come back to this and Device Options later

ALTER TABLE

ADD CONSTRAINT PKLockNum PRIMARY KEY (LockerNumber)

ALTER TABLE Locker
ADD CONSTRAINT (FKEmpIDLocker)
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
	DELETE ON CASCADE
	UPDATE ON CASCADE

*/

-- Company info
--NONE

/*
-- Manufacturer

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKGarmDefaultIDManu
FOREIGN KEY (Garm) REFERENCES GarmDefaultValues(GarmDefaultID)

ALTER TABLE EmpJobGarm
ADD CONSTRAINT FKGarmCostManu
FOREIGN KEY (GarmCost) REFERENCES GarmDefaultValues(GarmCost)

*/

-- Cleanerinfo

--NONE

-- Hierarchy

--NONE

-- garm default values

ALTER TABLE GarmDefaultValues
ADD CONSTRAINT FKGarmManuDV
FOREIGN KEY (GarmManu) REFERENCES Manufaturer(ManufacturerID)

ALTER TABLE GarmDefaultValues
ADD CONSTRAINT FKJobHierarchyIdDV
FOREIGN KEY (JobHierarchyID) REFERENCES Hierarchy(JobHierarchyID)



-- garm depreciation
-- Added Max#OfCleanings as FK to calculate PercentOfDepreciation
ALTER TABLE GarmDepreciation
ADD CONSTRAINT FKEmpID
FOREIGN KEY (EmpID) REFERENCES EMPLOYEE(EmpID)
/*
ALTER TABLE GarmDepreciation
ADD CONSTRAINT FKTickeID
FOREIGN KEY (TicketNumber) REFERENCES TicketCreate(TicketNumber)
*/
ALTER TABLE GarmDepreciation
ADD CONSTRAINT FKGarmentID
FOREIGN KEY (GarmentNumber) REFERENCES EmpJobGarm(GarmentID)

ALTER TABLE GarmDepreciation
ADD CONSTRAINT FKGarmMaxCleaning
FOREIGN KEY (GarmMaxNumOfCleanings) REFERENCES GarmDefaultValues(MaxNumOfCleanings, GarmDefaultID)




-- pretagged garms

ALTER TABLE PreTaggedGarments
ADD CONSTRAINT FKPurchaseOrderNumPG
FOREIGN KEY (PurchaseOrder) REFERENCES PurchaseOrder(PurchaseOrderID)


-- inventory

ALTER TABLE Inventory
ADD CONSTRAINT FKGarmentID
FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)

ALTER TABLE Inventory
ADD CONSTRAINT FKEmpIDInventory
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)

ALTER TABLE Inventory
ADD CONSTRAINT FKSlotNumInventory
FOREIGN KEY (SlotNum) REFERENCES GarmActivity(SlotNum, PKGarmActivityID)

ALTER TABLE Inventory 
ADD CONSTRAINT FKConveyorInventory
FOREIGN KEY (Conveyor) REFERENCES GarmActivity(Conveyor, PKGarmActivityID)

ALTER TABLE Inventory
ADD CONSTRAINT FKGarmActivityInventory
FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(PKGarmActivityID)

ALTER TABLE Inventory
ADD CONSTRAINT FKGarmDefaultIDInventory
FOREIGN KEY (GarmDefaultID) REFERENCES GarmDefaultValues(GarmDefaultID)

ALTER TABLE Inventory
ADD CONSTRAINT FKManufacturerIDInventory
FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)

ALTER TABLE Inventory
ADD CONSTRAINT FKGarmCostInventory
FOREIGN KEY (GarmCost) REFERENCES GarmDefaultValues(GarmCost, GarmDefaultValues)

/*
ALTER TABLE Inventory
ADD CONSTRAINT FKAssignInventory
FOREIGN KEY (AssignmentStatus) REFERENCES CleaningActivity(CleaningStatus)
*/

ALTER TABLE Inventory
ADD CONSTRAINT FKBarcodeInventory
FOREIGN KEY (Barcode) REFERENCES Scan(BARCODE)

ALTER TABLE Inventory
ADD CONSTRAINT FKRfidInventory
FOREIGN KEY (RFID) REFERENCES Scan(RFID)


-- garm activity
-- Added FK Constraint for Delinquent Garms from Cleaning Activity 

ALTER TABLE GarmActivity
ADD CONSTRAINT FKEmpIDGAF --tehee
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)

ALTER TABLE GarmActivity
ADD CONSTRAINT FKGarmIDGAF
FOREIGN KEY (GarmID) REFERENCES EmpJobGarm(EmpJobGarmID)

ALTER TABLE GarmActivity
ADD CONSTRAINT FKrfidGA
FOREIGN KEY (RFID) REFERENCES Inventory(RFID)

ALTER TABLE GarmActivity
ADD CONSTRAINT FKBarcodeGA
FOREIGN KEY (Barcode) REFERENCES Inventory(Barcode)

ALTER TABLE GarmActivity
ADD CONSTRAINT FKCleaningIDGAF
FOREIGN KEY (CleaningActivityID) REFERENCES CleaningActivity(CleaningActID)

/* May have to be determined by PROC
ALTER TABLE GarmActivity
ADD CONSTRAINT FKDelinquent
FOREIGN KEY (Delinquent) REFERENCES CleaningActivity(DelinquentGarm)
*/

-- missing garms
-- Added Delinquent Garms FK from Cleaning Activity

ALTER TABLE MissingGarments -- need to think over CASCADE options later
ADD CONSTRAINT GarmIDMG
FOREIGN KEY (GarmID) REFERENCES EmpJobGarm(GarmentID)

ALTER TABLE MissingGarments
ADD CONSTRAINT FKMissingDateTimeMG
FOREIGN KEY (MissingDateTime) REFERENCES GarmActivity(Missing, GarmID)

ALTER TABLE MissingGarments
ADD CONSTRAINT FKGarmActivityMG
FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)

ALTER TABLE MissingGarments
ADD CONSTRAINT FKGarmDefaultValueMG
FOREIGN KEY (GarmDefaultValueID) REFERENCES GarmDefaultValues(GarmDefaultID)

/*
ALTER TABLE MissingGarments
ADD CONSTRAINT FKDelinquentMG
FOREIGN KEY (DelinquentGarm) REFERENCES GarmActivity(DelinquentGarm)
*/
-- ^FIND WHERE TO PUT THIS IN THE TABLE AND THEN CREATE THE REFERENCES



-- deleted garms

ALTER TABLE DeletedGarments
ADD CONSTRAINT FKGarmIDdg
FOREIGN KEY (GarmID) REFERENCES Inventory(GarmentID)

ALTER TABLE DeletedGarments
ADD CONSTRAINT FKMissingGarmDG
FOREIGN KEY (MissingGarmID) REFERENCES MissingGarments(MissingGarmID)

ALTER TABLE DeletedGarments
ADD CONSTRAINT FKNonTaggedDG
FOREIGN KEY (NontaggedID) REFERENCES NonTaggedGarm(NonTaggedGarmID)



-- nontagged garms
-- Have to rethink FK logic
-- Gosh I am tired

ALTER TABLE NonTaggedGarm
ADD CONSTRAINT FKGarmNT
FOREIGN KEY (Garm) REFERENCES Inventory(GarmentID)

-- What was my thought process behind the assigned column?
-- Does it even make sense?
-- BIT or VARCHAR?
/*
ALTER TABLE NonTaggedGarm
ADD CONSTRAINT FKAssignedNT
FOREIGN KEY (Assigned) REFERENCES GarmActivity(Assigned)
*/

ALTER TABLE NonTaggedGarm
ADD CONSTRAINT FKEmpIDNT
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)

ALTER TABLE NonTaggedGarm
ADD CONSTRAINT FKLoanerNT
FOREIGN KEY (Loaned) REFERENCES GarmActivity(Loaned)

ALTER TABLE NonTaggedGarm
ADD CONSTRAINT FKGarmLocation
FOREIGN KEY (GarmLocation) REFERENCES Inventory(GarmLocation)


 
-- accounting

ALTER TABLE Accounting
ADD CONSTRAINT FKPurchaseOrderIDNT
FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID)

ALTER TABLE Accounting
ADD CONSTRAINT FKEmpOrderNT
FOREIGN KEY (EmpOrder) REFERENCES EmpOrder(EmpOrderID)



-- sales

ALTER TABLE Sales
ADD CONSTRAINT FKInventorySales
FOREIGN KEY (GarmentID) REFERENCES Inventory(GarmentID)

ALTER TABLE Sales
ADD CONSTRAINT FKPurchaseOrderSales
FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID)

ALTER TABLE Sales
ADD CONSTRAINT FKEmpOrderSales
FOREIGN KEY (EmpOrderID) REFERENCES EmpOrder(EmpOrderID)

ALTER TABLE Sales
ADD CONSTRAINT FKGarmentDefaultValuesSales
FOREIGN KEY (GarmentDefaultValue) REFERENCES GarmDefaultValues(GarmDefaultID)
-- MAYBE USE GARM COST? might not be specific enough.



--returned sales

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

ALTER TABLE ReturnedSales
ADD CONSTRAINT FKGarmIDRS
FOREIGN KEY (GarmID) REFERENCES EmpOrder


-- purchase order

ALTER TABLE PurchaseOrder
ADD CONSTRAINT FKGarmDefaultPO
FOREIGN KEY (GrmentDefaultValue) REFERENCES GarmDefaultValue(GarmDefaultID)

ALTER TABLE PurchaseOrder
ADD CONSTRAINT FKGarmSizePO
FOREIGN KEY (Garmsize) REFERENCES GarmDefaultValue(GarmSize, GarmDefaultID)



-- emporder

ALTER TABLE EmpOrder
ADD CONSTRAINT FKEmpIDEO
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)

ALTER TABLE EmpOrder
ADD CONSTRAINT FKHierarchy
FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)

ALTER TABLE EmpOrder
ADD CONSTRAINT FKbarcodeEO
FOREIGN KEY (Barcode) REFERENCES Inventory(Barcode)

ALTER TABLE EmpOrder
ADD CONSTRAINT FKrfidEO
FOREIGN KEY (RFID) REFERENCES Inventory(RFID)

ALTER TABLE EmpOrder
ADD CONSTRAINT FKGarmDepPerct
FOREIGN KEY (GarmDeprecPercentage) REFERENCES GarmDepreciation(PercentageOfDepreciation, GarmentID)
-- Added this as new FK
-- Once this reaches ~90%, new order is set into motion


-- CleaningActivity

ALTER TABLE CleaningActivity
ADD CONSTRAINT FKCleanerCA
FOREIGN KEY (CleanerName) REFERENCES CleanerInfo(CleanerName, CleanerID)

ALTER TABLE CleaningActivity
ADD CONSTRAINT FKGarmCA
FOREIGN KEY (GarmID) REFERENCES GarmActivity(GarmID)

ALTER TABLE CleaningActivity
ADD CONSTRAINT FKrfidCA
FOREIGN KEY (RFID) REFERENCES Inventory(RFID)

ALTER TABLE CleaningActivity
ADD CONSTRAINT FKBarcodeCA
FOREIGN KEY (Barcode) REFERENCES Inventory(Barcode)



-- repairs

ALTER TABLE Repairs
ADD CONSTRAINT FKEmpRepair
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)

ALTER TABLE Repairs
ADD CONSTRAINT FKGarmRepair
FOREIGN KEY (Garm) REFERENCES GarmentDefaultValue(GarmDefaultID)