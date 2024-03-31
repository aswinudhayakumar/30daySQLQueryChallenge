with all_friends as (
	select friend1, friend2 from Friends
	union all
	select friend2, friend1 from Friends 
	order by 1
)
select 
	distinct f.*,
	count(af.friend2) over(partition by f.friend1, f.friend2 order by f.friend1, f.friend2
							range between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) as mutual_friends
	from Friends f
	left join all_friends af 
		on f.friend1 = af.friend1
		and af.friend2 in (
							select friend2 
							from all_friends af2 
							where af2.friend1 = f.friend2
						)
order by 1;
