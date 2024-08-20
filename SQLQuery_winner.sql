select * from players;
select * from matches;

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')
with rnk_state as(
select *,rank()over(partition by state order by date_value)-row_number()over(order by date_value) as diff from tasks)

select state,max(date_value) as end_date ,min(date_value) as start_date from rnk_state
group by diff,state

