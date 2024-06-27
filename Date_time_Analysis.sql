create table call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into call_start_logs values
('PN1','2022-01-01 10:20:00'),('PN1','2022-01-01 16:25:00'),('PN2','2022-01-01 12:30:00')
,('PN3','2022-01-02 10:00:00'),('PN3','2022-01-02 12:30:00'),('PN3','2022-01-03 09:20:00')
create table call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into call_end_logs values
('PN1','2022-01-01 10:45:00'),('PN1','2022-01-01 17:05:00'),('PN2','2022-01-01 12:55:00')
,('PN3','2022-01-02 10:20:00'),('PN3','2022-01-02 12:50:00'),('PN3','2022-01-03 09:40:00')
;


select * from call_start_logs;
select * from call_end_logs;
with st_rank as(
select phone_number,start_time,ROW_NUMBER()over(partition by phone_number order by start_time) as ph_st_rank from call_start_logs),end_rank as(
select phone_number,end_time,ROW_NUMBER()over(partition by phone_number order by end_time) as ph_end_rank from call_end_logs)

select s.phone_number,s.start_time,e.end_time,DATEDIFF(minute,  s.start_time,e.end_time) as duration  from st_rank s join end_rank e on s.ph_st_rank=e.ph_end_rank and s.phone_number=e.phone_number
---can be solved using window+union

select phone_number,min(call_time)as start_time,max(call_time) as end_time ,datediff(MINUTE,min(call_time),max(call_time)) from( 
select phone_number,start_time as call_time,ROW_NUMBER()over(partition by phone_number order by start_time) as rn from call_start_logs
union all
select phone_number,end_time as call_time,ROW_NUMBER()over(partition by phone_number order by end_time) as rn from call_end_logs)t
group by phone_number,rn

