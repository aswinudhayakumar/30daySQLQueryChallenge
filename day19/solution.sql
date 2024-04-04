select 
	to_char(order_time, 'Mon-YYYY') as period,
	round((cast(	sum(case when cast(to_char(actual_delivery - order_time, 'MI') as int) > 30
				then 1 
				else 0
				end ) as decimal
		) / count(1)) * 100, 1) as delayed_flag,
	sum(case when cast(to_char(actual_delivery - order_time, 'MI') as int) > 30
				then no_of_pizzas 
				else 0
				end) as free_pizza
from pizza_delivery
where actual_delivery is not null
group by to_char(order_time, 'Mon-YYYY')
order by extract(month from to_date(to_char(order_time, 'Mon-YYYY'), 'Mon-YYYY'));
