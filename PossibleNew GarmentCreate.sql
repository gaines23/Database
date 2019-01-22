CREATE TABLE GarmentCreate(
	AccountNumber -- FK Employee Empid
	TicketNumber -- FK ticketCreate, ticketnumber
	GarmID -- FK GarmDefaultID
	JobHierarchyID -- FK Hierarchy
	TransactionDate
	TransactionTime
	, CONSTRAINT PKGarmID PRIMARY KEY (GarmentNumber)
	, CONSTRAINT FKEmpID FOREIGN KEY (AccountNumber)
		REFERENCES Employee(EmpID)
	 , CONSTRAINT FKTicID FOREIGN KEY (TicketNumber)
		REFERENCES TicketCreate(TicketNumber)		
		ON DELETE CASCADE
		ON UPDATE CASCADE