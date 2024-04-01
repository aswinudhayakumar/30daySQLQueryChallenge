with cte as (
	select 
		EXTRACT(month from dates) as month,
		sum(cases_reported) as cases
	from covid_cases
	group by month
),
cte_final as (
	select 
		*,
		sum(cases) over(order by month) as total_cases
	from cte
)
select 
	month,
	case when month > 1 
				then cast(round((cases/lag(total_cases) over(order by month)) * 100, 1) as varchar)
				else '-'
				end as percentage_increase
from cte_final;
