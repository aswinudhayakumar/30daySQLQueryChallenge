with cte as (
	SELECT *,
		sum(case when car is not null then 1 else 0 end) over(order by id) as car_segment,
		sum(case when length is not null then 1 else 0 end) over(order by id) as length_segment,
		sum(case when width is not null then 1 else 0 end) over(order by id) as width_segment,
		sum(case when height is not null then 1 else 0 end) over(order by id) as height_segment
	from footer)
select 
	FIRST_VALUE(car) over (partition by car_segment order by id) as new_car,
	FIRST_VALUE(length) over (partition by length_segment order by id) as new_length,
	FIRST_VALUE(width) over (partition by width_segment order by id) as new_width,
	FIRST_VALUE(height) over (partition by height_segment order by id) as new_height
from cte
order by id desc limit 1;