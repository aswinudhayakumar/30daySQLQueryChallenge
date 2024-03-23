with RECURSIVE cte as (
        -- base query
		select c.employee, c.manager, t.teams
			from company c
			cross join cte_teams as t
		where c.manager is null

		-- union
		UNION
		
        -- recursive query
		select c.employee, c.manager, COALESCE(t.teams, cte.teams)
			from company c 
			join cte on cte.employee = c.manager
			left join cte_teams t on t.employee = c.employee
	),
	
	cte_teams as (
			SELECT mng.employee, concat('Team ', ROW_NUMBER() over(order by mng.employee)) as teams
				FROM company root
				join company mng on root.employee = mng.manager
			where root.manager is null
	)

select 
	teams, string_agg(employee, ', ') as members
	from cte 
group by teams
order by teams;
