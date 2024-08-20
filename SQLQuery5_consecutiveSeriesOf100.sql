with cte as(
select *,id-ROW_NUMBER()over(order by visit_date) as grp from stadium
where no_of_people>100

),cte3 as(

select  grp from cte
group by grp
having count(*)>3)

select s.id,s.visit_date,s.no_of_people from cte s   join cte3 c on s.grp=c.grp


