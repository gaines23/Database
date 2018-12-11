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