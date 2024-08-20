
select * from billings;

select * from  HoursWorked ;
select emp_name,  bill_date as bill_st_date,lead(bill_date)over(partition by emp_name order by bill_date) as new_bill_date ,bill_rate from billings;

with cte as(
select emp_name,  bill_date as bill_st_date,isnull(lead(bill_date)over(partition by emp_name order by bill_date),'9999-12-31') as new_bill_date ,bill_rate from billings)

select c.emp_name,sum(c.bill_rate*h.bill_hrs) as emp_payment
from cte c join HoursWorked h on
c.emp_name=h.emp_name and h.work_date   between c.bill_st_date and c.new_bill_date
group by c.emp_name