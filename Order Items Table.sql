--Viewing the order details table
SELECT * FROM dbo.order_details

--What is the number of total orders made
SELECT COUNT(DISTINCT order_id) FROM dbo.order_details

--What is the date range of the table
SELECT 
MIN(order_date) AS 'First order date',
MAX(order_date) AS 'last order date'
FROM dbo.order_details

--How many items were ordered within this date range
SELECT COUNT(*)
FROM dbo.order_details

--Which orders had the most number of items
SELECT order_id,COUNT(item_id) AS no_of_items
FROM dbo.order_details
GROUP BY order_id
ORDER BY no_of_items DESC

--To list all the orders that had more than 12 items
SELECT order_id,COUNT(item_id) AS no_of_items
FROM dbo.order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12
ORDER BY no_of_items DESC

--To find the exact count of orders that had more than 12 items
SELECT COUNT(*)
FROM (
    SELECT order_id
    FROM dbo.order_details
    GROUP BY order_id
    HAVING COUNT(item_id) > 12
) AS OrdersWithMoreThan12Items
