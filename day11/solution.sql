with cte as (
    select
        *,
        round(
            avg(rating) over(
                partition by hotel
                order by
                    year range between UNBOUNDED PRECEDING
                    and UNBOUNDED FOLLOWING
            ),
            2
        ) as avg_rating
    from
        hotel_ratings
),
cte_rnk as (
    select
        *,
        abs(rating - avg_rating),
        rank() over(
            partition by hotel
            order by
                abs(rating - avg_rating) desc
        ) as rnk
    from
        cte
)
select
    hotel,
    year,
    rating
from
    cte_rnk
where
    rnk > 1
order by
    hotel desc,
    year;
