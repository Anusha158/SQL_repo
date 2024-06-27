drop table input
create table input (
id int,
formula varchar(10),
val int
)
insert into input values (1,'1+4',10),(2,'2+1',5),(3,'3-2',40),(4,'4-1',20);
select * from input;

with cte as(
select *, LEFT(formula,1) as d1_val,RIGHT(formula,1)as d2_val,SUBSTRING(formula,2,1) as o
from input)

select c.id,c.val,i1.val as d1,i2.val as d2,c.o,i1.formula,
case when o='+' then i1.val+i2.val else i1.val-i2.val end as new_val
from cte c
join input i1   on c.d1_val=i1.id
join input i2  on c.d2_val=i2.id