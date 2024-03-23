with recursive cte as (
	select employee ,manager, concat('team ',row_number() over (order by employee)) as rn 
	from company 
	where manager = (select employee from company where manager is null)
	
	union all
	
	select d.employee,d.manager,rn
		from cte
		join company d
	on d.manager = cte.employee)
 
,final_cte as (
	 	select 
		rn as teams,
		string_agg(employee,',') as emp
		from cte
		group by rn
		)

select 
	teams,
	concat(employee,',',emp) as MEMBERS 
	from company c 
	cross join final_cte
where c.manager is null
ORDER BY teams;
