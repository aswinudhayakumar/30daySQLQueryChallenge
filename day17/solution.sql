with cte as (
	select 
		*,
		DENSE_RANK() over(partition by user_id order by user_id, login_date),
		login_date - cast(	DENSE_RANK() over(partition by user_id order by user_id, login_date) 
							as int
						) as date_group
	from user_login
)
select 
	user_id, 
	date_group, 
	min(login_date) as start_date,
	max(login_date) as end_date,
	(max(login_date) - min(login_date) + 1) as consecutive_days
from cte
group by user_id, date_group
having (max(login_date) - min(login_date) + 1) >= 5;
