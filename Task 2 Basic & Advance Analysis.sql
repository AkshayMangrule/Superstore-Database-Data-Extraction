 /*Right click on Schemas Section on Left hand section and select Set as Default Schema*/

/*1.Write a query to display the Customer_Name and Customer Segment using alias
name “Customer Name", "Customer Segment" from table Cust_dimen. */
SELECT 
    customer_name AS 'Customer Name',
    customer_segment AS 'Customer Segment'
FROM
    cust_dimen;
    -----------------------------------------------------------------------------------------------
/*2.Write a query to find all the details of the customer from the table cust_dimen
order by desc.*/
SELECT 
    *
FROM
    cust_dimen
ORDER BY Customer_Name DESC;

--------------------------------------------------------------------------------------------------------------------------------
/*3. Write a query to get the Order ID, Order date from table orders_dimen where
‘Order Priority’ is high.*/
SELECT 
    order_id AS 'Order Id', order_date AS 'Order Date'
FROM
    orders_dimen
WHERE
    Order_Priority = 'high';
  
  ----------------------------------------------------------------------------------------------------------------------------------------
/*4.Find the total and the average sales (display total_sales and avg_sales) */
SELECT 
    SUM(sales) AS Total_sales, AVG(sales) AS avg_sales
FROM
    market_fact;
   
   ------------------------------------------------------------------------------------------------------------------------------------
/*5.Write a query to get the maximum and minimum sales from maket_fact table*/
SELECT 
    MAX(sales) AS maximum_sale, MIN(sales) AS minimum_sale
FROM
    market_fact;
------------------------------------------------------------------------------------------------------------------------------------------------------    
/*6.Display the number of customers in each region in decreasing order of
no_of_customers. The result should contain columns Region, no_of_customers*/
SELECT 
    Region, COUNT(cust_id) AS 'No Of Customers'
FROM
    cust_dimen
GROUP BY region
ORDER BY COUNT(cust_id) DESC;

-------------------------------------------------------------------------------------------------------------------------------------------------
/*7.Find the region having maximum customers (display the region name and
max(no_of_customers)*/
SELECT 
    Region, COUNT(cust_id) AS 'Max(no_of_customers)'
FROM
    cust_dimen
GROUP BY region
 ORDER BY COUNT(cust_id) DESC;
 
 ---------------------------------------------------------------------------------------------------------------------------------------------
/*8.Find all the customers from Atlantic region who have ever purchased ‘TABLES’
and the number of tables purchased (display the customer name, no_of_tables
purchased)*/
SELECT 
    c.customer_name AS 'Customer Name', COUNT(m.prod_id) AS 'NO Of Tables Purchased'
FROM
    cust_dimen AS c
        JOIN
    market_fact AS m ON c.Cust_id = m.Cust_id
        JOIN
    prod_dimen AS p ON m.Prod_id = p.Prod_id
WHERE
    p.Product_sub_category = 'tables'
        AND c.region = 'atlantic'
GROUP BY c.Customer_Name;

------------------------
SELECT 
    c.customer_name AS 'Customer Name', COUNT(m.prod_id) AS 'NO Of Tables Purchased'
FROM
    cust_dimen AS c
        JOIN
    market_fact AS m ON c.cust_id = m.cust_id
WHERE
    c.region = 'atlantic'
        AND Prod_id = 'PROD_11'
GROUP BY c.Customer_Name;

---------------------------------------------------------------------------------------------------------------------------------------------------
/*9.Find all the customers from Ontario province who own Small Business. (display
the customer name, no of small business owners)*/
SELECT 
    Customer_name AS 'Customer Name',
    COUNT(customer_segment) AS 'No Of Small Business Owners'
FROM
    cust_dimen
WHERE
    Province = 'Ontario'
        AND customer_segment = 'small business'
GROUP BY Customer_Name;

--------------------------------------------------------------------------------------------------------------------------------------------------------
/*10.Find the number and id of products sold in decreasing order of products sold
(display product id, no_of_products sold) */
SELECT 
    p.prod_id AS 'Product Id', COUNT(m.prod_id) AS 'No Of Product Sold'
FROM
    prod_dimen AS p
        JOIN
    market_fact AS m ON p.prod_id = m.prod_id
WHERE
    p.Prod_id = m.Prod_id
GROUP BY p.Prod_id
ORDER BY COUNT(m.prod_id) DESC;

---------------------------------------------------------------------------------------------------------------------------------------------
/*11.Display product Id and product sub category whose produt category belongs to
Furniture or Technlogy. The result should contain columns product id, product
sub category*/
SELECT 
    prod_id AS 'Product Id',
    product_sub_category AS 'Product Sub Category' 
FROM
    prod_dimen
WHERE
    product_category = 'furniture'
        OR Product_Category = 'technology';
  
  -----------------------------------------------------------------------------------------------------------------------------------------------
/*12.Display the product categories in descending order of profits (display the product
category wise profits i.e. product_category, profits)?*/
SELECT 
    p.product_category AS 'Product Category', ROUND(SUM(m.profit),2) AS 'Profits'
FROM
    prod_dimen AS p
        JOIN
    market_fact AS m ON p.prod_id = m.prod_id
GROUP BY p.Product_Category
ORDER BY m.profit DESC;

-------------------------------------------------------------------------------------------------------------------------------------------------
/*13.Display the product category, product sub-category and the profit within each
subcategory in three columns. */
SELECT 
    p.product_category AS 'Product Category',
    p.product_sub_category AS 'Product Sub Category',
    SUM(m.profit) AS 'Profits'
FROM
    prod_dimen AS p
        JOIN
    market_fact AS m ON m.Prod_id = p.Prod_id
GROUP BY p.Product_sub_Category
ORDER BY p.Product_Category;

-------------------------------------------------------------------------------------------------------------------------------------------------
/*14.Display the order date, order quantity and the sales for the order.*/
SELECT 
    o.Order_date AS 'Order Date',
    SUM(m.order_quantity) AS 'Order Quantity',
    m.sales AS 'Sales'
FROM
    orders_dimen o
        JOIN
    market_fact m ON o.Ord_ID = m.ord_id
GROUP BY m.ord_id;

---------------------------------------------------------------------------------------------------------------------------------------------------
/*15.Display the names of the customers whose name contains the
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’*/
SELECT 
    Customer_name AS 'Customer Name'
FROM
    cust_dimen
WHERE
    Customer_Name LIKE '_R%' OR '___D%';
    
--------------------------------------------------
SELECT 
    Customer_name AS 'Customer Name'
FROM
    cust_dimen
WHERE
    customer_name REGEXP '^.R' OR '^...D';
    
-------------------------------------------------------------------------------------------------------------------------------------------
/*16.Write a SQL query to make a list with Cust_Id, Sales, Customer Name and
their region where sales are between 1000 and 5000*/
SELECT 
    c.cust_id AS 'Cust Id',
    m.sales AS 'Sales',
    c.customer_name AS 'Customer Name',
    c.Region
FROM
    cust_dimen c
        JOIN
    market_fact m ON c.cust_id = m.Cust_id
WHERE
    m.sales BETWEEN 1000 AND 5000
GROUP BY c.Cust_id;

---------------------------------------------------------------------------------------------------------------------------------------------------
/*17.Write a SQL query to find the 3rd highest sales.*/
SELECT 
    sales
FROM
    market_fact
ORDER BY sales DESC
LIMIT 1 OFFSET 2;
---------------------------------------------------------------------
SELECT 
    sales
FROM
    market_fact
ORDER BY sales DESC
LIMIT 2 , 1;

--------------------------------------------------------------------------------------------------------------------------------
/*18.Where is the least profitable product subcategory shipped the most? For the least
profitable product sub-category, display the region-wise no_of_shipments and the 
profit made in each region in decreasing order of profits (i.e. region,
no_of_shipments, profit_in_each_region)*/

SELECT 
    c.Region AS 'Region',
    COUNT(DISTINCT m.Ship_id) AS 'No of Shipments',
    ROUND(SUM(m.Profit), 2) AS 'Profit In Each Region'
FROM
    market_fact m
        JOIN
    cust_dimen c ON m.Cust_id = c.Cust_id
        JOIN
    prod_dimen p ON m.Prod_id = p.Prod_id
WHERE
    Product_Sub_Category = (SELECT 
            p.Product_Sub_Category
        FROM
            market_fact m
                JOIN
            prod_dimen p ON m.Prod_id = p.Prod_id
        GROUP BY Product_Sub_Category
        ORDER BY SUM(m.Profit)
        LIMIT 1)
GROUP BY c.Region
ORDER BY SUM(m.Profit) DESC; 
--------------------------------------------------------------------------/*THANK YOU*/----------------------------------------------------------------------------------------------------------
