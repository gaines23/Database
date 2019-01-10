-- I inserted into the tables before running queries


CREATE VIEW TestEmployeeView AS
	SELECT * FROM Employee


CREATE VIEW TestEmp AS
	SELECT EmpID, FirstName, LastName, Address
	FROM Employee


CREATE VIEW TestEmployee AS
	SELECT EmpID, FirstName, LastName
	FROM Employee


SELECT * FROM Hierarchy


CREATE VIEW HierarchyTest AS
	SELECT jobhierarchyid, division, department
	FROM Hierarchy
	WHERE Division = 'Hotel';

CREATE VIEW Hierarchy2 AS
	SELECT jobhierarchyid, department, job, par_level
	FROM Hierarchy
	WHERE PAR_Level = '2';

CREATE VIEW Hierarchy3 AS
	SELECT TOP 10 jobhierarchyid, division, department, job, par_level
	FROM Hierarchy
	WHERE Division = 'Food and Beverage'
	Order BY Department;
	

CREATE VIEW Hierarchy4 AS
	SELECT TOP 30 jobhierarchyid, division, department, job, par_level
	FROM hierarchy
	ORDER BY Department ASC;


-- NEXT use joins, inner, outter, left, right joins to create views between multiple tables


-- attempts at full outter join

CREATE VIEW InnerJoin AS
	SELECT Employee.EmpID, Employee.FirstName, employee.LastName
	FROM Employee 
	INNER JOIN Locker ON Locker.EmpID = employee.EmpID;

CREATE VIEW InnerJoin AS
	SELECT Employee.EmpID, Employee.FirstName, employee.LastName, Locker.Combonation, Locker.LockerNumber, Locker.SerialNum
	FROM Employee 
	INNER JOIN Locker ON Locker.EmpID = employee.EmpID;

USE LaundromatTest

CREATE VIEW InnerJoin2 AS
	SELECT customer.customerid, Customer.FirstName, Customer.LastName, ticketcreate.TicCusAcctID, TicketCreate.ticketnumber, TicketCreate.transactiondate, TicketCreate.TransactionTime
	FROM Customer
	INNER JOIN TicketCreate ON TicketCreate.TicCusAcctID = Customer.CustomerID;


CREATE VIEW InnerJoin3 AS
	SELECT customerid, FirstName, LastName, ticketcreate.TicCusAcctID, TicketCreate.ticketnumber, TicketCreate.transactiondate, TicketCreate.TransactionTime
	FROM Customer
	INNER JOIN TicketCreate ON TicketCreate.TicCusAcctID = Customer.CustomerID;

CREATE VIEW InnerJoin4 AS
	SELECT customerid, FirstName, LastName, TicCusAcctID, ticketnumber, TicketCreate.transactiondate, TicketCreate.TransactionTime
	FROM Customer
	INNER JOIN TicketCreate ON TicketCreate.TicCusAcctID = Customer.CustomerID;

-- seeing if the propere table where each piece of data was retrieved from was needed in the actual query. only time you name the table is when there is the same name for the columns being retrieved.


CREATE VIEW LeftJoin1 AS
	SELECT customer.customerid, Customer.FirstName, Customer.LastName, ticketcreate.TicCusAcctID, TicketCreate.ticketnumber, TicketCreate.transactiondate, TicketCreate.TransactionTime
	FROM Customer
	LEFT JOIN TicketCreate ON TicketCreate.TicCusAcctID = Customer.CustomerID;

CREATE VIEW RightJoin AS
	SELECT customer.customerid, Customer.FirstName, Customer.LastName, ticketcreate.TicCusAcctID, TicketCreate.ticketnumber, TicketCreate.transactiondate, TicketCreate.TransactionTime
	FROM Customer
	RIGHT JOIN TicketCreate ON TicketCreate.TicCusAcctID = Customer.CustomerID;

-- how come everytime i run the joins everything that is inserted appears even if its not in the tyhpe of join im using ??? 

CREATE VIEW RightJoin2 AS
	SELECT Customer.LastName, ticketcreate.TicCusAcctID, TicketCreate.ticketnumber, TicketCreate.transactiondate, TicketCreate.TransactionTime
	FROM Customer
	RIGHT JOIN TicketCreate ON TicketCreate.TicCusAcctID = Customer.CustomerID;