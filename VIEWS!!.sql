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