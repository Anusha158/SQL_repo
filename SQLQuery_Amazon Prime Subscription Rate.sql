select * from users;
select * from events;
--users who joined music and got prime subscription within 30 days of join date
with get_prime_music as(
select *
from events
where  type='Music' 
),num_prime as(
select sum(case when e.type='P'  then 1 else 0 end) as num_p
from get_prime_music g join events e on g.user_id=e.user_id 
 join users u on  g.user_id=u.user_id 
where datediff(day,u.join_date,e.access_date)<=30
)
select cast (num_p as float)/cast((select count( user_id) from get_prime_music) as float)
from num_prime
