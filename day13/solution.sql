select 
	mng.name as manager_name, count(emp.name) as employee_count
from employee_managers emp
join employee_managers mng on emp.manager = mng.id
group by mng.name
order by employee_count desc;
