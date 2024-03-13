with cte_trails1 as (
    -- join mountain_huts and trails table
    SELECT
        t1.hut1 as start_hut,
        h1.name as start_hut_name,
        h1.altitude as start_hut_altitude,
        t1.hut2 as end_hut
    from
        mountain_huts as h1
        join trails t1 on t1.hut1 = h1.id
),
cte_trails2 as (
    -- create an altitude_flag based on decreasing altitude
    -- altitude_flag is 1 if start_hut_altitude > h2.altitude, else mark it as 0
    SELECT
        t2.*,
        h2.name as end_hut_name,
        h2.altitude as end_hut_altitude,
        case
            when start_hut_altitude > h2.altitude then 1
            else 0
        end as altitude_flag
    from
        cte_trails1 t2
        join mountain_huts h2 on h2.id = t2.end_hut
),
cte_final as (
    -- as the trails are bidirectional, replace the start_hut and end_hut if altitude_flag is 0
    select
        -- if altitude_flag is 1, make start_hut as start_hut
        -- else make end_hut as start_hut
        case
            when altitude_flag = 1 then start_hut
            else end_hut
        end as start_hut,
        -- if altitude_flag is 1, make start_hut_name as start_hut_name
        -- else make end_hut_name as start_hut_name
        case
            when altitude_flag = 1 then start_hut_name
            else end_hut_name
        end as start_hut_name,
        -- if altitude_flag is 1, make end_hut as end_hut
        -- else make start_hut as end_hut
        case
            when altitude_flag = 1 then end_hut
            else start_hut
        end as end_hut,
        -- if altitude_flag is 1, make end_hut_name as end_hut_name
        -- else make start_hut_name as end_hut_name
        case
            when altitude_flag = 1 then end_hut_name
            else start_hut_name
        end as end_hut_name
    from
        cte_trails2
) -- self join the cte_final table,
select
    c1.start_hut_name as start_point,
    c1.end_hut_name as middle_point,
    c2.end_hut_name as end_point
from
    cte_final c1
    join cte_final c2 on c1.end_hut = c2.start_hut;