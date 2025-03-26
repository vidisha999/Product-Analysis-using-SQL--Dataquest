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
## Query Explnation

### 1. Calculating the number of attributes and rows in each table

In order to analyze the information about each table **PRAGMA_table_info(<table_name>)** SQL statement was used. The results of this SQL query would be a table containing a row for each column of the table which describes the data in the cloumn. The output would look like as in the table below, 
|cid|name|type|notnull|dflt_value|pk|












