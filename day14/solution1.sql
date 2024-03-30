select generate_series(min(serial_no), max(serial_no)) as serial_no
from invoice
	except
select serial_no from invoice order by serial_no asc;
