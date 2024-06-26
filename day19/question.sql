-- https://techtfq.com/blog/30daysqlquerychallenge-query-19

-- Given table showcases details of pizza delivery order for the year of 2023.
-- If an order is delayed then the whole order is given for free. Any order that takes 30 minutes more than the expected time is considered as delayed order. 
-- Identify the percentage of delayed order for each month and also display the total no of free pizzas given each month.


DROP TABLE IF EXISTS pizza_delivery;
CREATE TABLE pizza_delivery 
(
	order_id 			INT,
	order_time 			TIMESTAMP,
	expected_delivery 	TIMESTAMP,
	actual_delivery 	TIMESTAMP,
	no_of_pizzas 		INT,
	price 				DECIMAL
);


-- Data to this table can be found in CSV File

select * from pizza_delivery;
