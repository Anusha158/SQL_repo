select * from students1

--write sql query to get list of students scored above the average marks in each subject
with cte as(
select subject,avg(marks)as avg_marks from students1
group by subject
)

select *
from students1 s join cte c on c.subject=s.subject and
s.marks>c.avg_marks

---write a SQL query to get % of students who score more than 90 in any subject amongst the total students

--select round(100*cast (count(*) as float)/(select count(*)from students1),2)as per_student_grt90 from students1
--group by studentid
select round(100*cast (count(distinct studentid)as float)/(select count(distinct studentid) from students1),2) as per_student_grt90 from students1
where marks>90

--second highest and second lowest marks for each subject
with cte as(
select *,rank()over(partition by subject order by marks desc) from_highest,
rank()over(partition by subject order by marks ) from_lowest from students1
)

select subject,
min(case when from_highest=2 then marks else null end) as second_highest,
min(case when from_lowest=2 then marks else null end) as second_lowest
from cte
group by  subject


---For each student in testdate and subject ,identify if marks increased or decreased from previous test.
with cte as(
select *,lag(marks,1)over(partition by studentid order by testdate,subject) as prev_marks from students1

)

select *,
case when marks>prev_marks then 'inc'
when marks<prev_marks then 'dec'
else null end as status
from cte



 




