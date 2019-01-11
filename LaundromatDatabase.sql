CREATE DATABASE LaundromatTest;

USE LaundromatTest;

CREATE TABLE Customer( --Laundry Matt 
	CustomerID INT NOT NULL PRIMARY KEY
	, FirstName VARCHAR(MAX) NOT NULL
	, LastName VARCHAR(MAX) NOT NULL
	, Address VARCHAR(MAX) NOT NULL
	, PhoneNumber VARCHAR(15)
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


CREATE TABLE CusOrder( --Luandry Matts
	CusOrderID INT NOT NULL
	, CustomerID INT -- FK EmployeeID
	, Hierarchy INT -- FK Hierarchy 
	, Garm INT -- FK Garm
	, CONSTRAINT CusOrdID PRIMARY KEY (CusOrderID)
)


DROP TABLE SlotAssignment

CREATE TABLE SlotAssignment(
	SlotAssignmentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	, SlotNumber INT NOT NULL
	, ConveyourNum INT NOT NULL
	, CusID INT NOT NULL
	, GarmID INT NOT NULL
	, CONSTRAINT FKCusInformID FOREIGN KEY(CusID)
		REFERENCES Customer(Customerid)
		ON DELETE CASCADE    
		ON UPDATE CASCADE
	);
-- cusid fk to customerid in customer table?
-- updated the table to delete and update as well with the customer id so wehave another refrence


CREATE TABLE Scan(
	ScanID INT NOT NULL
	, RFID INT
	, BARCODE VARCHAR(MAX)
	, ScanTime TIMESTAMP NOT NULL
	, CONSTRAINT ScanNumID PRIMARY KEY (ScanID, ScanTime)
)
-- probably needs something that includes emp info

DROP TABLE Repairs

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
-- Having CusID refrence to the customer table as well

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
--	, TransDateTime TIMESTAMP NOT NULL 
	, CONSTRAINT PKGarmID PRIMARY KEY (GarmentNumber)
	, CONSTRAINT FKCusAcctID FOREIGN KEY (GarmCusAcctID)
		REFERENCES CustomerCreate(AccountNumber)
	 , CONSTRAINT FKTicNumID FOREIGN KEY (TicketNumber)
		REFERENCES TicketCreate(TicketNumber)		
		ON DELETE CASCADE
		ON UPDATE CASCADE
)
-- LAUNDROMAT DATABASE

INSERT INTO TicketCreate(TicCusAcctID, TicketNumber,TransactionDate, TransactionTime)
	VALUES ('1000', '200000', '2001-12-12', '05:54:23')

SELECT * FROM TicketCreate;
SELECT * FROM Customer;

USE work_test;
INSERT INTO customer (customerid, firstname, lastname, address, phonenumber, email)
	VALUES (1000, 'Jmoney', 'Baggs', '123 Money St.', 1-800-003-2233, 'money@money.com'),
		(1001, 'Scooter', 'The Turtle', '1 Yurtles Castle', 1-800-437-3737, 'iliketurtles@ymail.com'),
        (1002, 'Nala', 'Doggo', '123 Dog House', 1-800-656-7878, 'cute.n.cuddly@dog.net');
        
        
INSERT INTO customer (customerid, firstname, lastname, address, phonenumber)
	VALUES ( 1003, 'Sienna', 'Doggo', '123 Dog House', 1-555-555-4444),
		(1004, 'Simba', 'Kitty Cat', '444 Katz Club', 1-333-242-4343),
        (1005, 'Luna', 'Kitty Cat', '1 Yurtles Castle', 1-454-232-3233),
        (1006, 'Pet Stop', 'Pet Shop', '1223 Pet Ln.', 1-800-232-6767);
        
        
INSERT INTO customer (customerid, firstname, lastname, address, email)
	VALUES (1007, 'Jeryy', 'Springer', 'HOLLYWOOD', 'jspringer@cox.net'),
		(1008, 'Cereal', 'Kisser', '1 Lucky Charms Ln.', 'therealkisser@google.com'),
        (1009, 'Papas', 'Doggo', '1919 Dog House', 'papasnopico@cox.net'),
        (1010, 'Twilight', 'Sparkles', '123 Aquestria Pl.', 'mylittlepony1@gmail.com');

SELECT * FROM customer;
SELECT * FROM ticketcreate;
INSERT INTO Ticketcreate (


USE LAUNDROMAT
