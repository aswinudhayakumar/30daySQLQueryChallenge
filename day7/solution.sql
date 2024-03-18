with cte_res as (
	select 
		*, 
        -- extract only works in postgresql
		extract('isodow' from dates) as dow,
		case when SUBSTRING(day_indicator, extract('isodow' from dates)::int ,1) = '1' then 'include' else 'exclude' end as res 
	from Day_Indicator
)
select product_id, day_indicator, dates from cte_res where res = 'include';
