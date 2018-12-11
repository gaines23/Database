USE work_test;

INSERT INTO employee (empid, firstname, lastname, address, phonenmber, email)
	VALUES (100000, 'Jeffrey', 'Benson', '10971 Hillcreek Rd.','619-543-4343','turtles.com@ymail.com');
    
INSERT INTO employee (empid, firstname, lastname, address, phonenmber, email)
	VALUES (100001, 'Melissa', 'Gaines', '1234 Nala Ln.', '123-619-4545', 'mgaines@doggo.com'),
    (100002, 'Jason', 'Dale', '2255 Charriott St.', '232-233-5555', 'jd24@ymail.com')


INSERT INTO employee (empid, firstname, lastname, address, phonenmber, email)
	VALUES (100003, 'Mike', 'Ortega', '2323 Channel Rd.', '619-999-2423', 'ortega@yahoo.com'),
		(100004, 'Bailey', 'Voss', '1234 Love Ln.', '1-999-323-5454', 'bvoss@gmail.com'),
        (100005, 'Jeff', 'Dale', '43333 Old Man Ln.', '1-323-854-1234', 'jeffrey@cox.net');

INSERT INTO employee (empid, firstname, lastname, address, phonenmber, email)
	VALUES (100006, 'Dale', 'Benson', '123 Somewhere Ville', '1-878-654-9876', 'dbenson@ymail.com'),
		(100007, 'Louise', 'Voss', '123 Somewhere Ville', '1-122-123-4567', 'lvoss.24@ymail.com'),
        (100008, 'Scott', 'Benson', '43333 Old Man ln.', '9-111-234-5432', 'sbsb@ymail.com'),
        (100009, 'Karen', 'Warner', '9876 IdontKnow', '1-232-456-7890', 'meanpeoplexist@ymail.com');

INSERT INTO employee (empid, firstname, lastname, address, phonenmber, email)
	VALUES (100010, 'Joe', 'Shmoo','3535 Josph Ln.', '123-454-7677', 'joeshmoo@yahoo.com'),
		(100011, 'Snoopy', 'Dog', '1 Charlie Brown Ln.', '666-555-4444', 'snoopy@cox.net'),
        (100012, 'Woodstock', 'Yellow', '1 Charlie Brown Ln.', '666-555-4444', 'yellowfeathers@cox.net'),
        (100013, 'Rachel', 'Benson', '1234 Cat ln.', '1-800-123-1234', 'afifan@gmail.com');

DROP TABLE employee