/*find order value for each sales person and order details without using temp,CTE or rank functions*/

select a.salesperson_id,a.order_number,a.order_date,a.cust_id,a.amount
from [int_orders]  a  join [int_orders]  b on a.salesperson_id=b.salesperson_id
group by a.salesperson_id,a.order_number,a.order_date,a.cust_id,a.amount
having a.amount>=max(b.amount)

select * from [int_orders];