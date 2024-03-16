-- query 1 for employee transaction table
insert into
    emp_transaction
select
    emp_id,
    emp_name,
    trns_type,
    round(base_salary * (percentage / 100), 2) as amount
from
    salary
    cross join (
        select
            income as trns_type,
            (cast(percentage as decimal)) as percentage
        from
            income
        union
        select
            deduction as trns_type,
            (cast(percentage as decimal)) as percentage
        from
            deduction
    ) x;

-- create this extension to use crosstab
create extension tablefunc;

-- query 2 for final result
select
    employee,
    basic,
    allowance,
    others,
    (basic + allowance + others) as gross,
    insurance,
    health,
    house,
    (insurance + health + house) as total_deduction,
    (
        (basic + allowance + others) - (insurance + health + house)
    ) as net_pay
from
    (
        select
            *
        from
            crosstab(
                'select emp_name, trns_type, amount from emp_transaction order by emp_name, trns_type',
                'select DISTINCT trns_type from emp_transaction order by trns_type'
            ) as result(
                employee varchar,
                allowance numeric,
                basic numeric,
                health numeric,
                house numeric,
                insurance numeric,
                others numeric
            )
    ) x;
