INSERT INTO employee (emp_id, first_name, last_name, address, phone_number, email)
	VALUE (100000, 'Jeffrey', 'Benson', '10971 Hillcreek Rd.','619-543-4343','turtles.com@ymail.com');
    
INSERT INTO employee (emp_id, first_name, last_name, address, phone_number, email)
	VALUE (100001, 'Melissa', 'Gaines', '1234 Nala Ln.', '123-619-4545', 'mgaines@doggo.com'),
    (100002, 'Jason', 'Dale', '2255 Charriott St.', '232-233-5555', 'jd24@ymail.com');
    
-- test data before adding more constraints

INSERT INTO employee (emp_id, first_name, last_name, address)
	VALUE (100003, 'Mike', 'Ortega', '2323 Channel Rd.'),
		(100004, 'Bailey', 'Voss', '1234 Love Ln.'),
        (100005, 'Jeff', 'Dale', '43333 Old Man Ln.');
-- Left out email and phone number to test nulls        

INSERT INTO employee (emp_id, first_name, last_name, address, email)
	VALUE (100006, 'Dale', 'Benson', '123 Somewhere Ville', 'dbenson@ymail.com'),
		(100007, 'Louise', 'Voss', '123 Somewhere Ville', 'lvoss.24@ymail.com'),
        (100008, 'Scott', 'Benson', '43333 Old Man ln.', 'sbsb@ymail.com'),
        (100009, 'Karen', 'Warner', '9876 IdontKnow', 'meanpeoplexist@ymail.com');
	-- Left out phone number to test null.
        
INSERT INTO employee (emp_id, first_name, last_name, address, phone_number)
	VALUE (100010, 'Joe', 'Shmoo','3535 Josph Ln.', '123-454-7677'),
		(100011, 'Snoopy', 'Dog', '1 Charlie Brown Ln.', '666-555-4444'),
        (100012, 'Woodstock', 'Yellow', '1 Charlie Brown Ln.', '666-555-4444'),
        (100013, 'Rachel', 'Benson', '1234 Cat ln.', '1-800-cat-meow');
	-- left out emails to check nulls.
	

	
INSERT INTO customer (customer_id, first_name, last_name, address, phone_number, email)
	VALUE (1000, 'Jmoney', 'Baggs', '123 Money St.', '1-800-moneyme', 'money@money.com'),
		(1001, 'Scooter', 'The Turtle', '1 Yurtles Castle', '1-800-too-fast', 'iliketurtles@ymail.com'),
        (1002, 'Nala', 'Doggo', '123 Dog House', '1-800-dog-food', 'cute.n.cuddly@dog.net');
        
        
INSERT INTO customer (customer_id, first_name, last_name, address, phone_number)
	VALUE ( 1003, 'Sienna', 'Doggo', '123 Dog House', '1-555-555-4444'),
		(1004, 'Simba', 'Kitty Cat', '444 Katz Club', '1-333-cat-klub'),
        (1005, 'Luna', 'Kitty Cat', '1 Yurtles Castle', '1-454--232-3233'),
        (1006, 'Pet Stop', 'Pet Shop', '1223 Pet Ln.', '1-800-pet-feed');
        
        
INSERT INTO customer (customer_id, first_name, last_name, address, email)
	VALUE (1007, 'Jeryy', 'Springer', 'HOLLYWOOD', 'jspringer@cox.net'),
		(1008, 'Cereal', 'Kisser', '1 Lucky Charms Ln.', 'therealkisser@google.com'),
        (1009, 'Papas', 'Doggo', '1919 Dog House', 'papasnopico@cox.net'),
        (1010, 'Twilight', 'Sparkles', '123 Aquestria Pl.', 'mylittlepony1@gmail.com');
		
		
		
INSERT INTO locker (locker_num, serial_num, combination, emp_id,reason)
VALUE (1, 1234567, '24-24-24', 1001, 'Storing Lettuce');


INSERT INTO locker (locker_num, serial_num, combination, emp_id,reason)
VALUE (2, 1234568, '19-19-19', 100001, 'Hiding Grapes'),
		(3, 1234569, '12-13-14', 100002, 'Ninja Turtle'),
        (4, 1234570, '24-21-20', 100003, 'Smelly Socks'),
        (5, 1234571, '10-15-18', 100004, 'Pokemon Cards');
        
INSERT INTO locker (locker_num, serial_num, combination, emp_id)
VALUE (6, 1234572, '12-12-12', 100005),
		(7, 1234573, '10-05-27', 100006),
        (8, 1234574, '02-15-29', 100007);
        
INSERT INTO locker (locker_num, serial_num, combination, emp_id,reason)
VALUE (9, 1234575, '21-24-22', 100010, 'Garlic'),
		(10, 1234576, '10-23-12', 100011, 'Charlies Tree'),
        (11, 1234577, '21-09-03', 100013, 'Cat Treats');
		
		
		
INSERT INTO hierarchy (job_hierarchy_id, division, department, job, par_level)
	VALUE ( 1, 'Food and Beverage', 'Banquets', 'Banquet Captain', '2'),
		(2, 'Food and Beverage', 'Banquets', 'Banquet Chef', '3'),
        (3, 'Food and Beverage', 'Banquets', 'Banquet Manager', '2'),
        (4, 'Food and Beverage', 'Banquets', 'Banquets Sous Chef', '3'),
        (5, 'Food and Beverage', 'Banquets', 'Bartender - Banquets', '1'),
        (6, 'Food and Beverage', 'Banquets', 'Cook - Banquets', '2'),
        (7, 'Food and Beverage', 'Banquets', 'Coordinator - Sales/Catering', '1'),
        (8, 'Food and Beverage', 'Banquets', 'Open Air Help', '1'),
        (9, 'Food and Beverage', 'Banquets', 'Sales/Banquets Manager', '1'),
        (10, 'Food and Beverage', 'Banquets', 'Server - Banquets', '2'),
        (11, 'Food and Beverage', 'Banquets', 'Set up - Banquets', '1'),
        (12, 'Food and Beverage', 'Beverage', 'Asst Beverage Manager/Lead Bartender', '2'),
        (13, 'Food and Beverage', 'Beverage', 'Beverage Manager', '1'),
        (14, 'Food and Beverage', 'Beverage', 'Beverage Supervisor', '1');
	
INSERT INTO hierarchy (job_hierarchy_id, division, department, job, par_level)
	VALUE (15, 'Food and Beverage', 'Casino Services Bar', 'Cash Server - Casino Services Bar', '2'),
		(16, 'Food and Beverage', 'Center Bar','Bartender - Center Bar', '2'),
        (17, 'Food and Beverage', 'Center Bar', 'Cash Server - Center Bar', '2'),
        (18, 'Food and Beverage', 'Center Bar', 'Porter - Center Bar', '1'),
        (19, 'Food and Beverage', 'Firebreak', 'Assistant Manager - Firebreak', '2'),
        (20, 'Food and Beverage', 'Firebreak', 'Barback - Firebreak', '3'),
        (21, 'Food and Beverage', 'Firebreak', 'Bartender - Firebreak', '2'),
        (22, 'Food and Beverage', 'Firebreak', 'Busser - Firebreak', '2'),
        (23, 'Food and Beverage', 'Firebreak', 'Chef - Firebreak', '2'),
        (24, 'Food and Beverage', 'Firebreak', 'Cook - Firebreak', '2'),
        (25, 'Food and Beverage', 'Firebreak', 'Food Runner - Firebreak', '2'),
        (26, 'Food and Beverage', 'Firebreak', 'General Manager - Firebreak', '2'),
        (27, 'Food and Beverage', 'Firebreak', 'Host - Firebreak', '1'),
        (28, 'Food and Beverage', 'Firebreak', 'Lead Cook - Firebreak', '2'),
        (29, 'Food and Beverage', 'Firebreak', 'Prep Cook- Firebreak', '2'),
        (30, 'Food and Beverage', 'Firebreak', 'Resturant Supervisor - Firebreak', '2'),
        (31, 'Food and Beverage', 'Firebreak', 'Server - Firebreak', '2'),
        (32, 'Food and Beverage', 'Firebreak', 'Sous Chef - Firebreak', '2'),
        (33, 'Food and Beverage', 'Fuel', 'Barista - Fuel Cafe', '2'),
        (34, 'Food and Beverage', 'Fuel', 'Supervisor - Fuel Cafe', '2'),
        (35, 'Food and Beverage', 'North Bar', 'Bartender - North Bar', '2'),
        (36, 'Food and Beverage', 'North Bar', 'Cash Server - North Bar', '2'),
        (37, 'Food and Beverage', 'North Bar', 'Porter - North Bar', '2'),
        (38, 'Food and Beverage', 'Oyster Bar', 'Busser - Oyster Bar', '2'),
        (39, 'Food and Beverage', 'Oyster Bar', 'Cook - Oyster Bar', '3'),
        (40, 'Food and Beverage', 'Oyster Bar', 'Host - Oyster Bar', '1'),
        (41, 'Food and Beverage', 'Oyster Bar', 'Server - Oyster Bar', '2'),
        (42, 'Food and Beverage', 'Oyster Bar', 'Sous Chef - Oyster Bar', '3'),
        (43, 'Food and Beverage', 'Park Prime', 'Assistant Manager - Steakhouse', '2'),
        (44, 'Food and Beverage', 'Park Prime', 'Bartender - Steakhouse', '2'),
        (45, 'Food and Beverage', 'Park Prime', 'Busser - Steakhouse', '2'),
        (46, 'Food and Beverage', 'Park Prime', 'Cook - Steakhouse', '3'),
        (47, 'Food and Beverage', 'Park Prime', 'Chef - Steakhouse', '3'),
        (48, 'Food and Beverage', 'Park Prime', 'General Manager - Steakhouse', '2'),
        (49, 'Food and Beverage', 'Park Prime', 'Host - Steakhouse', '1'),
        (50, 'Food and Beverage', 'Park Prime', 'Server - Steakhouse', '2'),
        (51, 'Food and Beverage', 'Pool Bar', 'Bartender - Pool Bar', '2'),
        (52, 'Food and Beverage', 'Pool Bar', 'Cabana Attendant - Pool Bar', '1'),
        (53, 'Food and Beverage', 'Pool Bar', 'Cash Server - Pool Bar', '2'),
        (54, 'Food and Beverage', 'Pool Bar', 'Lifegaurd - Pool Bar', '2'),
        (55, 'Food and Beverage', 'Pool Bar', 'Lifegaurd Instructor', '1'),
        (56, 'Food and Beverage', 'Pool Bar', 'Pool Supervisor - Pool Bar', '2'),
        (57, 'Food and Beverage', 'Pool Bar', 'Porter - Pool Bar', '1'),
        (58, 'Food and Beverage', 'Room Service', 'Line Cook - Room Service', '2'),
        (59, 'Food and Beverage', 'Room Service', 'Server - Room Service', '2'),
        (60, 'Food and Beverage', 'Room Service', 'Supervisor - Room Service', '2');
        
 

INSERT INTO hierarchy (job_hierarchy_id, division, department, job, par_level)
	VALUE (61, 'Finance', 'Cage', 'Dual Rate Supervisor', '2'),
        (62, 'Finance', 'Cage', 'Employee Banker', '2'),
        (63, 'Finance', 'Cage', 'Main Banker - Vault Staff', '2'),
        (64, 'Finance', 'Cage',  'Player Services - Cage Manager', '2'),
        (65, 'Finance', 'Cage', 'Player Services - Cage Rep', '2'),
        (66, 'Finance', 'Cage', 'Player Services - Cage Supervisor', '2'),
        (67, 'Finance', 'Count', 'Count Room Staff', '2'),
        (68, 'Finance', 'Count', 'Count Room Supervisor', '2');


INSERT INTO hierarchy (job_hierarchy_id, division, department, job, par_level)
	VALUE (69, 'Facilities', 'Engineering', 'Director/Chef Engineer - Facilities', '3'),
		(70, 'Facilities', 'Engineering', 'Engineer - Facilities', '3'),
        (71, 'Facilities', 'Engineering', 'Groundskeeper - Facilities', '3'),
        (72, 'Facilities', 'Engineering', 'Lead Boiler Tech - Facilities', '3'),
        (73, 'Facilities', 'Engineering', 'Lead Electrician - Facilities', '3'),
        (74, 'Facilities', 'Engineering', 'Lead Groundskeeper - Facilities', '3'),
        (75, 'Facilities', 'Engineering', 'Lead PM Engineer - Facilities', '3'),
        (76, 'Facilities', 'Engineering', 'Maintenance Supervisor - Facilities', '3'),
        (77, 'Facilities', 'Engineering', 'Service Writer - Facilities', '3');
        
        
INSERT INTO hierarchy (job_hierarchy_id, division, department, job, par_level)
	VALUE (78, 'Hotel', 'Front Desk', 'Concierge', '2'),
		(79, 'Hotel', 'Front Desk', 'Director Of Hotel Operations', '2'),
        (80, 'Hotel', 'Front Desk', 'Front Desk - Night Audit', '2'),
        (81, 'Hotel', 'Front Desk', 'Front Desk - Agent', '2'),
        (82, 'Hotel', 'Front Desk', 'Manager Of Hotel Operations', '2'),
        (83, 'Hotel', 'Front Desk', 'Projects', '2'),
        (84, 'Hotel', 'Front Desk', 'Reservations Agent', '2'),
        (85, 'Hotel', 'Front Desk', 'Reservations Supervisor', '2'),
        (86, 'Hotel', 'Front Desk', 'Supervisor Of Hotel Operations', '2'),
        (87, 'Hotel', 'Gift Shop', 'Cashier - Gift Shop', '2'),
        (88, 'Hotel', 'Gift Shop', 'Cashier - Sundries', '2'),
        (89, 'Hotel', 'Gift Shop', 'Supervisor - Gift Shop', '2'),
        (90, 'Hotel', 'Valet', 'Front Services Attendant', '2'),
        (91, 'Hotel', 'Valet', 'Front Services Lead Attendant', '2'),
        (92, 'Housekeeping', 'Housekeeping', 'Housekeeping Attendant', '2'),
        (93, 'Housekeeping', 'Laundry', 'Attendant - Laundry/Uniforms', '2'),
        (94, 'Housekeeping', 'Laundry', 'Lead - Laundry/Uniforms', '2'),
        (95, 'Purchasing', 'Warehouse', 'Lead Warehouse Reciever', '2'),
        (96, 'Purchasing', 'Warehouse', 'Receiving Clerk - Warehouse', '2'),
        (97, 'Purchasing', 'Warehouse', 'Laborer', '2'),
        (98, 'Security', 'Security', 'Director - Security/Surveillance', '2'),
        (99, 'Security', 'Security', 'Lead Security Officer', '2'),
        (100, 'Security', 'Security', 'Officer - Security', '2'),
        (101, 'Security', 'Security', 'Supervisor - Security', '2'),
        (102, 'Security', 'Surveillance', 'Surveillance Agent', '2'),
        (103, 'Security', 'Surveillance', 'Surveillance Supervisor', '2'),
        (104, 'Security', 'Surveillance', 'Surveillance Technician', '2'),
        (105, 'Casino Operations', 'Slots', 'Slot Floor Attendants', '2'),
        (106, 'Casino Operations', 'Slots', 'Slot Floor Supervisors', '2'),
        (107, 'Casino Operations', 'Slots', 'Slot Manager', '2'),
        (108, 'Casino Operations', 'Slots', 'Slot Shift Manager', '2'),
        (109, 'Casino Operations', 'Slots', 'Slot Tech Apprentice', '2'),
        (110, 'Casino Operations', 'Slots', 'Slot Tech Supervisor', '2'),
        (111, 'Casino Operations', 'Slots', 'Slot Techs', '2'),
        (112, 'Casino Operations', 'Table Games', 'Assistant Shift Manager', '2'),
        (113, 'Casino Operations', 'Table Games', 'Casino Shift Manager', '2'),
        (114, 'Casino Operations', 'Table Games', 'Duel Rate Supervisor', '2'),
        (115, 'Casino Operations', 'Table Games', 'Gaming Director', '2'),
        (116, 'Casino Operations', 'Table Games', 'Table Games Dealer III - All Games', '2'),
        (117, 'Casino Operations', 'Table Games', 'Table Games Manager', '2'),
        (118, 'Casino Operations', 'Table Games', 'Table Games Assistant', '2');
		
		
		
INSERT INTO manufacturer (manufacturer_name, manufacturer_address, manufacturer_phone, manufacturer_email, garment, garm_cost)
	VALUE ('My Shirts Cooler Than Yours', '123 Glitter', '1-800-my-shirt', 'dope_t@tmart.com', 12, 5.99);-- button up long sleeves
-- TABLE INSERTS TO CREATE INDEXES AND REFERENCeS



INSERT INTO manufacturer (manufacturer_name, manufacturer_address, manufacturer_phone, manufacturer_email, garment, garm_cost)
	VALUE ('A Better Coat', '4242 Marley Ln.', '1-800-get-coat', 'goodcoats@ymail.com', 1, 69.99),-- suit coats
		  ('Nike', '1212 Busta Move Rd.', '1-800-run-fast', 'nike@gmail.com', 20, 29.99),-- shoes
          ('Good Housekeeping', '1343 Palace Ln.', '1-555-888-9999', 'goodhousekeeping@gmail.com', 17, 99.99),-- housekeeping whole uniform
          ('Lock 4 You', '35352 Newport St.', '1-800-342-lock', 'nicelocks@ymail.com', 99, 4.99),-- locker locks
		  ('Slick Slacks', '1 market st.', '1-234-444-4444', 'tightandright@ymail.com', 2, 34.99),-- dress pants
          ('Its NOT YOLO Its Polo', '1452 River Rd.', '1-800-321-POLO', 'polosformen@gmail.com', 19, 29.99),-- polo shirts
          ('Chefs Choice', '9473 Dictator Dr.', '1-800-mmm-food', 'chefattire@cox.net', 30, 89.99);-- Chef Clothes 

        


INSERT INTO scan (scan_id, barcode, scan_time)-- testing more values and inserts.
	VALUE (1, '00000 - 00000', '2002-02-24 01:45:06'),
		  (2, '01000 - 00000', '2002-02-24 06:23:24'),
		  (3, '01100 - 00000', '2002-02-25 05:24:19'),
          (4, '01110 - 00000', '2002-02-25 07:55:17'),
          (5, '01111 - 00000', '2002-02-25 07:57:34'),
          (6, '01111 - 10000', '2002-02-27 09:36:22'),
          (7, '01111 - 11000', '2002-03-01 13:27:09'),
          (8, '01111 - 11100', '2002-03-01 14:11:01'),
          (9, '01111 - 11110', '2002-03-01 18:18:18'),
          (10, '01111 - 11111', '2002-03-01 23:58:59'),
          (11, '11111 - 11111', '2002-03-02 3:52:51'),
          (12, '12111 - 11111', '2002-03-02 5:43:12'),
          (13, '12211 - 11111', '2002-03-02 10:30:23'),
          (14, '12221 - 11111', '2002-03-02 14:23:21'),
          (15, '12222 - 11111', '2002-03-02 17:10:10'),
          (16, '12222 - 21111', '2002-03-02 19:53:12'),
          (17, '12222 - 22111', '2002-03-03 1:21:09'),
          (18, '12222 - 22211', '2002-03-03 3:11:11'),
          (19, '12222 - 22221', '2002-03-03 7:11:59'),
          (20, '12222 - 22222', '2002-03-03 7:12:32'),
          (21, '22222 - 22222', '2002-03-03 8:12:22'),
          (22, '23222 - 22222', '2002-03-03 8:12:24'),
          (23, '23322 - 22222', '2002-03-03 9:15:30'),
          (24, '23332 - 22222', '2002-03-03 9:17:45'),
          (25, '23333 - 22222', '2002-03-03 9:30:12'),
          (26, '23333 - 32222', '2002-03-03 9:38:43'),
          (27, '23333 - 33222', '2002-03-03 10:01:01'),
          (28, '23333 - 33322', '2002-03-03 10:09:32'),
          (29, '23333 - 33332', '2002-03-03 10:10:59'),
          (30, '23333 - 33333', '2002-03-03 10:32:23'),
          (31, '33333 - 33333', '2002-03-03 11:23:54'),
          (32, '34333 - 33333', '2002-03-03 15:21:32'),
          (33, '34433 - 33333', '2002-03-03 15:32:43'),
          (34, '34443 - 33333', '2002-03-03 17:24:54'),
          (35, '34444 - 33333', '2002-03-03 17:30:24'),
          (36, '34444 - 43333', '2002-03-03 20:43:23'),
          (37, '34444 - 44333', '2002-03-03 23:12:23'),
          (38, '34444 - 44422', '2002-03-04 2:32:12');
          -- What will we use in rfid code?
		  
		  
INSERT INTO company_info (company_name, company_address, company_phone, company_email)
	VALUE ('White Conveyors, Inc', '10 Boright Ave, Kenilworth, NJ 07033', '(908) 686-5700', 'whiteconveyors@gmail.com');