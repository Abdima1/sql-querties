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
		below is the syntaxt of UNION
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
--working under the Manager with id  986.

select EmpId,FullName from EmployeeDetails
where ManagerId=986

--Question 2: Write an SQL query to fetch the different projects available from 
--the EmployeeSalary table.
select distinct project from EmployeeSalary

--Question 3: Write an SQL query to fetch the count of employees working in project P1.
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
--and work under the manager with ManagerId  321.
select * from EmployeeDetails
where City='Toronto'
and ManagerId=321

--Question.7. Write an SQL query to fetch all the employees who either live in California or 
--work under a manager with ManagerId  321.
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
--two characters, followed by a text hn 
--and ends with any sequence of characters.

select EmpId, FullName from EmployeeDetails
where FullName like '__hn%'

----Question.11. Write an SQL query to fetch all the EmpIds which are present in either 
--of the tables 
---- EmployeeDetails and EmployeeSalary.

select EmpId from EmployeeSalary
union
select EmpId from EmployeeDetails

select e.EmpId from EmployeeDetails as E
inner Join EmployeeSalary as S
on E.EmpId= S.EmpId


--Question: 12 Write an SQL query to fetch common records between two tables.
--Ans. SQL Server  Using INTERSECT operator-
select * from EmployeeDetails
intersect
select * from  EmployeeSalary


select * from EmployeeDetails
MINUS
select * from 

--use dummy_database
--Question.14. Write an SQL query to fetch the EmpIds that are present in both the tables    
--EmployeeDetails and EmployeeSalary.
select * from EmployeeDetails
where EmpId in ( select EmpId from EmployeeSalary)

------Question.15. Write an SQL query to fetch the EmpIds that are present in 
--EmployeeDetails but 
----not 
----in EmployeeSalary.
select Empid from EmployeeDetails
where EmpId NOT IN ( select EmpId from EmployeeSalary )


--Ques.16. Write an SQL query to fetch the employees 
--full names and replace the space with -.
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
--projects
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
--(without considering the primary key  EmpId).
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
