select
    test_id,
    marks
from(
        select
            *,
            lag(marks, 1, marks) over(
                order by
                    test_id
            ) as previous_marks
        from
            student_tests
    ) x
where
    x.marks > x.previous_marks;