select
    velocity,
    COALESCE(good, 0) as good,
    COALESCE(wrong, 0) as wrong,
    COALESCE(regular, 0) as regular
FROM
    crosstab(
        '
				select 
				v.value as velocity,
				l.value as level,
				count(1) as value
				from auto_repair l
				join auto_repair v 
				on l.client = v.client and l.auto = v.auto and l.repair_date = v.repair_date
				where l.indicator = ''level'' and v.indicator = ''velocity''
				group by v.value, l.value
				order by v.value, l.value
			',
        'select DISTINCT value from auto_repair WHERE indicator = ''level'' order by value'
    ) as result(
        velocity varchar,
        good int,
        regular int,
        wrong int
    )
