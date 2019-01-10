USE CompanyTest

INSERT INTO GarmDefaultValues(GarmDefaultID, GarmType, GarmCost, Department)
	VALUES (1000, 'Polo Shirt/Bathing Suit', '69.99', '51')

	
INSERT INTO GarmDefaultValues(GarmDefaultID, GarmType, GarmCost, Multiuse, JobHierarchyID, Division, Department)
	VALUES (01, 'Banquets Dress Pants Blk.', '39.99', 1, 1, 'Food And Beverage', 'Banquets'),
			(02, 'Banquets Dress Shirt Wht.', '29.99', 1, 1, 'Food And Beverage', 'Banquets'),
			(03, 'Banquets Vest Blk.', '29.99', 1, 1, 'Food And Beverage', 'Banquets'),
			(04, 'Banquets Sports Coat Blk.', '59.99', 0, 1, 'Food And Beverage', 'Banquets'),
			(05, 'Chef Coat Wht.', '29.99', 0, 2, 'Food And Beverage', 'Banquets'),
			(06, 'Chef Pants Wht', '39.99', 0, 2, 'Food And Beverage', 'Banquets'),
			(07, 'Chef Apron Blk', '29.99', 0, 2, 'Food And Beverage', 'Banquets'),
			(08, 'Banquet Manager Dress Slacks', '59.99', 0, 3, 'Food And Beverage', 'Banquets'),
			(09, 'Banquet Manager Dress Shirt Blk.', '59.99', 0, 4, 'Food And Beverage', 'Banquets'),
			(10, 'Banquet Manager Sport Coat Burgandy', '129.99', 0, 4, 'Food And Beverage', 'Banquets'),
			(11, 'Sous Chef Coat Gray', '39.99', 0, 5, 'Food And Beverage', 'Banquets'),
			(12, 'Sous Chef Pants Gray', '49.99', 0, 5, 'Food And Beverage', 'Banquets'),
			(13, 'Sous Chef Apron Red', '39.99', 0, 5, 'Food And Beverage', 'Banquets');