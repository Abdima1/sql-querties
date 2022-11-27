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