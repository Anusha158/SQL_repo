--seat that are empty and contionous more tha 3
select * from bms
where seat_no between 1 and 5

with cte as(
select *,seat_no-row_number()over(partition by is_empty order by seat_no)as rn from bms
where is_empty='Y'),c_rn as(

select rn,count(rn)as cnt_continous_seat
from cte 
group by rn 
having count(rn)>=3)

select seat_no
from cte c join c_rn cr on c.rn=cr.rn


---Advance aggregation
select * from(
select *,
sum(case when is_empty='Y'then 1 else 0 end) over(order by seat_no rows between 2 preceding  and current row) as prev_2,
sum(case when is_empty='Y'then 1 else 0 end) over(order by seat_no rows between current row  and 2 following ) as prev_next_1,
sum(case when is_empty='Y'then 1 else 0 end) over(order by seat_no rows between 1 preceding  and 1 following )as next_2
 from bms) a
 where a.prev_2=3 or a.prev_next_1=3 or a.next_2=3

