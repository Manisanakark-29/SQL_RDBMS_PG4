select *  from sales; 
select * from customer; 
select * from product; 
--	Define the relationship between the tables using constraints/keys.

--This means that the constraints are defined within a CREATE TABLE statement. 
--To apply the constraints, use the CONSTRAINT keyword after a field declaration, name the constraint, name the table that it references, 
--and name the field or fields within that table that will make up the matching foreign key.

---3.	In the database Supermart _DB, find the following:
---a.	Get the list of all the cities where the region is north or east without any duplicates using IN statement.
select DISTINCT city from customer  where  region  in  ('East','North');
---b.	Get the list of all orders where the ‘sales’ value is between 100 and 500 using the BETWEEN operator.
select * from sales where sales between 100 and 500;
--c.	Get the list of customers whose last name contains only 4 characters using LIKE.
select * from customer where customername like '% ____'


----SELECTION COMMANDS:- ordering
---1.	Retrieve all orders where the ‘discount’ value is greater than zero ordered in descending order basis ‘discount’ value
select discount, count(discount) from sales group by discount having discount>0 order by(discount) desc  ;

---2.	Limit the number of results in the above query to the top 10.
select  discount, count(discount) from sales group by discount having discount>0 order by(discount) desc fetch first 10 rows only;

---Aggregate commands:-
--1.	Find the sum of all ‘sales’ values.
select sum(sales) from sales;

---2.	Find count of the number of customers in the north region with ages between 20 and 30
		
select count(*)from customer where region in ('North') and age between 20 and 30;
---3.	Find the average age of east region customers

select avg(age) from customer where region in('North');

---4.	Find the minimum and maximum aged customers from Philadelphia

select max(age)from customer where city in ('Philadelphia');
select min(age)from customer where city in ('Philadelphia');


---GROUP BY COMMANDS:-
--1.	Make a dashboard showing the following figures for each product ID
--a.	Total sales (in $) order by this column in descending 
select productid, sales,count(sales) from sales group by productid, sales  order by (sales) desc ;
--b.	Total sales 
select sum(sales) from sales; 
--c.	The number of orders
select count(*) from sales;
--d.	Max Sales value
select productid,sales  from sales where sales = (select max(sales)from sales) ;


--e.	Min Sales value
select productid,sales from sales where sales=(select min(sales)from sales );

--f.	Average sales value
select avg(sales) from sales; 

--2.	Get the list of product ID’s where the quantity of product sold is greater than 10
select quantity, count(quantity) ,productid from sales group by quantity ,productid having quantity>10 order by (quantity)desc;

---1.	Get data with all columns of the sales table, and customer name, customer age, product name, 
---and category are in the same result set. 
---(use join in the subquery, refer to the datafiles from Assignments-05)
select * from sales;
select * from customer;
select * from product;
select sales.*,customer.customername, customer.age, product.productname,product.category from sales full join customer  
on customer.customerid=sales.customerid full join product on
sales.productid = product.productid;

--2.	Get data sales table, product name, and category in the result set.


select sales.*,product.productname,product.category from sales full join product on sales.productid = product.productid;


--3.	Without using the join concept create a sub-query by using the customer, product, sales data.
-- without join

select * from customer,sales,product   where sales.customerid = customer.customerid and sales.productid = product.productid;


-- with join

select * from sales join customer on sales.customerid = customer.customerid  join product on sales.productid = product.productid;
--Functions: -
--string functions: -
--1.	Find maximum length of characters in the Product name string from Product table

SELECT  * FROM product
WHERE
length(productname)= 
(SELECT  max(length(productname)) FROM product);

--2.	Retrieve product name, sub-category and category from Product table and an additional column 
--named “product_details” which contains a concatenated string of product name, sub-category and category.

SELECT product.productname,product. subcategory,product.category,  CONCAT(productname, ' ,', subcategory,',',category) AS productdetails 
FROM product ORDER BY productname ;


--3.	Analyze the product_id column and take out the three parts composing 
---the product_id in three differentcolumns.

select product.productid,
	split_part(productid, '-', 1) as c1,
	split_part(productid, '-', 2) as c2,
	split_part(productid, '-', 3) as c3
	from product; 

--4.	List down comma separated product name where sub-category is either Chairs or tables.



select * from product where  productname like '%,%' AND (subcategory = 'Chairs' or subcategory = 'Tables') ; 
 
 
--Mathematical functions: -
--1.	You are running a lottery for your customers. So, pick a list of 5 lucky customers from 
--customer table using random function.

SELECT * FROM customer ORDER BY RANDOM() limit 5;


--2.	Suppose you cannot charge the customer in fraction points. So, for sales value of 1.63, you 
--will get either 1 (or) 2. In such a scenario, find out.
--1.  Total sales revenue if you are charging the lower integer value of sales always.

select sum(floor(sales)) as down_round from sales;

--2. Total sales revenue if you are charging the higher integer value is sales always.
select sum(ceiling(sales)) as up_round from sales;

--3. Total sales revenue if you are rounding-off the sales always.
select sum(Round(sales,0)) as round from sales;



--Date & Time functions: -
--1.	 Find out the current age of “batman” who was born on “April 6,1939” in Years, months and days

SELECT current_date, AGE(timestamp '1939-04-06');

--2.	Analyze and find out the monthly sales of sub-category chair. 
--Do you Observe any seasonality in sales of this sub-category.
 select * from product where subcategory = 'Chairs'  ;
SELECT (orderdate) AS Year, 
(orderdate) AS Month,SUM(Sales) 
AS TotalSales FROM sales   
GROUP BY (orderdate), (orderdate) ; 

SELECT YEAR(orderdate) AS Year from sales;

--Joins
--	Run the below query to create the datasets.

select* from sales
select * from customer
/* Customers with ages between 20 and 60 */
create table customer_20_60 as select * from customer where age between 20 and 60;
select count (*) from customer_20_60;
select * from customer_20_60;

2.--	Find the total sales done in every state 


select state,sum(sales.sales),sum(sales.profit) as profit from customer full join sales on sales.customerid = customer.customerid 
where sales >0  group by state ;

--3.	Get data containing Product_id, Product name, category, total sales value of that product, and total quantity sold. 
--(Use sales and product tables)



select product.productid,product.productname,product.category,sales.sales from product full outer join sales 
on
product.productid=sales.productid
 
select * from  product
select * from  sales


