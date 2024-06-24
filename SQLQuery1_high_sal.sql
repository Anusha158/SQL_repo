-->Highest and lowest salary from each department

select  * from employee2;


with high_sal as(
select emp_name,dep_id,rank()over(partition by dep_id order by salary) as min_sal,rank()over(partition by dep_id order by salary desc) as max_sal
from employee2
)

select dep_id,
max(case when min_sal=1 then  emp_name else NULL end) as emp_min_sal,
max(case when max_sal=1 then  emp_name else NULL end) as emp_max_sal
from high_sal
group by dep_id


