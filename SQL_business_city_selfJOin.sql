create table business_city (
business_date date,
city_id int
);
delete from business_city;
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);



with cte as(
select datepart(year from business_date) as year_val ,city_id from business_city)

select b1.year_val ,count(*) as new_city
from cte b1 left join cte b2 on b1.city_id=b2.city_id  and
b1.year_val>b2.year_val
where b2.city_id is null
group by b1.year_val 