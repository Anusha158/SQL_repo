/*Login or on time && off time 
10:01	on
10:02	on
10:03	on
10:04	off
10:07	on
10:08	on
10:09	off
10:11	on
10:12	off

output
login logout cnt
10:01	10:04	3
10:07	10:09	2
10:11	10:12	1
*/

select * from event_status;

with cte as(
select * ,lag(status)over(order by event_time) as prev_status
from event_status),group_key  as(

select * ,
sum(case when status='on' and prev_status='off' then 1 else 0 end)over(order by event_time) as grouping_status
from cte)

select min(event_time) as login_time ,max(event_time) as logot_time,count(*)-1 as cnt
from group_as
group by grouping_status