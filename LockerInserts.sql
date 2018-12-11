USE work_test;

INSERT INTO locker (lockernumber, serialnum, combonation, empid, reasons)
VALUES (1, 1234567, '24-24-24', 1001, 'Storing Lettuce');


INSERT INTO locker (lockernumber, serialnum, combonation, empid, reasons)
VALUES (2, 1234568, '19-19-19', 100001, 'Hiding Grapes'),
		(3, 1234569, '12-13-14', 100002, 'Ninja Turtle'),
        (4, 1234570, '24-21-20', 100003, 'Smelly Socks'),
        (5, 1234571, '10-15-18', 100004, 'Pokemon Cards');
        
INSERT INTO locker (lockernumber, serialnum, combonation, empid)
VALUES (6, 1234572, '12-12-12', 100005),
		(7, 1234573, '10-05-27', 100006),
        (8, 1234574, '02-15-29', 100007);
        
INSERT INTO locker (lockernumber, serialnum, combonation, empid, reasons)
VALUES (9, 1234575, '21-24-22', 100010, 'Garlic'),
		(10, 1234576, '10-23-12', 100011, 'Charlies Tree'),
        (11, 1234577, '21-09-03', 100013, 'Cat Treats');

		SELECT * FROM locker;
		DROP TABLE locker;
		SELECT * FROM employee