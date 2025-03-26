/*Scale Model Cars Database contains 8 tables which are 
products,productlines,orders,orderdetails,customers,payments,employees and offices.*/

-- Each table contains the following information.
/*
    Customers: customer data
   Employees: all employee information
    Offices: sales office information
    Orders: customers' sales orders
    OrderDetails: sales order line for each sales order
    Payments: customers' payment records
    Products: a list of scale model cars
    ProductLines: a list of product line categories */
	
-- Relational tables in this database are linked through the following common attributes.
/* products and orderdetails tables are linked through the common attribute "productCode".
     products and productlines tables are linked through the common attribute "productLine".
     orders and orderdetails tables are linked through the common attribute "orderNumber".
      customers and orders tables are linked through the common attribute "customerNumber".
      customers and payments tables are linked through the common attribute "customerNumber".
	  customers and employees tables are linked through the common attributes "employeeNumber" or " salesRepEmployeeNumber".
	  employees  table  self reference the table  table itself for attributes "employeeNumber" and "reportsTo".
	  employees and offices tables are linked through the common attribute "officeCode".*/
	  
	-- Code for Table Description is as follows;
	
SELECT "Customers" AS table_name, 
(SELECT COUNT(*) 
FROM pragma_table_info('customers')) AS number_of_attributes,
(SELECT COUNT(*) 
FROM customers)AS number_of_rows

UNION ALL 

SELECT "Products" AS table_name,
(SELECT COUNT(*)
 FROM pragma_table_info('products')) AS number_of_attributes,
(SELECT COUNT (*)
 FROM products) AS number_of_rows
 
UNION ALL  
 
 SELECT "ProductLines" AS table_name,
(SELECT COUNT(*)
 FROM pragma_table_info('productLines')) AS number_of_attributes,
(SELECT COUNT (*)
 FROM ProductLines) AS number_of_rows
 
UNION ALL 

SELECT "Orders" AS table_name,
(SELECT COUNT(*)
 FROM pragma_table_info('orders')) AS number_of_attributes, 
(SELECT COUNT (*)
 FROM orders) AS number_of_rows
 
 
 UNION ALL 
 
 SELECT "OrderDetails" AS table_name,
(SELECT COUNT(*)
 FROM pragma_table_info('orderDetails')) AS number_of_attributes, 
(SELECT COUNT (*)
 FROM products) AS number_of_rows
 
 
 UNION ALL 
 
 SELECT "Payments" AS table_name,
(SELECT COUNT(*)
 FROM pragma_table_info('payments')) AS number_of_attributes, 
(SELECT COUNT (*)
 FROM payments) AS number_of_rows
 
 UNION ALL 
 
 SELECT "Employees" AS table_name,
(SELECT COUNT(*)
 FROM pragma_table_info('Employees')) AS number_of_attributes,
(SELECT COUNT (*)
 FROM employees) AS number_of_rows
 
 
 UNION ALL 
 
 SELECT "Offices" AS table_name,
(SELECT COUNT(*)
 FROM pragma_table_info('offices')) AS number_of_attributes,
(SELECT COUNT (*)
 FROM offices) AS number_of_rows;
 

/*--Prioriy products for restocking 
-- Priority products for restocking was found out as the products that have high performance and in the brink of being out of stock .
--low_stock = SUM( quantityOrdered)/quantityInStock
--product_performance= SUM(quantityOrdered * priceEach) 
--In order to find this products and orderdetails tables are joined using correlated query, this can also be done using a INNER JOIN */

WITH 
low_stock AS(

SELECT p.productName, p.productCode,p.productLine,
(SELECT ROUND(SUM(od.quantityOrdered)/p.quantityInStock*1.0,2)
 FROM orderdetails AS od 
 WHERE od.productCode=p.productCode)AS refill
 FROM products AS p 
 GROUP BY productCode
 ORDER BY refill DESC
 LIMIT 10
 ),

product_performance AS(
SELECT od.productCode,SUM(quantityOrdered*priceEach) AS product_sales
FROM orderdetails AS od
GROUP BY productCode
ORDER BY product_sales DESC   
LIMIT 10
)

SELECT s.productName,s.productLine
FROM low_stock AS s
WHERE s.productCode IN ( SELECT productCode
                         FROM product_performance)
                         
LIMIT 10;                        

													  
 --Top five VIP customers 
WITH 
customer_profit AS 
(SELECT o.customerNumber, SUM(quantityOrdered * (priceEach - buyPrice)) AS profit
  FROM products p
  JOIN orderdetails od
    ON p.productCode = od.productCode
  JOIN orders o
    ON o.orderNumber = od.orderNumber
 GROUP BY o.customerNumber)

SELECT contactLastName,contactFirstName,city,country,cp.profit
FROM customers AS c
JOIN customer_profit AS cp
ON cp.customerNumber=c.customerNumber
ORDER BY cp.profit DESC
LIMIT 5; 

--Top five least-engaging customers 
WITH 
customer_profit AS 
(SELECT o.customerNumber, SUM(quantityOrdered * (priceEach - buyPrice)) AS profit
  FROM products p
  JOIN orderdetails od
    ON p.productCode = od.productCode
  JOIN orders o
    ON o.orderNumber = od.orderNumber
 GROUP BY o.customerNumber)

SELECT contactLastName,contactFirstName,city,country,cp.profit
FROM customers AS c
JOIN customer_profit AS cp
ON cp.customerNumber=c.customerNumber
ORDER BY cp.profit 
LIMIT 5;

--AVG profit genertaed by customers 
 WITH 
customer_profit AS 
(SELECT o.customerNumber, SUM(quantityOrdered * (priceEach - buyPrice)) AS profit
  FROM products p
  JOIN orderdetails od
    ON p.productCode = od.productCode
  JOIN orders o
    ON o.orderNumber = od.orderNumber
 GROUP BY o.customerNumber)
 
 SELECT AVG(profit) AS avg_profit 
 FROM customer_profit;

/* Based on the analysis, Product Line of "Classic cars"  have the highest performance with the lowest stock. 
1968 Ford Mustang is the product that has the highest demand.
Top five VIP customers are from countries Spain, USA, Australia and France.
 Top two VIP customers have generated a profit above 200,000 which is significantly higher value compared to profit
 generated by next top three VIP customers which is in the range of 60,000- 73,000.
 Least engaged customers are from the countries USA,Italy, France and UK in which the least generated profit by a customer is below 3000.
 Hence the company has generated an average profit of 39039.594388 from a customer in their LTV, investing on acquiring more customers 
 to the cmpany could increase the profit generated, with taking critical factors such as
  country with highest sales,  year-month that most sales happened in to consideraion. */
 
