select * 
from ( SELECT car from footer where car is not null order by id desc limit 1 ) car
cross join ( SELECT length from footer where length is not null order by id desc limit 1 ) length
cross join ( SELECT width from footer where width is not null order by id desc limit 1 ) width
cross join ( SELECT height from footer where height is not null order by id desc limit 1 ) height;