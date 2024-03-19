with cte as (
	select 
		*,
		sum(case when job_role is not null then 1 else 0 end) over(order by row_id) as segment
	from job_skills
)

select 
	row_id,
	first_value(job_role) over(partition by segment order by row_id) as updated_job_role,
	skills
from cte;
