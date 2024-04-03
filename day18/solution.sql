select 
	e.name as employee_name,
	count(distinct event_name) as no_of_events 
from events ev
join employees e on e.id = ev.emp_id
group by e.name
having count(distinct event_name) = (select count(DISTINCT event_name) from events)
order by e.name;
