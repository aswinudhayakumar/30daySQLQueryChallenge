-- get every data in the table normally
select dates, cast(product_id as varchar) as products from orders
union
-- get data by aggregating product_id
select 
	dates,
	string_agg(cast(product_id as varchar), ',') as products
from orders
GROUP by dates, customer_id order by dates, products;
