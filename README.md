# Product-Analysis-using-SQL-Dataquest
## Project Description 
The focus of this project is to analyze data from sales record database and extract key performance indicators (KPI)s that help make data driven decisions regarding the product. In this project, a model cars database is been analyzed, to derrive KPIs in order to understand which cars should be ordered less or more, how the company should tailor the communication and strategies to customer behavior and how much should be spent on acquiring new customers. 
## Database 
The relational ![database schema](model_car_schema.png) shows how each tables are related. Each table includes the follwoing information. 
    
- **Customers**: customer data
- **Employees**: all employee information
- **Offices**: sales office information
- **Orders**: customers' sales orders
- **OrderDetails**: sales order line for each sales order
- **Payments**: customers' payment records
- **Products**: a list of scale model cars
- **ProductLines**: a list of product line categories
## Query Explaination

### 1. Calculating the number of attributes and rows in each table

In order to analyze the information about each table **PRAGMA_table_info(<table_name>)** SQL statement was used. The results of this SQL query would be a table containing a row for each column of the table which describes the data in the cloumn. The output for the *payment* table would look like as below:

|cid|name|type|notnull|dflt_value|pk|
|--|--|--|--|--|--|
|0|customerNumber|INTEGER|1| |1|
|1|checkNumber|nvarchar(50)|1| |2|
|2|paymentDate|date|1| | 0|
|3|amount|numeric(10,2)|1| |0 |

Each column of the above table explains : 
- **name** : Name of the attributes of the table 
- **type** : The data type of the each attribute
- **notnull** : signifies whether the column has been created as a notnull column or not
- **dflt**: Any default values that were passed during the creation of the table
- **pk**: Signifies wheter a particular column has been used as a primary key. Boolean values are used to represent the result.

Number of attributes for each table is calculated  using the **COUNT** SQL aggregation on the table derrived from PRAGMA table_info query. The number of rows for each table is  calculated by quering the **COUNT** SQL aggregation on each table individually. Finally the above results from each table and their table names are consolidated using the **UNION ALL** SQL aggregation and represented in a tabular format. 

### 2. Identifying restock products 
Priority products that need to be restocked are the best selling products and the ones that are in the brink of being  out of stock. To avoid the best selling product going out of stock, the product performance should be tracked, while low stock items should be tracked to avoid any product being out of the stock. 

The **low stock** is defined as : 

```low stock = SUM(product Quantity Ordered)/ ( Quantity of product in stock) ```

The **product performance** is defined as : 

``` product performance = SUM(Quantity orderd x Selling price of eacg unit) ```

 To identify restock products, **Common Table Expression(CTE)** are created for *low_stock* and *product_performance*, using **products** and **orderdetails** tables.Then **IN** operator was used to find the products which are common in both CTEs, by filtering them using the common **productCode** which is the foreign key between **products*8 and **orderdetails** table.






