----- group by used to group data in a table.. It was introduced since we could not use 
--where clause in sql server
use [BikeStores]
select customer_id,first_name from [sales].[customers]
group by customer_id,first_name

select * from [sales].[orders]
select  distinct customer_id,order_status from [sales].[orders]
where customer_id in ( 2,8)
group by customer_id,order_status
order by customer_id asc


select city,state,COUNT(customer_id) customer_Count from sales.customers
group by city,state
order by city

select b.brand_name,Max(p.list_price) Max_Price,Min(p.list_price) Min_Price from [production].[brands] b
inner join [production].[products] as p 
on b.brand_id=p.brand_id
where p.model_year= 2018
Group by b.brand_name
order by b.brand_name

select b.brand_name,Avg(p.list_price) Avg_Price from [production].[brands] b
inner join [production].[products] as p 
on b.brand_id=p.brand_id
where p.model_year= 2018
Group by b.brand_name
order by b.brand_name

select b.brand_name,Sum(p.list_price) Max_Price,Min(p.list_price) Min_Price from [production].[brands] b
inner join [production].[products] as p 
on b.brand_id=p.brand_id
where p.model_year= 2018
Group by b.brand_name
order by b.brand_name

select order_id,sum(quantity*list_price *(1-discount)) as net_value 
from [sales].[order_items] 
group by order_id

--HAVING was introduced since we cannot have have where clause together with our where 
--clasue

select distinct customer_id, YEAR(order_date) Model_Year,Count(order_id) order_Total from [sales].[orders]
group by customer_id, YEAR(order_date) 
having Count(order_id)<2
order by customer_id

select order_id, sum(quantity*list_price*(1-discount)) Total_net from sales.order_items
group by order_id
having sum(quantity*list_price*(1-discount))>2000
order by order_id asc

select product_id, MAX(list_price) as max_price, Min(list_price) as min_price 
from production.products
group by product_id
having MAX(list_price) >4000 or Min(list_price)<500
order by product_id asc

select product_id,Avg(list_price) Item_List_Price from production.products
group by product_id
having Avg(list_price) between 500 and 700

select round(9.5,2)

--select a.brand_id,a.brand_name, b.product_id,b.model_year from [production].[brands] as a



--use [BikeStores]

--Between it used to show range of data 
select * from [production].[products]
where brand_id between 2 and 4


select * from  sales.orders
where order_date between '2016-01-01' and '2017-01-01'

--Like is used to show data in a pattern
select customer_id, first_name,last_name, city, state from [sales].[customers]
where city like 'Ca%'

--- The code above will show all the data that starts with Ca

--if we want all the data tha ends with ca we will use the % at the 
--begining of the character

select  customer_id, first_name,last_name, city, state from [sales].[customers]
where city like '%Ca'

--if we want to look at any city that has Ma in between we can go ahead and 
--use the %% to sandwich the data
--i.e

select  customer_id, first_name,last_name, city, state from [sales].[customers]
where city like '%ma%'

--if we want to look at  second charcter we can go ahead and use underscore _
select  customer_id, first_name,last_name, city, state from [sales].[customers]
where city like '_c%'

--Alias --- it used to show the Temporary names given to columns to avoid queried 
--nameless columns
select store_id, sum(product_id*quantity) from[production].[stocks]
group by store_id

--the code above does not have column name all we are going to do is to go ahead and give it an
--Alias so that we can have  a column name on our Aggregated Column

select store_id, sum(product_id*quantity) Total_sales from[production].[stocks]
group by store_id

select  customer_id, first_name+' '+last_name as Fullname, city, state from [sales].[customers]

--A join is used to Combine data from various sources(Tables).
--In Msql Serve we have various types of Join
--inner Join
--Right Join
--Left Join
--Full Join

--Inner Join--- Used to combine data that are unique from both tables
select p.category_id,p.product_name,p.category_id,b.brand_name from [production].[products]as p
inner join [production].[brands] as b
on p.brand_id=b.brand_id

--When the code above will be executed, it will return matching data that is in [production].[brands]
-- and [production].[brands] the unmatched data wont be retrieved

--Left Join-- Used to return the matching data from both tables in The right and Left and all the data
--from left that are not in the right


select p.category_id,p.product_name,p.category_id,b.brand_name from [production].[products]as p
Left outer join [production].[brands] as b
on p.brand_id=b.brand_id

select p.category_id,p.product_name,p.category_id,b.brand_name from [production].[products]as p
Right  join [production].[brands] as b
on p.brand_id=b.brand_id
where b.brand_name <> 'Electra' or b.brand_name <> 'Haro'


--Full Join is used to return  a concatendated data from from all the tables
--involved
select p.category_id,p.product_name,p.category_id,b.brand_name from [production].[products]as p
Full Join [production].[brands] as b
on p.brand_id=b.brand_id


--A self Join-- Used to join the tables with in itself. Its used to retrieve the data
--from its own tables
use BikeStores
select s1.store_id,s1.staff_id,s1.first_name,s1.last_name,s2.manager_id from [sales].[staffs]as s1
inner join[sales].[staffs]as s2
on s1.staff_id=s2.staff_id

--A cross join is used to concatenate data from one are more tables

select s1.*,s2.store_id,s2.store_name,s2.phone,s2.email,s2.street,s2.zip_code,s2.city,s2.state from[sales].[staffs] s1
cross join [sales].[stores] s2
--where s1.store_id= s2.store_id


--groUp By is used to filter data in the query and it mostly work with the 
--Aggreated Functions like MAX,MIN,SUM,AVG COUNT ETC
select p.product_id,p.product_name,Max(p.list_price) Maximum_price_of_Items 
from [production].[products] p
where p.list_price <500
group by p.product_id,p.product_name 

select distinct (count(c.customer_id) )Total_Customers,c.first_name,c.last_name,c.zip_code,c.state from[sales].[customers] c
group by c.first_name,c.last_name,c.state,C.zip_code

--Having clause is used to filter data since we cant have a where clause with
--having
select s.customer_id,Year(s.order_date) order_Year,count(s.order_id) as Total_Order from sales.orders s
group by s.customer_id,Year(s.order_date) 
having count(s.order_id) >2

select o.order_id,sum(o.quantity*o.list_price*1-o.discount) Net_Value 
from sales.order_items o
Group by O.order_id
Having sum(o.quantity*o.list_price*1-o.discount)<2000
order by  Net_Value desc

select so.order_id, Avg(so.quantity*so.list_price*1-so.discount) Net_Value 
from sales.order_items so
Group by So.order_id
having Avg(so.quantity*so.list_price*1-so.discount)>2000
order by Net_Value

--We can use Max and Min to find the max price and min price respectively

select p.category_id, Max(p.list_price)Max_Price, Min(p.list_price)Min_Price 
from production.products p
group by p.category_id
having Max(p.list_price) > 400 and Min(p.list_price)<500 
order by category_id


--we can use to populate data and group it by sets

select pb.brand_name,pc.category_name,pp.model_year,
Round(
Sum(s.quantity*s.list_price*(1-s.discount)),0) Sales into Sales_Summery 

from sales.order_items s
inner join  production.products pp
on s.product_id=pp.product_id
inner join production.brands pb
on pp.brand_id=pb.brand_id
inner join  production.categories pc
on  pp.category_id=pc.category_id
group by 
pb.brand_name,pc.category_name,pp.model_year
order by 
pb.brand_name,pc.category_name,pp.model_year asc

use BikeStores
-- We can go ahead and use  our Created table(Sales_Summery) to retriev data
select * from Sales_Summery
-- We can go ahead and group our data using the Group Set
select distinct(ss.brand_name),ss.category_name,ss.model_year from Sales_Summery ss
Group by ss.brand_name,ss.category_name,ss.model_year 
order by ss.brand_name,ss.category_name,ss.model_year asc

--or
select s.brand_name,s.category_name,s.model_year,SUM(s.sales) Total_Sales 
from Sales_Summery S
Group by  s.brand_name,s.category_name,s.model_year
Having SUM(s.sales)>9000
order by s.brand_name asc

--we can use the Group set with the Mathematical aggregate functions
select s.brand_name,s.category_name,s.model_year,Avg(s.sales) Total_Sales 
from Sales_Summery S
Group by  s.brand_name,s.category_name,s.model_year
Having Avg(s.sales)<5000
order by s.brand_name asc

--we can group the set of data after knowing the Max values

select s.brand_name,s.category_name,s.model_year,Max(s.sales) Total_Sales 
from Sales_Summery S
Group by  s.brand_name,s.category_name,s.model_year
Having Max(s.sales)>5000
order by s.brand_name asc

--we can group the set of data after knowing the Min values
select s.brand_name,s.category_name,s.model_year,MIN(s.sales) Total_Sales 
from Sales_Summery S
Group by  s.brand_name,s.category_name,s.model_year
Having MIN(s.sales)<5000
order by s.brand_name asc

--Instead of using the Group to filter multiple records we can go ahead and use the Cube
--a cube is  a subclause of group we can use it as Group by but it will group the data in one 
--set under Cube Method

select s.brand_name,s.category_name,s.model_year,MIN(s.sales) Total_Sales 
from Sales_Summery S
Group by 
Cube(  s.brand_name,s.category_name,s.model_year)
Having MIN(s.sales)<5000
order by s.brand_name asc


SELECT
s.brand_name,
s.category_name,
SUM (sales) sales
FROM
Sales_Summery s
GROUP BY
s.brand_name,
CUBE(s.category_name);


--If we want to group the data base on hierachy we can go ahead and use 
--RollUp. Just like Cube a Roll Up is a subclasue of Group By
select ss.brand_name,ss.category_name, SUM(ss.Sales) Total_Sales
from Sales_Summery ss
Group by 
Rollup (ss.brand_name,ss.category_name)
order by ss.brand_name,ss.category_name asc

select ss.brand_name,ss.category_name, SUM(ss.Sales) Total_Sales
from Sales_Summery ss
Group by 
Cube (ss.brand_name,ss.category_name)
order by ss.brand_name,ss.category_name asc

select S.brand_name,S.category_name, SUM(S.Sales) from Sales_Summery S
Group by S.brand_name,
Rollup(S.category_name)

--Subquery--- A subquery is a Query that is written depending on other query for
--retrival of data. We can use it with select, update,Insert or Delete

----For instance lets say that we have this two kind of tables
--Sales.orders and Sales.customer
--For instance lets say that we want to know the customers who made order and from New york
--state.

--select sc. from sales.customers sc

--select so.order_id,so.order_date,so.customer_id from sales.orders so
--where so.customer_id IN( 
--select sc.customer_id 
--from 
--sales.customers sc
--where 
--sc.state = 'New York')
--order by 
--so.order_date desc

--SELECT order_id,order_date,customer_id
--FROM
--    sales.orders
--WHERE
--    customer_id IN (
--        SELECT
--            customer_id
--        FROM
--            sales.customers
--        WHERE
--            city = 'New York'
--    )
--ORDER BY
--    order_date DESC;

select so.order_id,so.order_date,so.customer_id 
from sales.orders so
where so.customer_id IN(
select  sc.customer_id from sales.customers sc
where sc.city= 'New York')
order by so.order_date DESC


--What happens with the Subquery is that the outer query normally depend on the in query
--query to get information. For instance the outer query in our case  sales.orders
--depends on v to gte all customer_id that made the order in sales.Orders and live 
--or fro New York city. This means that the first selcet is called outer query 
--while indepedent is called Inner query or subquery


--we can use Subquery on a single Table

select pp.product_name, pp.list_price  from[production].[products] pp
where pp.list_price >( Select AVG(list_price)  
from [production].[products] where brand_id in(
select brand_id from[production].[brands] 
WHERE
		brand_name = 'Strider'
	OR brand_name = 'Trek'))
order by list_price

SELECT product_name,list_price
FROM
production.products
WHERE
list_price > (
SELECT AVG (list_price)
FROM production.products
WHERE
brand_id IN (
	SELECT
		brand_id
	FROM
		production.brands
	WHERE
		brand_name = 'Strider'
	OR brand_name = 'Trek'
)
)
ORDER BY
list_price;


--With Subquery you can use it with logical expresion, Arithmetic operator etc

select so.order_id,so.order_date,
(select Max(soi.list_price) from [sales].[order_items]soi
where so.order_id=soi.order_id) as max_list_Price
from sales.orders so
order by so.order_date asc


---- Using Like with Subquery
select pp.product_id,pp.product_name from [production].[products] pp
where pp.category_id in 
( select pc.category_id 
from production.categories pc
where pc.category_name='Mountain Bike' 
and Pc.category_name='Road Bike')

SELECT
product_id,
product_name
FROM
production.products
WHERE
category_id IN (
SELECT
category_id
FROM
production.categories
WHERE
category_name = 'Mountain Bikes'
OR category_name = 'Road Bikes'
);


All used to compare scalar Subquaery

use [BikeStores]

select product_name,list_price from [production].[products]
where list_price > All (
SELECT
AVG (list_price) avg_list_price
FROM
production.products
GROUP BY
brand_id) order by list_price asc

select product_name, list_price from production.products
where list_price < all( 
SELECT AVG(list_price) avg_list_price
from[production].[products]  group by brand_id ) order by list_price asc

-- union is used to combine two, or more set of data.
--below is the syntaxt of UNION
SELECT COLUMN_1, COLUMN_2 FROM TABLE_NAME1
UNION
SELECT COLUMN_1 , COLUMN2 FROM TABLE_NAME1

--when dealing with union, always know that, number of 
--columns should always much if else and error will pop-up

--union-- is mostly used to combine one or more set of data and 
--doesn't include duplicates or redundant data

--union all will return  all set of data including the duplicates
select staff_id,first_name,last_name,store_id from [sales].[staffs]
union
select customer_id,first_name,last_name,city from [sales].[customers]
	
alter table [sales].[customers]
alter column city Varchar(23)


--INTERSECT--- used to return distict set of data from two diffrent tables.
select city from sales.stores
intersect
select city from 
sales.customers

--this column will return only the matching city that are in both s.stores and s.customer

EXCEPT --- It's used to return distinct from left table and matching data 
select city from sales.stores
EXCEPT
select city from sales.customers

select product_id from production.products
EXCEPT 
select product_id from [sales].[order_items]

CTE --- THIS STANDS FOR COMMON TABLE EXPRESSION

select sc.customer_id,sc.first_name,sc.last_name,sc.city, so.order_id,so.order_date,so.shipped_date from [sales].[customers] sc
inner join [sales].[orders] so
on sc.customer_id=so.customer_id
--once we are done with this we can go ahead and load our query inside our  cte

WITH  CTE_customerOrders
as 
(
select sc.customer_id,sc.first_name,sc.last_name,sc.city, so.order_id,so.order_date,so.shipped_date from [sales].[customers] sc
inner join [sales].[orders] so
on sc.customer_id=so.customer_id
) select * from CTE_customerOrders


with CTE_CUSTOMERS
AS (
select  so.first_name,so.last_name,so.city,so.state, Year(s.order_date) as year_shipped, Sum(quantity*list_price*1-discount) Total_sale
from sales.order_items si
inner join  [sales].[orders]s on si.order_id= s.order_id 
inner join [sales].[customers] so
on so.customer_id=s.customer_id
group by  so.first_name,so.last_name,so.city,so.state,Year(s.order_date)
) SELECT * FROM CTE_CUSTOMERS
WHERE year_shipped =2018
with  Total_sales
as 
(
select s.order_id, so.customer_id,sum(s.list_price*s.quantity*(1-s.discount) 
) Total_sales from [sales].[order_items] s 
inner join [sales].[orders] so
on s.order_id=so.order_id
group by s.order_id,so.customer_id
)
select * from Total_sales

INSERT --- its used to insert data into the  various columns or tables

in sql server there are various ways to loeasd data inside a table, column or tables 
in  diffrent Sever or database.

use [dummy_database]
create  table salespromotion
(
	
promtion_name varchar(90),
discount  numeric (3,2),
start_date varchar(50),
expire_date varchar(50)
)

select * from salespromotion

--the above query shows that table is empty. For us  to have some
--data in it , we need to go ahead and load some data.

insert  into salespromotion (
promtion_name ,
discount  ,
start_date ,
expire_date ) values
(
'2018 Summer Promotion',
0.15,
'20180601',
'20180901')

select * from salespromotion


--since we have inserted the values in out table, we need to capture the
--inserted values or data

insert into salespromotion
(
promtion_name ,
discount  ,
start_date ,
expire_date
)output inserted.promtion_name
values( '2018 Summer Promotion',
0.15,
'20180601',
'20180901')

--to caputer inserted data from columns, we can go a head and code this

insert into salespromotion (
promtion_name ,
discount  ,
start_date ,
expire_date) output inserted.promtion_name,
inserted.discount,
inserted.start_date,
inserted.expire_date
values( '2018 Summer Promotion',
0.15,
'20180601',
'20180901')


alter table salespromotion
add   promotion_id  int
insert into salespromotion( promotion_id) values(4)

update salespromotion
set promotion_id= 4
where promtion_name= '2018 Summer Promotion'

SELECT * FROM salespromotion

delete from salespromotion
where start_date !=20180601


------- Beide that, there are some other ways in which one can go ahead and insert data into 
----a table 
--ie lets create a table for this case.

create  table salesstores_Copy 
(
store_id int,
store_name varchar(90),
phone varchar(90),
email varchar(150),
street varchar(90),
city varchar(90),
state varchar(90),
zip varchar(90)
)
--once we have created the table we can go head and load the data into the 
--table we have created.

insert into  salesstores_Copy( store_id ,
store_name ,
phone ,
email ,
street ,
city ,
state ,
zip) select * from [sales].[stores]


--once the code above will be created, all the data or the specified colum will be loaded into 
--salesstores_Copy

select * from salesstores_Copy
select * from [sales].[stores]

--we can load data into the new table using the same criteria 
--but this time we dont have to create a table to load data inside it 
insert  into salesstores_Copy (
store_id, store_name,phone,email,street,city,state,zip) 
select store_id, store_name,phone,email,street,city,state,zip_code from 
[sales].[stores] 


select store_id, store_name,phone into salesstores_Copy
from [sales].[stores]
where store_id =2

--sometime we may make some errors and we would like to make some
--chnaged in order to do that, we can go ahead and use UPDATE,
--below is the syntax for update


--update table_name
--set column_1,column_2,column_3
--where= condtion

select * from salesstores_Copy
we can go ahead and make some change son this table 

update salesstores_Copy
set store_name = 'cvs', phone='714-561-6700',email='yojazuna@gmail.com',street='8613 rainer',
state='Wa', zip='89701'
Where store_id= 3

--when the code above will be executed, the date specified at 
--the where clause will be changed

select * from salesstores_Copy

--since we had duplicates inside our data, we can go ahead and 
--note that, two set of data will be changed.

use dummy_database

CREATE TABLE salestaxes (
tax_id INT PRIMARY KEY IDENTITY (1, 1),
state VARCHAR (50) NOT NULL UNIQUE,
state_tax_rate DEC (3, 2),
avg_local_tax_rate DEC (3, 2),
combined_rate AS state_tax_rate + avg_local_tax_rate,
max_local_tax_rate DEC (3, 2),
updated_at datetime
)
select * from salestaxes

INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Alabama',0.04,0.05,0.07);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Alaska',0,0.01,0.07);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Arizona',0.05,0.02,0.05);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Arkansas',0.06,0.02,0.05);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('California',0.07,0.01,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Colorado',0.02,0.04,0.08);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Connecticut',0.06,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Delaware',0,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Florida',0.06,0,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Georgia',0.04,0.03,0.04);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Hawaii',0.04,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Idaho',0.06,0,0.03);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Illinois',0.06,0.02,0.04);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Indiana',0.07,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Iowa',0.06,0,0.01);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Kansas',0.06,0.02,0.04);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Kentucky',0.06,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Louisiana',0.05,0.04,0.07);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Maine',0.05,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Maryland',0.06,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Massachusetts',0.06,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Michigan',0.06,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Minnesota',0.06,0,0.01);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Mississippi',0.07,0,0.01);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Missouri',0.04,0.03,0.05);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Montana',0,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Nebraska',0.05,0.01,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Nevada',0.06,0.01,0.01);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('New Hampshire',0,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('New Jersey',0.06,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('New Mexico',0.05,0.02,0.03);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('New York',0.04,0.04,0.04);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('North Carolina',0.04,0.02,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('North Dakota',0.05,0.01,0.03);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Ohio',0.05,0.01,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Oklahoma',0.04,0.04,0.06);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Oregon',0,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Pennsylvania',0.06,0,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Rhode Island',0.07,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('South Carolina',0.06,0.01,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('South Dakota',0.04,0.01,0.04);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Tennessee',0.07,0.02,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Texas',0.06,0.01,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Utah',0.05,0,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Vermont',0.06,0,0.01);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Virginia',0.05,0,0);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Washington',0.06,0.02,0.03);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('West Virginia',0.06,0,0.01);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Wisconsin',0.05,0,0.01);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Wyoming',0.04,0.01,0.02);
INSERT INTO salestaxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('D.C.',0.05,0,0);

select * from salestaxes

--if the query above is executed, we will know that, updateed_at
--does not have a data in order to do that, we can go ahead and 
--update the column.

--Not that in the code below we will like to populate the entire column of updated_at
--in order to do that, we can go ahead an d
--use the this syntax with out the where clause which will affect only 
--a specified set of data

UPDATE salestaxes
SET  updated_at = GETDATE();

select * from  salestaxes

--in sql server we can go ahead and populate many columns

update salestaxes
set avg_local_tax_rate +=0.2, state_tax_rate +=0.4
where tax_id= 1

select * from salestaxes

--With update we can go ahead and use the  upate on join
use BikeStores

--select * from Sales_Summery 
update [sales].[customers]
set first_name= 'Geovani'
from [sales].[customers] c
inner join [sales].[orders] o
on c.customer_id= o.customer_id
where c.customer_id =9

select * from sales.customers
where customer_id=9

--sometimes let say that we dont have a dont want some data and we really want to get rid of it
--in order to do that, we can go ahead and delete it

--syntax for delete

--delete  from table_name
--where column= condition

select * from Sales_Summery
where model_year= 2016

delete from Sales_Summery
where model_year= 2016

--when this query below will be executed, the will be no
--out put since all the data of 2016 will be deleted.

--we can delete some percentile of data 

select * into
salescustomers_sample 
from
[sales].[customers]

select * from salescustomers_sample

--let say that we want to delete top 5 of the data in salescustomers_sample
--for us to that, we can go ahead and code this by following the syntax

--delete top (N) from Table_name

delete top (25) percent  from salescustomers_sample

select *from salescustomers_sample


use dummy_database

create table EmployeeDetails
(
EmpId int ,
FullName varchar(80),
ManagerId int,
DateOfJoining varchar(90),
City varchar(90)
)

insert into EmployeeDetails (EmpId,FullName,ManagerId,DateOfJoining,City)
values (121,	'John Snow',	'321',	'01/31/2019','Toronto'),
(321,'Walter White',	'986',	'01/30/2020',	'California'),
(421,	'Kuldeep Rana',	'876',	'27/11/2021',	'New Delhi')


create table EmployeeSalary
(
EmpId int,
Project varchar(12),
Salary money,
Variable int)

alter table EmployeeSalary
alter column Variable int

insert into EmployeeSalary(EmpId,Project,Salary,Variable) values(121,'P1',	8000,	500),
(321,'P2',10000,1000),
(421,'P1',	12000,	0)


select * from EmployeeDetails
select * from EmployeeSalary


--By using EmployeeDetails and EmployeeSalary Tables, go ahead and solve 
--this problems shown below.

--Question 1: Write an SQL query to fetch the EmpId and FullName of all the employees 
--working under the Manager with id – ‘986’.

select EmpId,FullName from EmployeeDetails
where ManagerId=986

--Question 2: Write an SQL query to fetch the different projects available from 
--the EmployeeSalary table.
select distinct project from EmployeeSalary

--Question 3: Write an SQL query to fetch the count of employees working in project ‘P1’.
select count(EmpId)Number_of_Employees_working_on_Projects from EmployeeSalary
where Project= 'p1'

--lets try the count(*)

select count(*)Number_of_Employees_working_on_Projects from EmployeeSalary
where Project= 'p1'

use dummy_database
--Question 4: Write an SQL query to find the maximum, minimum, 
--and average salary of the employees.
select MAX(Salary) Maximum_Salary,Min(Salary) Average_Salary,
MAX(Salary) Average_Salary
from EmployeeSalary

--Question.5. Write an SQL query to find the employee id whose salary lies 
--in the range of 9000 and 15000.

select EmpId, Salary from EmployeeSalary
where Salary between  9000 and 15000 

--Question.6. Write an SQL query to fetch those employees who live in Toronto 
--and work under the manager with ManagerId – 321.
select * from EmployeeDetails
where City='Toronto'
and ManagerId=321

--Question.7. Write an SQL query to fetch all the employees who either live in California or 
--work under a manager with ManagerId – 321.
select * from EmployeeDetails
where City='California' or  ManagerId=321

--Question.8. Write an SQL query to fetch all those employees who work on Projects 
--other than P1.

select * from EmployeeSalary
where Project != 'P1'
--OR 

SELECT EmpId
FROM EmployeeSalary
WHERE NOT Project='P1';

--or 

select * from EmployeeSalary
where Project <> 'P1'

--Question.9. Write an SQL query to display the total salary of each employee adding the
--Salary with Variable value.
select Salary + Variable total_salary 
from EmployeeSalary

--Question.10. Write an SQL query to fetch the employees whose name begins with any 
--two characters, followed by a text “hn” 
--and ends with any sequence of characters.

select EmpId, FullName from EmployeeDetails
where FullName like '__hn%'

----Question.11. Write an SQL query to fetch all the EmpIds which are present in either 
--of the tables 
----– ‘EmployeeDetails’ and ‘EmployeeSalary’.

select EmpId from EmployeeSalary
union
select EmpId from EmployeeDetails

select e.EmpId from EmployeeDetails as E
inner Join EmployeeSalary as S
on E.EmpId= S.EmpId


--Question: 12 Write an SQL query to fetch common records between two tables.
--Ans. SQL Server – Using INTERSECT operator-
select * from EmployeeDetails
intersect
select * from  EmployeeSalary


select * from EmployeeDetails
MINUS
select * from 

--use dummy_database
--Question.14. Write an SQL query to fetch the EmpIds that are present in both the tables –   
--‘EmployeeDetails’ and ‘EmployeeSalary.
select * from EmployeeDetails
where EmpId in ( select EmpId from EmployeeSalary)

------Question.15. Write an SQL query to fetch the EmpIds that are present in 
--EmployeeDetails but 
----not 
----in EmployeeSalary.
select Empid from EmployeeDetails
where EmpId NOT IN ( select EmpId from EmployeeSalary )


--Ques.16. Write an SQL query to fetch the employee’s 
--full names and replace the space with ‘-’.
select Replace(FullName,'','-') from EmployeeDetails


--Question.17. Write an SQL query to fetch the position of a given character(s) in a field.
select INSTR(FullName,'Snow') from EmployeeDetails

--Question 18: Write an SQL query to display both the EmpId and ManagerId together.
select concat(EmpId,ManagerId) employee_and_ManagerId from EmployeeDetails

--below code is diffrent from the one above. This is because, when one concatinate two data ,
--he or she is enjoining two data  but (+) is the process of summing the data up

select empid+managerid from EmployeeDetails

--Question 19. Fetch all the employees who are not working on any project.
select e.FullName,e.FullName,s.Project from EmployeeDetails e
inner join EmployeeSalary s
on e.EmpId=s.EmpId
where Project = NULL

--We can go ahead and code the project this way 


SELECT EmpId 
FROM EmployeeSalary 
WHERE Project IS NULL;
--Question 20--Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and 
----less 
--than or equal to 10000.
select e.EmpId,e.FullName from EmployeeDetails e
where e.EmpId in( select s.EmpId from EmployeeSalary s
where s.Salary >= 5000 or s.Salary<= 10000)

--on the code above we can use SubQuery or inner join and it will give us all the data needed

select e.EmpId,e.FullName, s.Salary from EmployeeDetails e
inner join EmployeeSalary s
on e.EmpId=s.EmpId
where s.Salary >= 5000 or s.Salary<= 10000

--Question 20: Write an SQL query to find the current date-time.
select GETDATE()

--Question 21: Write an SQL query to fetch all the Employee details from the EmployeeDetails 
--table 
--who joined in the Year 2020.
select EmpId,FullName,DateOfJoining from EmployeeDetails
where DateOfJoining=(select Convert(datetime,DateOfJoining,103)from EmployeeDetails)


--Question 22:Write an SQL query to fetch all employee records from the EmployeeDetails table 
--who have a salary record 
--in the EmployeeSalary table.
select * from EmployeeDetails e
where  EXISTS ( Select * from EmployeeSalary s
where e.EmpId=s.EmpId)

----Question28. Write an SQL query to fetch the project-wise count of employees sorted by 
--project’s
----count in 
----descending order.

select Project,count(EmpId) count_Employee from EmployeeSalary
group by Project
order by count_Employee

--Question 29:
--Write a query to fetch employee names and salary records. Display the employee 
--details even if the salary record 
--is not present for the employee.
select e.EmpId,e.FullName,s.Salary from EmployeeDetails e
left join EmployeeSalary s
on e.EmpId=s.EmpId

--Question 30: Write an SQL query to join 3 tables.

select A.column_1,A.column_2,A.column_2,A.column_3,A.column_4,
B.column_1,A.column_2,A.column_2,
C.column_1,C.column_2,C.column_3 FROM TABLE_1 A
INNER JOIN TABLE_2 B
ON A.column_1= B.column_1
inner join TABLE_3 C
ON B.column_1=C.column_1

--Question. 31. Write an SQL query to fetch all the Employees who are also managers from 
--the EmployeeDetails table.
--in this case we will use a self join

select e.EmpId,e.FullName, e.ManagerId from EmployeeDetails e
inner join EmployeeDetails d
on e.EmpId=d.ManagerId
 
--we can use the subbquery to get the same output.

select * from EmployeeDetails as e
where EXISTS (select * from EmployeeDetails d
where e.empid=d.ManagerId)

--Question.32. Write an SQL query to fetch duplicate records from EmployeeDetails 
--(without considering the primary key – EmpId).
SELECT FullName, ManagerId, DateOfJoining, City, count(*) duplicate_count
FROM EmployeeDetails
GROUP BY FullName, ManagerId, DateOfJoining, City
HAVING count(*) <1


--Question.33. Write an SQL query to remove duplicates from a 
--table without using a temporary table.
delete A.column_1,A.column_2,A.column_2,A.column_3,A.column_4,
B.column_1,A.column_2,A.column_2,
C.column_1,C.column_2,C.column_3 from TABLE_1 A
where A.column_1>= B.column_1
where  B.column_1>=C.column_1

--use [BikeStores]

--Question.34. Write an SQL query to fetch only odd rows from the table.
select * from EmployeeDetails
where EmpId /2 =0

----Question.36. Write an SQL query to create a new table with data and structure copied 
--from another 
----table.
select * into  new_table_copy
from EmployeeDetails

select * from new_table_copy

--Question 37. Write an SQL query to create an empty table with the same structure as 
--some other table.
drop table new_table_copy
select * into  new_table_copy
from EmployeeDetails
where 1=0

select * from new_table_copy

--Question 38:Write an SQL query to fetch top n records.
select top(2) empid, fullname,city from EmployeeDetails

--Question.39. Write an SQL query to find the nth highest salary from a table.
SELECT TOP 1 Salary
FROM (
SELECT DISTINCT TOP 1 Salary
FROM EmployeeSalary
ORDER BY Salary DESC
) 
ORDER BY Salary ASC;


Create table sales_assistant
(
id int,
first_name varchar(90),
last_name varchar(90),
months int,
sold_products money

)

select * from sales_assistant

insert into sales_assistant(
id,	first_name,	last_name,	months,sold_products)
values(1,	'Lisa'	,'Black'	,5	,2300),
(2	,'Mary' ,'Jacob'	,5	,2400),
(3	,'Lisa'	,'Black',	6	,2700),
(4	,'Mary'	,'Jacobs'	,6	,2700),
(5	,'Alex','Smith'	,6,	2900),
(6	,'Mary'	,'Jacobs',7,1200),
(7,	'Lisa'	,'Black',	7	,1200),
(8,	'Alex',	'Smith',	7,	1000)


select * from sales_assistant
select RANK() over(partition by Months order by  sold_products DESC )as Ranks,
RANK() over(Partition by months order by sold_products desc ),
first_name, last_name,Months,sold_products
from sales_assistant


use AdventureWorks2017

select top(20) BusinessEntityID,Rate,
DENSE_RANK() over(order by rate desc) as rank_salary
from HumanResources.EmployeePayHistory

use dummy_database
create table employees_Salry
(
emp_name varchar(90),
salay money)

insert  into employees_Salry(emp_name,salay) 
Values('Abdimalik',31000),
('Isaack',24500),
('Rechel',35000),
('Manuel',28500),
('John',31500),
('Maureen',39800),
('Jose',51000)

select * from employees_Salry

whats the diffrence between dense rank and Rank...
They are both used to rank rows in the. The have  as slight diffrence
Rank---  numbers are skipped lets say of we have multiple data that have 1,1,1,1,
then, the rank will skipped the next value in the rank to 3 and not Two,

while with dense_rank its used to show rank in rows and rows are not skipped.
 
Below  are the synax for rank and dense_rank 


RANK OVER( PARTION_CLAUSE ORDER BY VALUE)

DENSE_RANK OVER( PARTITION_CLAUSE ORDER BY VALUE) 

create table student
(
STUDENT_ID int,
FIRST_NAME varchar(90),
LAST_NAME varchar(90),
FEES_PAID int,
GENDER varchar(90)
)

insert into student( STUDENT_ID,FIRST_NAME,LAST_NAME,FEES_PAID,GENDER)
values(5,	'Steven',	'Webber',	0,	'M'),
(10	,'Tanya','Hall',	50	,'F'),
(4	,'Mark',	'Holloway'	,100	,'M'),
(6	,'Julie','Armstrong',	150	,'F'),
(7	,'Michelle',	'Randall'	,150	,'F'),
(1,	'John', 'Smith'	,200,	'M'),
(3	,'Tom',	'Capper',	350,	'M'),
(2	,'Susan',	'Johnson',	500	,'F'),
(8,	'Andrew', 'Cooper'	,800,	'M'),
(9	,'Robert','Pickering'	,900	,'M')

select * from student

--lets we wan to get the top three students

select s.STUDENT_ID,s.FIRST_NAME,s.GENDER,
RANK() over( order by STUDENT_ID) as r
from student  




SELECT
product_id,
product_name,
list_price,
RANK () OVER ( 
ORDER BY list_price DESC
) price_rank 
FROM
production.products;


select product_id,
product_name,
list_price, DENSE_RANK() OVER( ORDER BY list_price asc )as price_rank  
	
from production.products
	
--in this case we  can go ahead and partition our data

select * from
(
select product_id,
product_name,
list_price, rank() OVER( PARTITION BY brand_id order by list_price asc)p_rank
from production.products
	
) t

where p_rank <3

use dummy_database

select * from (
select emp_name, salay, dense_rank() over( order by salay asc) salary_rank
from [dbo].[employees_Salry]) t
where salary_rank<=3


--Date function
select fullname, DAY(DateOfJoining) from [dbo].[EmployeeDetails]

SELECT DAY((GETDATE())) TODAYS_DATE

SELECT DATEPART(DAY,GETDATE())

SELECT EOMONTH(GETDATE())

--- WE CAN GO AHEAD AND WRITE SOME QUERY FOR DAT FUNCTION
select * from
(
select so.order_id,so.list_price, s.shipped_date ,
sum(so.list_price*so.quantity) gross_sales,
RANK() over(  order by shipped_date  asc ) date_rank
from [sales].[order_items] so
inner join sales.orders s
on so.order_id= s.order_id
where s.shipped_date is not null
and year(s.shipped_date) =2017
and month(shipped_date)=2
group by so.order_id,so.list_price, s.shipped_date
)
t date_rank=<3

select charindex('sql', 'sql server') sql_position

--we can use charindex with variable
declare @randomstring varchar(20)
select @randomstring= ' The team has been eliminated'
select charindex('been',@randomstring) been_postion

select * from EmployeeDetails
select charindex('snow', fullname) snow_postion from [dbo].[EmployeeDetails]
where Empid=121

--beside that we can go ahead and specify for a position when dealing with charindex

the syntax for this case will be 

select charindex('data_to_postion', 'where_the_data is from','Staring_postion')

select charindex('white',fullname,5) white_position from [EmployeeDetails]
where Empid=321

--concat--- concat is used to merge to set of data together
--it's  not diffrent from the concatination
select concat('John' ,' ' ,'doe') fullname

--let trie concatinate

select 'John' + 'doe'  fullname



select s.customer_id, concat (s.first_name,'_',s.last_name) full_name 
from sales.customers s
order by full_name asc


--in sql server we can go ahead and use the concat_ws.
--this is used to concatinate data but with a seperator

select s.customer_id,concat_ws (',',s.first_name,last_name ) fullname from sales.customers  s

char used t convert number to a char
select char(65) char_value


--LEFT --- This function is used to give number of characters from the left side.

select left('The game has ended',3)

select  right('hungry dog',3)

select p.product_id,left (p.product_name,7) first_sevencharacters
from production.products p
order by p.product_name

Len ---- This function is  mostly used to give us the length character of  a string 

select len(' The world cup is  over') string_length

select product_name,len(product_name) productname_lenght
from  production.products
order by  productname_lenght asc

--lower---- This function is mostly used to change the string from lower to upper
select lower('ABDIMALIK RASHID') lower_name

----upper-- This  function is used to change the name from lower to upper
select upper('abdimalik rashid ') Capitalized_name

select customer_id,concat_ws(',',lower(first_name),lower(last_name)) full_name from sales.customers
order by first_name,last_name asc

LTRIM ---- This function is used to retrun remove space from the left side.

select LTRIM(' THE DOG WAS INJURED') space_results

PATINDEX used to return a string position in a string  pattern
syntax for patindex 
select patindex( '%value%','string_values')

select customer_id,first_name, patindex('%br%',first_name) br_postion from sales.customers
where customer_id= 1


--Creating  a view

--whats  a view -----a view vitual table.

create view daily_sales
as 

select s.order_date, Month(s.order_date)order_Month,Day(s.order_date)order_day,
o.product_id, o.quantity*o.list_price as sales
from  sales.orders s
inner join sales.order_items o
on s.order_id=s.order_id


select * from daily_sales
order by order_day

a function---- A function is a block of code that execute a specific task.

create function fngGetFullname(
declare @firstname varchar(90),
declare @lastname varchar(90))

rteurn varchar(101)
as 
begin 
return (select @firstname + ''+ @lastname)

end 


------- SOLVED LEETCODE SQL SERVER QUESTIONS-----
-- Question: Write an SQL query to report the first name, last name, city, and state of each person in the Person 
-- table. If the address of a personId is not present in the Address table, report null instead.

--Return the result table in any order.

select p.firstName,p.lastname, a.city,a.state from Person p
left join Address a
on p.personId=a.personId


--Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, 
--the query should report null.

WITH CTE AS
	(SELECT Salary, RANK () OVER (ORDER BY Salary desc) AS RANK_desc
		FROM Employee)
SELECT MAX(salary) AS SecondHighestSalary
FROM CTE
WHERE RANK_desc = 2



--- Creating database in microsoft sql server-------

create database test_db

---- If one wants to know the number of database one has in the system
--one can go ahead and code this

select name from master.sys.database
order by name

------- anything that can be created can be deleted
--in sql server a table can be delete both manually or by query.

drop database if exists test_db

select ---- This is a command used to get some data  it acts like a fetcher.

--if we can go ahead and run the select command , an error will pop up. This is simply because
----the compiler needs to know what we are selecting. I.e
----if we want to select * from the table we can go ahead and use the (*) sysmbol or we can call it astericks.

use bikestores
select * from [sales].[customers] c
where c.first_name like'De%'
order by c.customer_id asc

---- sometimes, we use offset, Fetch instead of order by clause. Just like Order by clause, they will allow you to 
--limit number of record you want to fetch
select * from [production].[products]

--lets say we want to skip 10 rows in our dataset. we can go ahead and use the OFFSET
select * from production.products
offset 10 
---- when the above code will be executed, and error will be poping up since, we will be skippig data but we did't tell
--which data we will be skipping 
--- in the end of the clause we should always right the ROWS so that we can see what we want to skip.
select * from production.products
ORDER BY product_name asc
OFFSET 10 rows

--what the code above will do is that, it will be taking the first 10 rows and skip it. 


--For instance lets say that we need to skip the first 10 rows and select the next rows, we can go ahead and 
--use the offset and fetch next

select *from production.products
order by product_name asc
offset 10 rows
fetch next 10 rows only


instead of using the select top() from table_name.
we can go ahead and use the offset n rows
fetch next 10 rows only

select top 10 * from production.products

--lets see if we can archive the same objective by going ahead and using the 
--offset and OFFSET NEXT N ROWS ONLY

Select * from production.products
order by product_name asc
offset  0 rows
fetch next 10 rows only

--- we can use Distic to filter the data.
select distinct(city) from [sales].[customers]

----the code above will remove all the duplicates from our code. But on the other hand, we can go ahead and 
--remove some duplicates on some  multiples columns.
select distinct city,state from sales.customers

---- in sql we can always go ahead and group our distinct values.

select distinct city,state,zip_code from sales.customers
group by city,state,zip_code 
order by city,state,zip_code desc

----WHERE CLAUSE IS USED TO FILTER THE DATA BY GIVING A CONDITION
--NOTE: WE CANNOT USE THE WHERE AND GROUP BY

select product_id,product_name,model_year,list_price  from production.products 
where category_id=1 and model_year=2018
order by list_price desc

--sometimes we can go head and use the varibales and assign some values to it.

declare @product_category as int
declare @product_model_year as int

set @product_category= 1
set @product_model_year=2018

--once we hav declared our varibales, and assigned some data to it, we can go ahead and pass the variable.

select product_id,product_name,model_year,list_price  from production.products 
where category_id= @product_category and model_year= @product_model_year
order by list_price desc

----- IN SQL WE HAVE VARIOUS OPERATORS. WE HAVE LOGICAL OPERATOR, COMPARISON OPERATOR,ARITHMETIC OPERATOR.
--WE WILL USE SOME OF THE OPERATORS.

AND --- will return true if both the values are corrects.
select * from production.products  
where model_year=2016 and category_id=6

--in the code above, results will be true if model_year =2016 and category_id is 6

select * from production.products
where model_year= 2016 or category_id= 2016

--The code above will return the results either way if 
--the model_year=2016 or category_id=2016.If either way the criteria is met.

--in sql we can use both the logical operator with comparison operator.
select * from production.products
where model_year <= 2016 or category_id= 6

--we can use between as well.
select * from production.products
where model_year between 2016 and 2019 and  category_id<= 6

--what is NULL ? well null is an indication that we dont have a data inside our column or table.
select * from  sales.customers
where phone = Null
order by first_name,last_name

SELECT
customer_id,
first_name,
last_name,
phone
FROM
sales.customers
WHERE
phone is NULL
ORDER BY
first_name,
last_name;


-- find out the final step for each project
WITH FinalStep AS
(
    SELECT ProjectId, MAX(WorkflowStep) as MaxWorkflowStep
    FROM WorkflowHistory
    WHERE WorkflowStep > 1
    GROUP BY ProjectId
)
SELECT
    p.ProjectId,
    p.Title,
    -- this is ugly consider creating a scalar function to encapsulate it
    STUFF (
           (SELECT ', ' + f.Name
            FROM dbo.Facility f
            LEFT JOIN dbo.ProjectFacility pf ON f.FacilityId = pf.FacilityId
            WHERE pf.ProjectId = p.ProjectId
            FOR XML PATH (''))
            , 1, 1, '') AS Facilities,
    wf1.ActionedOn AS Recieved,
    wf2.ActionedOn AS Concluded,
    b.BranchName,
    st.Description AS StatusText,
    wf2.Comment,
    wf2.ActionedOn - w1.ActionedOn AS Turnaround
FROM
    Project p
    INNER JOIN WorkflowHistory wf1 
        ON p.ProjectId = wf1.ProjectId 
        AND wf1.WorkflowStep = 1
    LEFT JOIN FinalStep fs 
        ON fs.ProjectId = p.ProjectId
    LEFT JOIN WorkflowHistory wf2 
        ON p.ProjectId = wf2.ProjectId 
        AND wf2.WorkflowStep = fs.MaxWorkflowStep
    INNER JOIN ProjectBranch pb 
        ON pb.ProjectId = p.ProjectId
    LEFT JOIN dbo.Branch b 
        ON pb.BranchId = b.BranchId
    LEFT JOIN dbo.Status st 
        ON p.StatusId = st.StatusId
WHERE
    p.ProjectId = w.ProjectId
    -- IF @StatusId = 0 THEN p.StatusId = 5 or 6 or 7 ELSE p.StatusId = @StatusId
    AND ((@StatusId = 0 AND p.StatusId IN (5,6,7)) OR p.StatusId = @StatusId)
    -- IF @BranchId = 0 THEN no filter ELSE pb.BranchId = @BranchId
    AND (@BranchId = 0 OR pb.BranchId = @BranchId)
    AND (wf1.ActionedOn BETWEEN @FromDate AND @ToDate)

 






 CREATE PROCEDURE [dbo].[stp_CityHealthResearchRequestsReport]
@FromDate DATETIME,
@ToDate DATETIME,
@StatusId int,
@BranchId int,
@Count INT OUTPUT
AS
BEGIN
DECLARE @TempTable TABLE
(
    ProjectId INT,
    Recieved DATETIME,
    Concluded DATETIME,
    Comment VARCHAR(8000)
)

IF @StatusId <> 0 AND @BranchId <> 0
BEGIN

    INSERT INTO @TempTable (ProjectId, Recieved, Concluded, Comment)
    SELECT DISTINCT
        p.ProjectId,
        (SELECT TOP 1 wf.ActionedOn
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 1
         ORDER BY wf.WorkflowHistoryId DESC) AS Recieved,
        (SELECT TOP 1 wf.ActionedOn
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 4
         OR wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 5
         ORDER BY wf.WorkflowHistoryId DESC) AS Concluded,
        (SELECT TOP 1 wf.Comment
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 4
         OR wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 5
         ORDER BY wf.WorkflowHistoryId DESC) AS Comment
    FROM
        Project p
        JOIN WorkflowHistory w ON p.ProjectId = w.ProjectId
        JOIN ProjectBranch pb ON pb.ProjectId = p.ProjectId
    WHERE
        p.ProjectId = w.ProjectId
        AND p.StatusId = @StatusId
        AND pb.BranchId = @BranchId
        AND w.WorkflowStep = 1
        AND (w.ActionedOn BETWEEN @FromDate AND @ToDate)

    SELECT DISTINCT
        p.ProjectId,
        p.Title,
        STUFF (
               (SELECT ', ' + f.Name
                FROM dbo.Facility f
                LEFT JOIN dbo.ProjectFacility pf ON f.FacilityId = pf.FacilityId
                WHERE pf.ProjectId = p.ProjectId
                FOR XML PATH (''))
                , 1, 1, '') AS Facilities,
        tt.Recieved,
        tt.Concluded,
        b.BranchName,
        st.Description AS StatusText,
        tt.Comment,
        tt.Concluded - tt.Recieved AS Turnaround
    FROM
        dbo.Project p
        INNER JOIN @TempTable tt ON p.ProjectId = tt.ProjectId
        LEFT JOIN dbo.ProjectBranch pb ON p.ProjectId = pb.ProjectId
        LEFT JOIN dbo.Branch b ON pb.BranchId = b.BranchId
        LEFT JOIN dbo.Status st ON p.StatusId = st.StatusId
    WHERE
        p.StatusId = @StatusId
        AND b.BranchId = @BranchId
    SET @Count = @@ROWCOUNT
END

IF @StatusId <> 0 AND @BranchId = 0
BEGIN

    INSERT INTO @TempTable (ProjectId, Recieved, Concluded, Comment)
    SELECT DISTINCT
        p.ProjectId,
        (SELECT TOP 1 wf.ActionedOn
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 1
         ORDER BY wf.WorkflowHistoryId DESC) AS Recieved,
        (SELECT TOP 1 wf.ActionedOn
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 4
         OR wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 5
         ORDER BY wf.WorkflowHistoryId DESC) AS Concluded,
        (SELECT TOP 1 wf.Comment
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 4
         OR wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 5
         ORDER BY wf.WorkflowHistoryId DESC) AS Comment
    FROM
        Project p
        JOIN WorkflowHistory w ON p.ProjectId = w.ProjectId
        JOIN ProjectBranch pb ON pb.ProjectId = p.ProjectId
    WHERE
        p.ProjectId = w.ProjectId
        AND p.StatusId = @StatusId
        AND w.WorkflowStep = 1
        AND (w.ActionedOn BETWEEN @FromDate AND @ToDate)

    SELECT DISTINCT
        p.ProjectId,
        p.Title,
        STUFF (
               (SELECT ', ' + f.Name
                FROM dbo.Facility f
                LEFT JOIN dbo.ProjectFacility pf ON f.FacilityId = pf.FacilityId
                WHERE pf.ProjectId = p.ProjectId
                FOR XML PATH (''))
                , 1, 1, '') AS Facilities,
        tt.Recieved,
        tt.Concluded,
        b.BranchName,
        st.Description AS StatusText,
        tt.Comment,
        tt.Concluded - tt.Recieved AS Turnaround
    FROM
        dbo.Project p
        INNER JOIN @TempTable tt ON p.ProjectId = tt.ProjectId
        LEFT JOIN dbo.ProjectBranch pb ON p.ProjectId = pb.ProjectId
        LEFT JOIN dbo.Branch b ON pb.BranchId = b.BranchId
        LEFT JOIN dbo.Status st ON p.StatusId = st.StatusId
    WHERE
        p.StatusId = @StatusId
    SET @Count = @@ROWCOUNT
END

IF @StatusId = 0 AND @BranchId <> 0
BEGIN

    INSERT INTO @TempTable (ProjectId, Recieved, Concluded, Comment)
    SELECT DISTINCT
        p.ProjectId,
        (SELECT TOP 1 wf.ActionedOn
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 1
         ORDER BY wf.WorkflowHistoryId DESC) AS Recieved,
        (SELECT TOP 1 wf.ActionedOn
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 4
         OR wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 5
         ORDER BY wf.WorkflowHistoryId DESC) AS Concluded,
        (SELECT TOP 1 wf.Comment
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 4
         OR wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 5
         ORDER BY wf.WorkflowHistoryId DESC) AS Comment
    FROM
        Project p
        JOIN WorkflowHistory w ON p.ProjectId = w.ProjectId
        JOIN ProjectBranch pb ON pb.ProjectId = p.ProjectId
    WHERE
        p.ProjectId = w.ProjectId
        AND p.StatusId = 5
        AND pb.BranchId = @BranchId
        AND w.WorkflowStep = 1
        AND (w.ActionedOn BETWEEN @FromDate AND @ToDate)
        OR p.ProjectId = w.ProjectId
        AND p.StatusId = 6
        AND pb.BranchId = @BranchId
        AND w.WorkflowStep = 1
        AND (w.ActionedOn BETWEEN @FromDate AND @ToDate)
        OR p.ProjectId = w.ProjectId
        AND p.StatusId = 7
        AND pb.BranchId = @BranchId
        AND w.WorkflowStep = 1
        AND (w.ActionedOn BETWEEN @FromDate AND @ToDate)

    SELECT DISTINCT
        p.ProjectId,
        p.Title,
        STUFF (
               (SELECT ', ' + f.Name
                FROM dbo.Facility f
                LEFT JOIN dbo.ProjectFacility pf ON f.FacilityId = pf.FacilityId
                WHERE pf.ProjectId = p.ProjectId
                FOR XML PATH (''))
                , 1, 1, '') AS Facilities,
        tt.Recieved,
        tt.Concluded,
        b.BranchName,
        st.Description AS StatusText,
        tt.Comment,
        tt.Concluded - tt.Recieved AS Turnaround
    FROM
        dbo.Project p
        INNER JOIN @TempTable tt ON p.ProjectId = tt.ProjectId
        LEFT JOIN dbo.ProjectBranch pb ON p.ProjectId = pb.ProjectId
        LEFT JOIN dbo.Branch b ON pb.BranchId = b.BranchId
        LEFT JOIN dbo.Status st ON p.StatusId = st.StatusId
    WHERE
        p.StatusId = 5
        AND pb.BranchId = @BranchId
        OR p.StatusId = 6
        AND pb.BranchId = @BranchId
        OR p.StatusId = 7
        AND pb.BranchId = @BranchId
    SET @Count = @@ROWCOUNT
END

IF @StatusId = 0 AND @BranchId = 0
BEGIN

    INSERT INTO @TempTable (ProjectId, Recieved, Concluded, Comment)
    SELECT DISTINCT
        p.ProjectId,
        (SELECT TOP 1 wf.ActionedOn
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 1
         ORDER BY wf.WorkflowHistoryId DESC) AS Recieved,
        (SELECT TOP 1 wf.ActionedOn
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 4
         OR wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 5
         ORDER BY wf.WorkflowHistoryId DESC) AS Concluded,
        (SELECT TOP 1 wf.Comment
         FROM WorkflowHistory wf
         WHERE wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 4
         OR wf.ProjectId = p.ProjectId
         AND wf.WorkflowStep = 5
         ORDER BY wf.WorkflowHistoryId DESC) AS Comment
    FROM
        Project p
        JOIN WorkflowHistory w ON p.ProjectId = w.ProjectId
        JOIN ProjectBranch pb ON pb.ProjectId = p.ProjectId
    WHERE
        p.ProjectId = w.ProjectId
        AND p.StatusId = 5
        AND w.WorkflowStep = 1
        AND (w.ActionedOn BETWEEN @FromDate AND @ToDate)
        OR p.ProjectId = w.ProjectId
        AND p.StatusId = 6
        AND w.WorkflowStep = 1
        AND (w.ActionedOn BETWEEN @FromDate AND @ToDate)
        OR p.ProjectId = w.ProjectId
        AND p.StatusId = 7
        AND w.WorkflowStep = 1
        AND (w.ActionedOn BETWEEN @FromDate AND @ToDate)

    SELECT DISTINCT
        p.ProjectId,
        p.Title,
        STUFF (
               (SELECT ', ' + f.Name
                FROM dbo.Facility f
                LEFT JOIN dbo.ProjectFacility pf ON f.FacilityId = pf.FacilityId
                WHERE pf.ProjectId = p.ProjectId
                FOR XML PATH (''))
                , 1, 1, '') AS Facilities,
        tt.Recieved,
        tt.Concluded,
        b.BranchName,
        st.Description AS StatusText,
        tt.Comment,
        tt.Concluded - tt.Recieved AS Turnaround
    FROM
        dbo.Project p
        INNER JOIN @TempTable tt ON p.ProjectId = tt.ProjectId
        LEFT JOIN dbo.ProjectBranch pb ON p.ProjectId = pb.ProjectId
        LEFT JOIN dbo.Branch b ON pb.BranchId = b.BranchId
        LEFT JOIN dbo.Status st ON p.StatusId = st.StatusId
    WHERE
        p.StatusId = 5
        OR p.StatusId = 6
        OR p.StatusId = 7
    SET @Count = @@ROWCOUNT
END
END


-------- Create a table for the code.
use dummy_database
create table Claims_Table
(
member_id varchar(90),

claim_id varchar(90),

claim_date date,

claim_cost money)

insert into Claims_Table
(
member_id,
claim_id,
claim_date,
claim_cost
) values ('A424776769','CLM77336324','1/17/2020','$8,289'),

('A424776769','CLM24260531','2/5/2020','$6,129'),

('A424776769','CLM38346167','3/3/2020','$7,742'),

('A424776769','CLM30587605','4/25/2020','$814'),

('A833601822','CLM55999879','5/16/2020','$2,941'),

('A833601822','CLM30123910','6/15/2020','$5,543'),

('A833601822','CLM00184050','8/22/2020','$6,799'),

('A470232060','CLM88418636','1/17/2020','$2,647'),

('A470232060','CLM74388440','1/27/2020','$6,410'),

('A470232060','CLM19580035','5/1/2020','$6,072'),

('A470232060','CLM72574486','5/3/2020','$9,143'),

('A470232060','CLM84615392','11/19/2020','$6,347'),

('A470232060','CLM24690090','11/23/2020','$8,236'),

('A415809691','CLM08814192','12/4/2020','$6,542'),

('A415809691','CLM68541544','12/24/2020','$2,362')

select * from Claims_Table

 -- Question 2:Below is table showing claims cost and the member_id associated with each claim.  
 --What is the SQL query that would return claims cost by member?  For example, the first member_id would have 
 --the costs associated with 
 --the sum of the first 4 rows returned

 select member_id,sum(claim_cost) cost_of_Claim from Claims_Table
 group by member_id

 ---- This code i wanted to know the member that was associated with claim cost. For one to know the
 toatl calim of cost i used the Sum aggregate function to sum all the cost that has been associated with
 the member id in the claim table. and the code when executed, it went on and returned 4 rows.



 Question 2: Let’s say I have a dataset of population by state (e.g., Alaska, 732,000, and so on), 
 but I want to know the population by United States region (e.g., South, 114,555,000).  
 In 1-3 sentences, could you describe how you would go about doing that?
 
  in my own own opinion i will use the a join . This is because countries can have multiple states and each 
  state can have multiple cities when you join these 1 to many and 1 to many many your state count is inflated. 
  So you need the distinct count of state. The city count is already unique to country and state, thus doesnt 
  need the distinct. where as state is not unique to country city, thus distinct is needed. This of course assumes
  you want the count of unique states in each country.


  -----Learning sql from the scratch again------

  /*A select statemnet is mostly used to get some data. it gives an instruction to where the data can be fet
  fetched from*/
  select  @@version
 -- The query above shows that we we have selected server side or the local server we are using.
  
  /* But sometimes we will like to select some from columns from a table. how can we do that.
  *
  /

  for us to do o, we can go ahead and use the below syntax.
  */
 --select syntax select  from table_name---
 
 -- sometimes we will like to select everthing from 
 --a table. For us to do so, we can go ahead and use the
 --(*) the asterick will stand for everything.

 --sometimes we will like to specify the columns we will like to 
 --choose from the database. how can we do that, we can go ahead and 
 --specify it by following this simple syntax.

 --select column_a,column_b,column_c,column_..(n) 
 --from table_K

 --lets go ahead and learn run the server.
 use BikeStores
 select * from [production].[brands]
 --we can go ahead and use the column specification
 select empid,fullname,city from [dbo].[EmployeeDetails] as e

 /*sometimes, we would like to go ahead and  have many columns.
 But we would like to go and have our data being arranged*/
 select * from [dbo].[Sales_Summery]
 order by  model_year desc

 --// when we arranged the data in asc, we are say arrange the data from small to big.
 select * from [dbo].[Sales_Summery]
 order by model_year asc
 /*the data will be arranged from list year to the current one*/

 /*In sql, we can go ahead and have our columns being order by multiple columns.*/
 select *  from [dbo].[EmployeeDetails] 
 order by fullname,city 

 /*in the code, we can go ahead and specify the order by clause per column*/
 select * from [dbo].[salescustomers_sample]
 order by customer_id desc, last_name asc


 /*We can arrange the data as per the len.*/

 select customer_id,len(first_name) namelength from salescustomers_sample
 order by namelength desc

 /*In sql sever we can always go ahead and use fetch instead of the order by clause.*/
 use [BikeStores] 

 select * from production.products
 order by product_Id desc,product_name asc
 offset 10 rows 
 fetch next 10 rows only

 --we  can use a variable for example
 declare @Fetched_data  as int=10

 select * from production.products
 order by product_Id desc,product_name asc
 offset 10 rows 
 fetch next @Fetched_data rows only

  --sometimes we will like to select Top data from a table

  select product_id,product_name,list_price from production.products p

  -- lets say that we want to select top 10 items from the table
  select top (10) product_id,product_name,list_price from production.products p

    select  product_id,product_name,list_price 
	from production.products 
	order by product_id asc
	offset 0 rows
	fetch next 10 rows only 


	/*when we are dealing with the Top values, we can go ahead and select all the data by using two
	methods. The First one is select top(N) from table_One
	the secons one is select top(N) from table_Two order by table_columnOne,
	ofset N rows
	fetch N rows*/


	SELECT TOP 1 PERCENT
    product_name, 
    list_price
FROM
    production.products
ORDER BY 


SELECT TOP 2 PERCENT with  ties
    product_name, 
    list_price
FROM
    production.products
ORDER BY 
    list_price DESC;

	---- Distinct is used to distinct values.this means that we will be removing duplicate data

	--// for example we can go ahead and distinct data from a column
	select distinct product_id,product_name from production.products

	 --- we can go ahead and develope some distinction on some multiple columns
	 select distinct product_id, brand_id ,product_name from production.products

	----- Anothe example of distincting multiple Columns.
	select customer_id,city,state from sales.customers
	
	----If we want to distinct and remove the duplicate data we can go ahead and 
	--add some distinction in it.
		select customer_id,city,state from sales.customers

		--the last query we have added the distict command

		select distinct city,state from sales.customers
		order by CITY DESC


		----- What can we use instead of Distinct, if thats the case we can go ahead and use
		--the group by clause.

		SELECT 
	city, 
	state, 
	zip_code
FROM 
	sales.customers
GROUP BY 
	city, state, zip_code
ORDER BY
	city, state, zip_code


	SELECT DISTINCT
	city, 
	state, 
	zip_code
FROM 
	sales.customers
GROUP BY 
	city, state, zip_code

	select order_id
	,item_id
	,quantity
	from[sales].[order_items] 
	group by 
	order_id
	,item_id
	,quantity
	order by 
	order_id
	,item_id
	,quantity


	select distinct  order_id
	,item_id
	,quantity
	from[sales].[order_items] 
	group by 
	order_id
	,item_id
	,quantity
	order by 
	order_id
	,item_id
	,quantity

	--- Where Clause,
	--Most of the times we always want to filter the data. for use to filter some data we can go ahead and 
	--use the Where clause.

	select * from [sales].[order_items]

	-- from the table above how can we go ahead and filter the data base on order id.
		select distinct * from [sales].[order_items]
		where order_id<=5

		-- we can use the where clause, to filter data a subquery

		select * from [sales].[order_items]
		where order_id in (select distinct order_id from [sales].[order_items] where order_id <= 3)


		/*When dealing with the where clause, we will be know this three. THE TRUE OUTCOME, FALSE OUTCOME
		AND UNKNOWN OUTCOME.... BUT IN MOST CASES, THE OUTPUT WHEN DEALING WITH THE  WHERE CLAUSE
		IS ALWAYS TRUE.*/

		select product_id,product_name,category_id from production.products
		where category_id< 3
		order by product_Id desc

		/*when dealing with the where clause. note that we will always go ahead and
		dealig with comaprison operators, arithmetic operator,and logical operators.*/

		/*When dealing with some null statement, it means two things. One we can note that,
		we don't have the data in the column or the columns itself is empty*/

		select customer_id,first_name,last_name, phone from sales.customers
		where phone is null

		--what this query simply means is that we can sometimes we need all the data from column_name
		--where the column_named is null.

		--supposed we want all the data that is not null
		.
		--what will happen when this code will be executed is that all the 
		--data from the named columned is or that is not null will be retrieved

		select * from sales.customers
		where phone is not null
		select * from sales.customers
		where phone = null

		--in the above the code, no data will return no value.


		--What is logical operator. A logical operator is anything that try to makes 
		--formal argument. Most of the time we can go ahead and note that
		-- we have three types of Logical operator.

		-- AND
		-- OR
		--IN

		select * from production.products
		where product_id<=5
		and brand_id <>9


		--or we can go ahead and code this. for example
		select * from production.products
		where product_id <=9
		and category_id<6
		or  model_year <>2016

		----When dealing with the AND operator,note that, we can go ahead  know that, when we use AND
		--both of the conditio must be true. But when we use the Or, we can go ahead and know that,
		--one of the condition must be met



		Subquery--- A subquery is a Query that is written depending on other query for
retrival of data. We can use it with select, update,Insert or Delete

--For instance lets say that we have this two kind of tables
Sales.orders and Sales.customer
For instance lets say that we want to know the customers who made order and from New york
state.

select sc. from sales.customers sc

select so.order_id,so.order_date,so.customer_id from sales.orders so
where so.customer_id IN( 
select sc.customer_id 
from 
sales.customers sc
where 
sc.state = 'New York')
order by 
so.order_date desc

SELECT order_id,order_date,customer_id
FROM
    sales.orders
WHERE
    customer_id IN (
        SELECT
            customer_id
        FROM
            sales.customers
        WHERE
            city = 'New York'
    )
ORDER BY
    order_date DESC;


	select product_id,product_name,brand_id from production.products
	where (product_id <=6 and brand_id<>6 )
	and list_price >500
	order by brand_id

	use AdventureWorks2017
/*1:Write a SQL statement that displays all the information about all salespeople*/
select * from Sales.SalesPerson

/*2:Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution".*/
select 'This is SQL Exercise, Practice and Solution'as String_display

/*3:Write a SQL query to display three numbers in three columns. */
select 2,4,6

/*4:Write a SQL query to display the sum of two numbers 10 and 15 from the RDBMS server*/
select SUM(10+15) as sum_of_Two_Numbers

/*5:Write an SQL query to display the result of an arithmetic expression.*/

select (8%4) as 'Arithemtic _expression'

/*6. Write a SQL statement to display specific columns such as names and commissions for all salespeople.  
Sample table: salesman*/
select s.BusinessEntityID,s.FirstName,s.City,s.SalesQuota as 'Commission' from Sales.vSalesPerson s

/*7. Write a query to display the columns in a specific order, such as order date, salesman ID, order number, and purchase amount for all orders.*/
select s.SalesOrderID,s.UnitPrice,s.ModifiedDate,s.SalesOrderDetailID from Sales.SalesOrderDetail s
order by s.SalesOrderDetailID,s.SalesOrderID,s.UnitPrice,s.ModifiedDate

select DISTINCT P.CustomerID from Sales.SalesOrderHeader p

/*9. From the following table, write a SQL query to locate salespeople who live in the city of 'Paris'. Return salesperson's name, city. */
SELECT S.BusinessEntityID,S.FirstName,S.City,S.CountryRegionName,S.SalesQuota FROM Sales.vSalesPerson s
WHERE S.City LIKE '%paris%'

/*data catalogue*/

select * from INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME like '%grade%'
order by TABLE_NAME

select c.BusinessEntityID,c.FirstName, c.City,c.SalesQuota from sales.vSalesPerson c
where c.SalesQuota = 250000.00


select o.SalesOrderID,o.PurchaseOrderNumber,o.OrderDate,o.CustomerID from sales.SalesOrderHeader o
where o.SalesOrderID>4001


use Movies

select f.FilmID,f.FilmName,f.FilmOscarNominations,f.FilmReleaseDate from tblFilm f
where year(f.FilmReleaseDate)= 1989


-------------------------------------- Sql Documentation------------------------------------------
--most of the times, we normaly install dat into our database, this data base has a object called table.
--a table consist of rows and columns. 

--1: Select-- a select is a command used to retrieve data from a table.
--syntax for select ---- select column A, B ,C from table_ K

------- use or select database.

select * from BikeStores.dbo.salescustomers_sample c
where c.zip_code=14127


--in our select statemet for instance, when we write a query,  not that th execution of the query starts from the  FROM CLAUSE
----then followed by the select.

--when selecting column from a table, always pull the data instead  of using (*).
--This is because alot of columns will be puled which doesnt need most of the time,
--secondly we need to avoid to query crushing and slowing the query.


select  c.customer_id,c.first_name,c.last_name,c.city,c.state from BikeStores.dbo.salescustomers_sample c

---- Filter data-------

--for most of the case when you want to  filter the data, one can go ahead and use the where clause'

select  c.customer_id,c.first_name,c.last_name,c.city,c.state from BikeStores.dbo.salescustomers_sample c
where c.state ='NY'

--once we have added the where clause, we need to go ahead and note that, most of the times
--the order of the execution will change and we will see
--from 
--where
--select

select  c.customer_id,c.first_name,c.last_name,c.city,c.state from BikeStores.dbo.salescustomers_sample c
where c.state= 'NY'  order by c.first_name

--by adding theorder by the order of execution will be changed to 
--from
--where
--select 
--order by

use BikeStores

select 
s.city,
COUNT(*)
from BikeStores.dbo.salescustomers_sample s
where s.state='ca'
group by s.city
order by s.city

select * from BikeStores.dbo.salescustomers_sample s
where s.city='Apple Valley'

 ----in this case when the executio of the query will be done, the query will be  running from

 -- from 
 -- where
 -- group by
 -- select 
 -- order by 


SELECT
    city,
    COUNT (*)
FROM
    sales.customers
WHERE
    state = 'CA'
GROUP BY
    city
HAVING
    COUNT (*) > 10
ORDER BY
    city;


	--in our case the order execution is 

	--from
	--where
	--having
	--group by
	--select 
	--order by 



	------------ ORDER  BY CLAUSE--------------------
	/* Most of the times, when we select statement, we should always go ahead and not that, the loaded data will not be sorted
	the way we wll want it to, thats why we need to go ahead order it by ourseleves.
	
	syntax  for order by 
	
	select column A, column B
	from table_p
	WHERE COLUMN.a= CONDITION
	group  by column table
	having aggregate_function
	order by*/

	select s.city,count(*) number_of_customers from BikeStores.dbo.salescustomers_sample s
	where s.state='NY'
	group by s.city
	having	count(*) > 10
	order by s.city

	---------- Order by----------------

	select* from BikeStores.dbo.salescustomers_sample s
	order by s.customer_id desc
	offset 10 rows
	fetch first 10 rows only

	------------- Top-----------------------
	select  * from sales.orders o

	select top 10 * from sales.orders o

	select top 5 with   ties p.product_id,p.product_name,p.list_price from [production].[products] p
	order by list_price asc


	/*Distinct its used to remove duplicates*/

select  distinct(list_price)  from [production].[products] p

where----------- it a clause used to filter data from a query.

select * from production.products
where model_year=2016
or 
select * from production.products p
where p.category_id=1 order by list_price
	
select * from [production].[products] p
where p.category_id= 1 AND P.model_year =2018
ORDER BY list_price asc

select * from [production].[products] p
where list_price= 469.99  and model_year=2018


select * from [production].[products] p
where p. list_price > 1200 or p.model_year = 2018

select * from [production].[products] p
where p.list_price between 1000 and 2000
order by p.list_price

select * from [production].[products] p
where p.list_price IN (299.99, 369.99, 489.99)order by p.list_price desc

--or we can go ahead and search for the uery like this 

select * from production.products p
where p.list_price in (
select pp.list_price from production.products pp
where pp.list_price in (299.99, 369.99, 489.99)
) and p.model_year in (2017,2016)

------------------------- fiding string using like wildcards--------------------------

select p.product_id,
p.product_name,
p.category_id,
p.model_year,
p.list_price
from production.products p
where p.product_name  like '%commute%'
order by p.list_price desc


--------Null absence of data in column-------
select * from sales.customers c
where c.phone=null order by c.first_name,c.last_name

-----or----- 

select * from sales.customers c
where c.phone is null order by c.first_name,c.last_name

----- if we don't want want null, we can go haead and 
select * from sales.customers c
where c.phone is  not null order by c.first_name,c.last_name


And ---- used to return boolean expression if its true or false and in this case we need to note 
--- that result will be false if on the condition is not ment.

select * from  BikeStores.dbo.salescustomers_sample c
where c.city='Bronx' and c.state='CA'

---The  results is null simple because, by using and,on of the conditu=ionwas not met


------------or used to retunr results that are true if  either of te condition is met

select * from [production].[products] p
where p.model_year=2016  or p.brand_id =5



select * from production.[products] p
where p.list_price < 200 or  p.list_price >400
order by p.product_name asc

--in sql we can go ahead and use numerous or statement.

select * from production.products p
where p.brand_id =1  or   p.model_year=2015 or p.model_year=2018

--but mostly when we are using or, its tiresome  and it can be heactic when it come to perfomnace tining.


select * from production.products p
where p.list_price <300 or p.category_id in   (3 , 5)
order by p.category_id desc

--in most of the times, we can go ahead and use combination of or and.

select 
p.product_name,
p.product_id,
p.model_year
from production.products p
where (p.brand_id=1
or  p.brand_id=2 ) and p.list_price < 2000
order by p.product_name asc


IN----- used to check if the data exist in a list.

select p.product_name,p.list_price,p.model_year from production.products p
where p.list_price  in  (89.99, 109.99)

select * from production.stocks p
where p.store_id=1 and p.quantity>=30


select p.product_name,p.list_price from production.products p
where p.product_id in (
select s.product_id from production.stocks s
where s.store_id=1 and s.quantity>=30)
order by p.product_name


Between--- Used to give range of data.

select p.product_id,p.product_name,p.list_price from production.products p
where p.list_price between  149.99 AND 199.99

or in Between----------- we cant   use or with  between

select p.product_id,p.product_name,p.list_price from production.products p
where p.list_price between  149.99  and  199.99


select o.order_id,
o.customer_id,
o.order_date,
o.order_status 
from sales.orders o
where o.order_date between '20170115' AND '20170117'
order by o.order_date


-----------Wild Cards----------------
-------- %z----- Will be returning last name that end with z

select c.customer_id,c.first_name,c.last_name from sales.customers  c
where c.last_name like 'z%'
-------- %z----- Will be returning last name that start with z

select c.customer_id,c.first_name,c.last_name from sales.customers  c
where c.last_name like '%z'


-------- %z%----- Will be returning any characters that has z in it.

select c.customer_id,c.first_name,c.last_name from sales.customers  c
where c.last_name like '%z%'

---- Finding second chacters in a string

select * from sales.customers  c
where c.last_name like	'_r%'

---- Finding second chacters in a string

select * from sales.customers  c
where c.last_name like	'_r%'

---- Finding second chacters in a string

select * from sales.customers  c
where c.last_name like	'r_%'

select * from sales.customers c
where c.last_name  not like	 '[^a,b,c,d]%'

--or 

select * from sales.customers c
where c.last_name like '[a-b]%'


------IN ----- used to select multiple values in alist-----

select * from sales.customers c
where c.state in ('CA','NY','WA')

---- joins---used to combine two or more set of tables.
----types of joins inner join, right join, left jin, self join, cross join
IF OBJECT_ID('hr_candidates', 'N') IS NOT NULL
BEGIN
    drop table hr_candidates
END

CREATE TABLE hr_candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);


IF OBJECT_ID('hr_employees', 'N') IS NOT NULL
BEGIN
    drop table hr_employees
END 

CREATE TABLE hr_employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);

INSERT INTO 
    hr_candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');


INSERT INTO 
    hr_employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

	select * from hr_employees

	----- INNER JOIN---used to match data between two tables.
	select c.id,c.fullname as 'candiate_name',e.fullname from hr_candidates c
	inner join hr_employees e
	on c.fullname=e.fullname

		----- Right JOIN---used to match data from the right table  and all the records from the left.
	select c.id,c.fullname as 'candiate_name',e.fullname from hr_candidates c
	left join hr_employees e
	on c.fullname=e.fullname

	select c.id,c.fullname as 'candiate_name',e.fullname from hr_candidates c
	right join hr_employees e
	on c.fullname=e.fullname


	SELECT  
	c.id candidate_id,
	c.fullname candidate_name,
	e.id employee_id,
	e.fullname employee_name
FROM 
	hr_candidates c
	LEFT JOIN hr_employees e 
		ON e.fullname = c.fullname;


--left join moves data from the left join and matching data from the right. in most cases when we match the data and the row table from the 
--left doesnt match that of the right, it will return the null the vice
SELECT  
c.id candidate_id,
c.fullname candidate_name,
e.id employee_id,
e.fullname employee_name
FROM 
hr_candidates c
right JOIN hr_employees e 
ON e.id = c.id
	where c.id is   null

	--left doesnt match that of the right, it will return the null the vice
SELECT  
c.id candidate_id,
c.fullname candidate_name,
e.id employee_id,
e.fullname employee_name
FROM 
hr_candidates c
full JOIN hr_employees e 
	ON e.id = c.id
	where c.id is   null


	select 
	p.product_id,
	p.product_name,
	p.list_price,
	p.model_year

	from production.products p
	inner join production.categories c on p.category_id=c.category_id
	inner join production.brands b on b.brand_id= p.brand_id
	order by p.product_name desc



	---- Inner join --------

select p.product_name,c.category_id,c.category_name,p.list_price from production.products p 
inner join production.categories c
on p.category_id=c.category_id
order by p.product_name desc



--------- Left JOIN---------

select p.product_id,p.product_name,p.list_price,p.model_year,c.category_name from production.products p
left join production.categories c
on p.category_id=c.category_id
order by p.product_name desc


------------ Right Join-----------

select sf.staff_id,sf.first_name,sf.last_name,sf.manager_id,sf.email,s.zip_code from [sales].[staffs] sf
right join [sales].[stores] s
on sf.store_id=s.store_id
order by sf.manager_id desc

--or

select o.order_id,o.quantity,p.product_name,p.category_id from sales.order_items o
right join production.products p on p.product_id=o.product_id
order by o.order_id asc


select p.product_id,p.product_name,p.list_price,p.model_year,s.discount,o.customer_id,c.first_name,c.last_name,c.city,c.state,o.required_date,o.shipped_date from sales.order_items s
left join production.products p on s.product_id=p.product_id
left join sales.orders o on o.order_id=s.order_id
left join sales.customers c on c.customer_id=o.customer_id
order by o.order_id  asc


------ Using AND and Where in sql joins---------

select * from sales.customers c
left join  sales.orders o  on c.customer_id=o.customer_id where o.order_id=100
order by o.order_id asc

--- or e can go ahead and write this code this way.

select * from sales.customers c 
left join sales.orders o on c.customer_id=o.customer_id where o.order_id=100
order by o.order_id asc


select o.order_id,o.product_id,o.list_price,p.product_name,p.model_year from sales.order_items o 
right join production.products p on o.product_id=p.product_id
order by o.order_id

------Null ----------

select s.product_id,s.order_id,s.quantity,s.list_price,p.product_name from sales.order_items s
right join production.products p on s.product_id=p.product_id
where s.order_id is not null

select s.store_id,s.store_name,s.street,s.zip_code,s.city,s.state from sales.stores s
cross join production.products p 
left join (
select o.store_id,p.product_id,p.product_name,
sum(p.list_price * i.quantity) as sales
 from sales.orders	o
left join production.products p on p.product_id=o.order_id
left join sales.order_items i on i.product_id=p.product_id
left join sales.stores s on s.store_id=o.store_id
left join sales.orders r on r.order_id=o.order_id
group by o.store_id,p.product_id,p.product_name
) c on c.product_id=p.product_id  and c.store_id=s.store_id
where s.store_id is not null 
group  by s.store_id,s.store_name,s.street,s.zip_code,s.city,s.state


--- Group  By-------
select
o.customer_id,
o.order_id,
o.required_date,
o.shipped_date,
YEAR(o.order_date) order_date
from sales.orders o
where o.customer_id in(1,2,3)
group  by o.customer_id,
o.order_id,
o.required_date,
o.shipped_date,
YEAR(o.order_date) 
order by o.customer_id asc



---- self Join-----
select * from sales.staffs s
inner join sales.staffs ss
on s.staff_id=ss.manager_id


------ group By- used to group rows together---
select 
o.customer_id,c.first_name,c.city,c.state,
count(o.order_id) order_placed, 
year(o.order_date)order_Year  from sales.orders o left join sales.customers c on c.customer_id=o.customer_id
where o.customer_id in (1,2,3)
group  by o.customer_id,c.first_name,c.city,c.state,
year(o.order_date)
order by o.customer_id

-- or
select 
s.customer_id,
count(s.order_id) total_count_of_orders,
year(s.shipped_date) Year_Shipped
from sales.orders s
where s.customer_id in (1,2,3) and year(s.shipped_date) is  not null
group  by 
s.customer_id,
s.shipped_date

select 
c.first_name,
c.last_name,
c.city,
c.state,
year(o.order_date) year,
count(o.order_id) order_count
from sales.customers c
left join sales.orders o on c.customer_id=o.customer_id
group by c.first_name,
c.last_name,
c.city,
c.state,
year(o.order_date) 
order by c.state,c.city


------ Using Max and Min--------
select 
p.product_id,
p.product_name,
Year(p.model_year) brad_model_year,
max(p.list_price) max_price,
min(p.list_price) min_price
from production.products p
left join production.brands b on p.brand_id=b.brand_id
where p.model_year = 2018
group by 
p.product_id,
p.product_name,
Year(p.model_year)
order by p.product_id desc

select 
p.brand_id,
p.model_year,
b.brand_name,
round(Avg(p.list_price),2) Avg_list_price
from production.products p
left join production.brands b on p.brand_id=b.brand_id
group by p.brand_id,
p.model_year,b.brand_name
order by b.brand_name



------ sum with group by---

select 
o.order_id,
o.product_id,
SUM(o.quantity*o.list_price*(1-o.discount)) Total_Sales
from sales.order_items o
group by 
o.order_id,
o.product_id

--- having used to filter groups---
select 
o.customer_id,
c.first_name,
c.last_name,
c.city,
c.state,
YEAR(o.order_date) Year_ordered,
count(o.order_id) order_count
from sales.orders o left join sales.customers c on c.customer_id=o.customer_id
group by
o.customer_id,
c.first_name,
c.last_name,
c.city,
c.state,
YEAR(o.order_date),c.customer_id
having count(o.order_id) > 2
order by o.customer_id



---------Cube in sql server-- Its a subclause of group by grouping columnsin rows--------------

select 
p.product_id,
p.product_name,
p.list_price,
p.list_price,
b.brand_name,
c.category_name,
round(sum(i.quantity*i.list_price*(1-discount) 
),0
) as Total_sales 
from sales.order_items i
left join production.products p on i.product_id=p.product_id
left join production.brands b on b.brand_id=p.brand_id
left join production.categories c on c.category_id=p.category_id
group by 
p.product_id,
p.product_name,
p.list_price,
p.list_price,
b.brand_name,
c.category_name
order by
b.brand_name,
c.category_name



----- Subquery--- Its a query that has been embedded inside another queries.

select o.order_id,O.customer_id,
c.first_name,
c.last_name,
month(o.order_date)Mntg_ordered,
o.order_status,
o.shipped_date
from sales.orders o
left join sales.customers c on c.customer_id=o.customer_id
where o.customer_id in (
select c.customer_id
from sales.customers c
where c.state='CA' 
) and Month(o.order_date)<=5

---- Nesed Subquery--------

select 
p.product_id,
p.product_name,
p.model_year,
p.list_price
from production.products p
where p.list_price >(
select Avg(pp.list_price)  from 
production.products pp
where pp.brand_id in(
select 
b.brand_id
from  production.brands b
where b.brand_name ='strider' or b.brand_name = 'Trek'
)
) order  by p.list_price


-------------------------
select  
o.order_id,
o.order_date,
(select 
max(i.list_price) 
from sales.order_items i
where i.order_id=o.order_id) as max_Price
from sales.orders o
order by 
o.order_id desc,
o.order_date


----------------
select p.product_id,
p.product_name
from production.products p
where p.category_id in (
select c.category_id
from production.categories c
where c.category_name = 'Mountain Bikes' or c.category_name ='Road Bikes')
order by p.product_id asc,
p.product_name

/*
--------- Subquery--- used to write query under another query  will be  categorized in to two 
outer query and inner query.
outer quey  depends on then inner query to run since it depended on it then the outer query will be executed.
*/

select 
o.order_id,
o.customer_id,
o.required_date
from sales.orders o
where o.customer_id in (
select c.customer_id from sales.customers c
where c.state ='NY')
order by o.order_date desc

/*Nested_Subquery---- this is s a subquery that has been embedded inside another subquery*/

select 
p.product_id,
p.product_name,
p.list_price,
b.brand_name
from production.products p
left join production.brands b on p.brand_id=b.brand_id
where p.list_price > (
	select min(p.list_price) Minimum_product_price
	from production.products p
	where p.brand_id in  (
	select b.brand_id from production.brands b
	)
	) order by p.list_price desc

/* Most of the times, we need to know that subquery normally returns single value.*/

select 
o.order_id,
o.customer_id,
o.order_date,
(
select Max(i.list_price)
from sales.order_items i 
where i.order_id=o.order_id) max_price
from sales.orders o
order by o.order_date desc

----------------

select  p.product_id,
p.product_name
from production.products p
where p.category_id in (
select c.category_id from production.categories c
where c.category_name  like '%Mountain Bikes%' or c.category_name  like '%Road Bikes%' 
 )order by p.product_id asc



 ------ Any in subquery---------

 select 
 p.product_name,p.list_price
 from  production.products p 
 where p.list_price >= any(
 select AVG(p.list_price) from production.products p
 group by p.brand_id
 )


 SELECT
    product_name,
    list_price
FROM
    production.products
WHERE
    list_price >= ANY (
        SELECT
            AVG (list_price)
        FROM
            production.products
        GROUP BY
            brand_id
    )


	------- All in Sql server--------

	select o.order_id,o.order_date 
	from sales.orders o
	where o.order_id = ALL (
	select s.store_id from [sales].[stores] s
	where s.store_id = 2 or s.store_id=5 
	)

	-----------------Exists----------
	select 
	c.customer_id,
	c.first_name,
	c.last_name,
	c.city
	from sales.customers c
	where   EXISTS(
		select s.customer_id from  sales.orders s
		where c.customer_id=s.customer_id and YEAR(s.order_date)=2017
		) order by c.last_name,c.first_name
		
		---------NOT EXITS-------
		select 
		c.customer_id,
		c.first_name,
		c.last_name,
		c.city
		from sales.customers c
		where not exists (
		select o.customer_id from sales.orders o
		where o.customer_id=c.customer_id and year(o.order_date) =2018
		) order by c.last_name



		------ Getting a subquery from afrom clause-----
		select 
		t.order_id,
		t.staff_id
		from (
		select 
		o.staff_id,
		count(o.order_id) as order_id
		from sales.orders o
		group by o.staff_id
		) t



		--------Av in from  subquery---------

		select 
		AVG(order_count) average_order_count_by_stuff
		from (
		select 
		o.staff_id,
		count(o.order_id) order_count
		from sales.orders o
		group by o.staff_id
		) t

		--------- Correlated Subquery---- This is a query that depends on the outer query.

		/* for correleted subquery the outer query will be xecuted first them, the result will be translated to
		the inner query or subquery*/

		select 
		p1.product_id,
		p1.product_name,
		p1.list_price
		from production.products p1
		where p1.list_price in (
		select 
		max(p2.list_price)
		from production.products p2
		where p1.category_id=p2.category_id
		group by p2.category_id
		) order by p1.category_id, p1.product_id desc


		------- Exist returns all the data so long as subquery returns data even if its null---
		select 
		c.customer_id,
		c.first_name,
		c.last_name
		from sales.customers c
		where EXISTS( SELECT NULL)
		order by c.first_name, c.last_name



		------Finding customers who made more  than two orders--------

		select C.customer_id,
		c.first_name,
		c.last_name,
		YEAR(o1.order_date) order_year
		from  sales.customers c left join sales.orders o1 on o1.customer_id=c.customer_id
		where EXISTS(
		select 
		count(*)
		from sales.orders o
		where o.customer_id=c.customer_id
		group  by o.customer_id 
		having  count(*) > 2
		)  order by c.first_name,c.last_name



		---------using any in a subquery to find products that where sold more than two units-------
		
		select 
		p.product_id,
		p.product_name,
		p.list_price
		from production.products p
		where p.product_id = any(
		select 
		i.product_id
		from sales.order_items i where i.quantity >2)


-------/*Any used to comapre scalar expression to a  single column*/

		select 
		p.product_id,
		p.product_name,
		p.list_price
		from production.products p
		where p.list_price >ALL(
		select AVG(p1.list_price) from production.products p1
		group by p1.brand_id) order  by p.list_price

		------------------------------------------------

		select 
		p.product_id,
		p.product_name,
		p.list_price
		from production.products p
		where p.list_price < ALL(
		select AVG(p1.list_price) from production.products p1
		group by p1.brand_id) order  by p.list_price

------------ Union and Union All---- Union is used to  combine two or more result set into one.
		/* Union ------ used to remove duplicates, while union all returns duplicates.*/

		select 
		s1.first_name, s1.last_name, s1.email
		from sales.staffs s1
		union
		select 
		c.first_name, c.last_name,c.email
		from sales.customers c



		------ Union All-------------
		
		select 
		s1.first_name, s1.last_name, s1.email
		from sales.staffs s1
		union All
		select 
		c.first_name, c.last_name,c.email
		from sales.customers c


		--------------------
		SELECT
    product_id
FROM
    production.products
EXCEPT
SELECT
    product_id
FROM
    sales.order_items;


	-------- CTE---- Stands for common table expression,

	select 
	o.order_id,
	o.order_date,
	c.first_name +''+ c.last_name as Full_Name,
	SUM(i.quantity*i.list_price*(1-i.discount)) Total_Orders
	from sales.orders o
	left join sales.order_items i on i.order_id=o.order_id
	left join sales.staffs s on s.staff_id=o.staff_id
	left join sales.customers c on c.customer_id=o.customer_id
	group  by  o.order_id,
	o.order_date,
	c.first_name +''+ c.last_name
	order by o.order_id desc


	-------- We can go ahead and umbrella the query above to be inside the CTE

WITH cte_total_sales_amount
as
(
select 
	o.order_id,
	o.order_date,
	c.first_name +''+ c.last_name as Full_Name,
	SUM(i.quantity*i.list_price*(1-i.discount)) Total_Orders
	from sales.orders o
	left join sales.order_items i on i.order_id=o.order_id
	left join sales.staffs s on s.staff_id=o.staff_id
	left join sales.customers c on c.customer_id=o.customer_id
	group  by  o.order_id,
	o.order_date,
	c.first_name +''+ c.last_name
	order by o.order_id desc)

	select * from cte_total_sales_amount


	---- we can gao ahead and some parameters in our cte------
	with cte_sum_of_toal_sales
	as
	(
	select 
	o.order_id,
	o.customer_id, 
	c.first_name, 
	c.last_name,
	s.first_name as staff_first_name,
	sum(i.quantity*i.list_price *(1-i.discount)) Total_sales
	from sales.orders o left join sales.order_items i on i.order_id=o.order_id
	left join sales.customers c on c.customer_id=o.customer_id
	left join sales.staffs s  on s.store_id=o.store_id
	group by o.order_id,
	o.customer_id, 
	c.first_name, 
	c.last_name,
	s.first_name
	)
	select 
	*
	from cte_sum_of_toal_sales



	---- Using CTE to Find the average  number of sales in the year 2018
	with cte_count_of_sales
	as
	(
	select 
	s.staff_id,
	count(*) order_count
	from sales.orders o  left join sales.staffs s on o.staff_id=s.staff_id
	where YEAR(o.order_date) =2018
	group by s.staff_id
	)
	select AVG(order_count) as average_count from cte_count_of_sales


	----- We can use multiple cte 


	with cte_category_count
	as 
	(
	select 
	c.category_id,
	c.category_name,
	count(p.product_id) Count_of_Products
	from production.products p left join  production.categories c on c.category_id=p.category_id
	group by c.category_id,
	c.category_name
	),
	
	cte_total_quantity_sold
	as (
	select 
	p.category_id,
	sum(i.quantity*i.list_price *(1-i.discount)) as total_sales
	from sales.orders o left join production.products p on p.product_id=o.order_id
	left join sales.order_items i on i.order_id=o.order_id
	where o.order_status =4
	group by 	p.category_id
	)

	select * from cte_category_count c1 inner join cte_total_quantity_sold c2 on c1.category_id=c2.category_id


	---- Recusive cte, its a cte that, referenec Itself--------
	WITH cte_recursive
	as
	(
	select 
	s.staff_id,
	s.first_name,
	s.manager_id
	from sales.staffs s

	union all

	select s1.staff_id,
	s1.first_name,
	s1.manager_id
	from sales.staffs s1
	inner join cte_recursive cr on cr.manager_id =s1.staff_id)
	
	select* from cte_recursive


	----- Pivot used to return a row into a column--------

	select 
	p.product_id,
	p.product_name,
	count(p.category_id) as count_of_category_products
	from production.products p
	left join production.categories c on c.category_id=p.category_id
	group by p.product_id,
	p.product_name


	------- we can go ahead and put this query inside a  pivot------

	select * from
	(

	select 
	p.product_id, 
	c.category_name
	from production.products p left join production.categories c
	 on c.category_id=p.product_id
) t 
pivot (count(product_id)
for category_name in (
[Children Bicycles], 
        [Comfort Bicycles], 
        [Cruisers Bicycles], 
        [Cyclocross Bicycles], 
        [Electric Bikes], 
        [Mountain Bikes], 
        [Road Bikes])) as pivoted_data

		------Linked report-----
		select 
		p.product_id,
		p.product_name,
		p.model_year,
		p.list_price
		from [production].[products] p
		where p.category_id=@category_id

		select  category_id from production.categories 


		---------Linked report queries---------

		select
		p.product_id,
		p.product_name,
		p.category_id,
		i.discount,
		i.quantity,
		i.item_id,
		SUM(i.quantity*p.list_price) product_total_cost,
		sum(i.list_price*(1-i.discount)) Total_sales_Amount
		from production.products p 
		left join sales.order_items i on p.product_id=i.product_id
		left join sales.orders o on o.order_id=i.order_id
		group  by 
		p.product_id,
		p.product_name,
		p.category_id,
		i.discount,
		i.quantity,
		i.item_id
		order by p.product_name
		---------------------------------------------------------
		select c.category_id,c.category_name from production.categories c

		----------------------------------------------------------
		select
		p.category_id,
		c.category_name
		from production.products p
		left join production.categories c on c.category_id=p.category_id
		where  c.category_id in (1,3) and c.category_id=@categoryid
		-----------------------------------------------------------------
		select 
		c.customer_id,
		c.first_name,
		c.last_name,
		c.city,
		c.state
		from sales.customers c left join
		where c.city=@city

		----------------------------------

		select c.city from sales.customers c

		-------------------------------------------

		select distinct
		c.city,
		c.customer_id,
		c.first_name,
		c.last_name,
		c.zip_code,
		year(o.order_date) products_order_date,
		p.category_id,
		c.state
		from sales.customers c left join sales.orders  o on o.customer_id=c.customer_id
		left join sales.order_items i on i.order_id=o.order_id 
		left join production.products p on p.product_id=i.product_id

		----------------------------

		select distinct  year(o.order_date) order_year  from sales.orders o


		------------------------- Query for drill down  summer report---------------------

		select distinct
				c.state,
				c.city,
				c.customer_id,
				c.first_name,
				c.last_name,
				c.zip_code,
				year(o.order_date) as products_order_date,
				p.category_id,
				p.product_id,
				p.product_name,
				p.category_id,
				i.discount,
				i.quantity,
				i.item_id,
				SUM(i.quantity*p.list_price) product_total_cost,
				sum(i.list_price*(1-i.discount)) Total_sales_Amount
		
		from sales.customers c left join sales.orders  o on o.customer_id=c.customer_id
		left join sales.order_items i on i.order_id=o.order_id 
		left join production.products p on p.product_id=i.product_id
		group by 
		c.state,
		c.city,
		c.customer_id,
		c.first_name,
		c.last_name,
		c.zip_code,
		year(o.order_date),
		p.category_id,
		p.product_id,
		p.product_name,
		p.category_id,
		i.discount,
		i.quantity,
		i.item_id

	--------------------------------------sales------------------------------
select 
o.order_id,
o.customer_id,
o.order_status
from sales.orders o left join sales.order_items i on i.order_id=o.order_id

		



