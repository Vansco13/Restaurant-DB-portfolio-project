USE [Restaurant Db]


--To look at all the items in the menu
SELECT * 
FROM dbo.menu_items

--Finding the number of items on the menu
SELECT COUNT(*) AS num_menu_items
FROM dbo.menu_items 

--To determine the number of distinct menu items that are in the restaurant
SELECT COUNT(DISTINCT item_name) AS Num_distinct_menu_items
FROM dbo.menu_items

--To determine the number of categories I have in my menu
SELECT COUNT(DISTINCT category) AS No_of_categories
FROM dbo.menu_items

--To list out each individual category
SELECT DISTINCT category
FROM dbo.menu_items

--To count different menu items based on their category
SELECT  category, COUNT(menu_item_id) AS num_items
FROM dbo.menu_items
GROUP BY category


--To find the most and least expensive Items in the menu
SELECT item_name, price
FROM dbo.menu_items
ORDER BY price DESC

--How many italian dishes are on the menu
SELECT COUNT(item_name) AS No_of_Italian_dishes
FROM dbo.menu_items
WHERE category= 'Italian' -- You can replace with whatever category you wish

--What are the least and most expensive Italian dishes on the menu
SELECT *
FROM dbo.menu_items
WHERE category= 'Italian'--You can replace with whatever category you wish
ORDER BY price DESC

--What is the average dish price within each category
SELECT category,ROUND(AVG(price),2) AS Average_price
FROM dbo.menu_items
GROUP BY category
ORDER BY Average_price DESC

--Viewing the order details table
SELECT * FROM dbo.order_details

--What is the date range of the table
SELECT 
MIN(order_date) AS 'First order date',
MAX(order_date) AS 'last order date'
FROM dbo.order_details


--What is the number of total orders made & items ordered during this period?

SELECT MIN(order_date) AS 'First order date',
MAX(order_date) AS 'last order date',
COUNT(DISTINCT order_id) AS Tot_Num_orders, 
COUNT(*) AS Total_no_of_ordered_items
 FROM dbo.order_details

--Which day had the most orders?
SELECT order_date, COUNT(DISTINCT order_id) AS Num_orders
 FROM dbo.order_details
 GROUP BY order_date--To be visualized

--Which orders had the most number of items
SELECT order_id,COUNT(item_id) AS no_of_items
FROM dbo.order_details
GROUP BY order_id
ORDER BY no_of_items DESC



--List the orders that had more than 12 items
SELECT order_id,COUNT(item_id) AS no_of_items
FROM dbo.order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12
ORDER BY no_of_items DESC

--How many orders had more than 12 items (exact number)
SELECT COUNT(*) AS orders_with_more_than_12_items
FROM (
    SELECT order_id
    FROM dbo.order_details
    GROUP BY order_id
    HAVING COUNT(item_id) > 12
) AS subquery

--Analysis on combined data
--Retrieve both tables
SELECT * FROM dbo.menu_items
SELECT * FROM dbo.order_details 

--Combine both tables
SELECT * 
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id

--What is the number of total orders made, items ordered and revenue generated within this period?
SELECT MIN(order_date) AS 'First order date',
MAX(order_date) AS 'last order date',
COUNT(DISTINCT order_id) AS Tot_Num_orders, 
COUNT(*) AS Total_no_of_ordered_items,
ROUND(SUM(price),2) AS Tot_revenue
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id


--Which category had the most orders?
SELECT  category, COUNT(order_details_id) AS Num_items_ordered
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
WHERE category IS NOT NULL
GROUP BY category
ORDER BY Num_items_ordered DESC


--What were the least and most ordered items? What category were they in?
	SELECT [item_name],
	[category],
	COUNT([order_details_id]) AS num_purchases
	FROM [dbo].[order_details]
	LEFT JOIN [dbo].[menu_items]
	ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
	GROUP BY [item_name],[category]
	ORDER BY num_purchases ASC

--What were the top 5 orders that spent the most money

	SELECT TOP (5) [order_id],[category],ROUND(SUM([price]),2) AS tot_spend
	FROM [dbo].[order_details]
	LEFT JOIN [dbo].[menu_items]
	ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
	GROUP BY [order_id],[category]
	ORDER BY tot_spend DESC
	
--View the details of the highest spend order
SELECT * 
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
WHERE [order_id]= 440

--What category did they order the most from?
SELECT [category], COUNT([item_id]) AS Items_ordered
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
WHERE [order_id]= 440
GROUP BY [category]
ORDER BY Items_ordered DESC

--How much did they spend spend on each category?
SELECT [category], COUNT([item_id]) AS Items_ordered,SUM(price) AS total_spent
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
WHERE [order_id]= 440
GROUP BY [category]
ORDER BY total_spent DESC

--View the details of the top 5 highest spend orders
SELECT [order_id],[category],COUNT([item_id]) AS num_items
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id  
WHERE [order_id] IN (440,4232,2547,2075,17)
GROUP BY [order_id],[category]
ORDER BY [order_id]

--Get insights based on the consumer behaviors





