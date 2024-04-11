with cte as (
	select 
		p.*, 
		s.session_starttime, 
		s.session_endtime,
		extract('epoch' from (s.session_endtime - s.session_starttime)) as total_time
	from user_sessions s 
	join post_views p on p.session_id = s.session_id
)
select 
	post_id,
	sum((perc_viewed/100)*total_time) as total_view_time
from cte	
group by post_id
having sum((perc_viewed/100)*total_time) > 5;
