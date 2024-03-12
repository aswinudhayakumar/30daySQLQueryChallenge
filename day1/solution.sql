With cte as (
    Select
        *,
        case
            when brand1 < brand2 then concat(brand1, brand2, year)
            else concat(brand2, brand1, year)
        end as pair_id
    from
        brands
),
cte_rn as (
    SELECT
        *,
        ROW_NUMBER() over (
            partition by pair_id
            ORDER by
                pair_id
        ) as rn
    from
        cte
)
SELECT
    brand1,
    brand2,
    year,
    custom1,
    custom2,
    custom3,
    custom4
from
    cte_rn
WHERE
    rn = 1
    or (
        custom1 != custom3
        or custom2 != custom4
    );
