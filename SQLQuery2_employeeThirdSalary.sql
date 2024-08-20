--employee with 3rd highest salary if less than 3 then lowest salary

with cte as(
select *,DENSE_RANK()over(partition by dep_id order by salary desc) as rn ,count(emp_id)over(partition by dep_id ) as cnt 
from emp3)

select emp_id,emp_name,salary,dep_id,dep_name from cte where rn=3 or rn<3 and rn=cnt




