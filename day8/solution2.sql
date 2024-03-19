with RECURSIVE cte as (
    -- base query
	select row_id, job_role, skills from job_skills where row_id = 1
    -- union
	UNION
    -- recursive query
	select js.row_id, COALESCE(js.job_role, cte.job_role) as job_role, js.skills from cte 
	join job_skills js on js.row_id = cte.row_id + 1
)
select * from cte;
