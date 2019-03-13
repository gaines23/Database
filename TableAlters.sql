-- ALTERS FOR NEW TEST WITH FK

USE CleanCompanyTest

GO

-- Employee

ALTER TABLE Employee

ADD CONSTRAINT FKHierarchyEmp

FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)



ALTER TABLE Employee

ADD CONSTRAINT FKReturnIDEmp

FOREIGN KEY (ReturnID) REFERENCES ReturnedSales(ReturnedID)



-- EmpJobGarm

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

-- Locker



-- Company Info


--Manufacturer


-- Cleaner Info


-- Hierarchy


-- Garment Default Values

ALTER TABLE GarmDefaultValues

ADD CONSTRAINT FKGarmManuDV

FOREIGN KEY (GarmManuID) REFERENCES Manufacturer(ManufacturerID)



ALTER TABLE GarmDefaultValues

ADD CONSTRAINT FKJobHierarchyIdDV

FOREIGN KEY (JobHierarchyID) REFERENCES Hierarchy(JobHierarchyID)



-- Garment Depreciation

ALTER TABLE GarmDepreciation

ADD CONSTRAINT FKEmpIDDG

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE GarmDepreciation

ADD CONSTRAINT FKGarmentIDDG

FOREIGN KEY (GarmentID) REFERENCES EmpJobGarm(GarmentID)



ALTER TABLE GarmDepreciation

ADD CONSTRAINT FKGarmActivityIDDG

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)



-- Pretagged Garments

ALTER TABLE PreTaggedGarments

ADD CONSTRAINT AccountingIDPT

FOREIGN KEY (AccountingID) REFERENCES Accounting(AccountingID)



-- Scan

ALTER TABLE Scan

ADD CONSTRAINT FKPreTaggedScan

FOREIGN KEY (PreTaggedGarmID) REFERENCES PreTaggedGarments(PreTaggedGarmID)



-- Inventory


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



-- Garment Activity


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



-- Missing Garment

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



-- Deleted Garments



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



-- NonTagged Garments


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


-- Accounting


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


--- Sales



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



-- Returned Sales



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


-- Purchase Order


ALTER TABLE PurchaseOrder

ADD CONSTRAINT FKGarmDefaultPO

FOREIGN KEY (GarmentDefaultValue) REFERENCES GarmDefaultValues(GarmDefaultID)



ALTER TABLE PurchaseOrder

ADD CONSTRAINT FKAccountingPO

FOREIGN KEY (AccountingID) REFERENCES Accounting(AccountingID)



ALTER TABLE PurchaseOrder

ADD CONSTRAINT FKManuIDPO

FOREIGN KEY (ManufacturerID) REFERENCES Manufacturer(ManufacturerID)


-- Employee Order


ALTER TABLE EmpOrder

ADD CONSTRAINT FKEmpIDEO

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE EmpOrder

ADD CONSTRAINT FKHierarchyEO

FOREIGN KEY (Hierarchy) REFERENCES Hierarchy(JobHierarchyID)


-- Cleaning Activity



ALTER TABLE CleaningActivity

ADD CONSTRAINT FKCleanerIDCA

FOREIGN KEY (CleanerID) REFERENCES CleanerInfo(CleanerID)



ALTER TABLE CleaningActivity

ADD CONSTRAINT FKEmpIDCA

FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)



ALTER TABLE CleaningActivity

ADD CONSTRAINT FKGarmCA

FOREIGN KEY (GarmActivityID) REFERENCES GarmActivity(GarmActivityID)


-- Repairs



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