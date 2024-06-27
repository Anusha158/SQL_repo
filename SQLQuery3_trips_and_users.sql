
--Leetcode Hard Problem | Complex SQL 7 | Trips and Users

select * from Trips;
select * from users;




select count(*) as unbanned_users,round(sum(case when t.status!='completed' then 1 else 0 end)* 1.0  /count(*),2) as cancellation_rate,t.request_at
from Trips t
join users u on t.client_id=u.users_id and u.banned='No'
join users u1 on u1.users_id=t.driver_id and u1.banned='No'
where t.request_at  between '2013-10-01' and '2013-10-03'
group by t.request_at 

--Tip:integer div integer give nearest integer 0 hence multiply by decimal to get value
