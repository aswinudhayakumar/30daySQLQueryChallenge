with recursive cte as 
	(
    -- base query
    select min(serial_no) as n from invoice
    -- union
		UNION
    -- recursive query
	 select (n+1) as n 
	 from cte
	 where n < (select max(serial_no) from invoice)
	)
select * from cte
	except 
select serial_no from invoice;
