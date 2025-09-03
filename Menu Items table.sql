USE [Restaurant Db]
UPDATE dbo.menu_items
SET price = CAST(ROUND(price, 2) AS DECIMAL(10, 2));

--To look at all the items in the menu
SELECT * ,FORMAT(price,'0.00') AS  'Formatted Price'
FROM dbo.menu_items

--Finding the number of items on the menu
SELECT COUNT(*) FROM dbo.menu_items

--To determine the number of distinct menu items that are in the restaurant
SELECT COUNT(DISTINCT item_name)
FROM dbo.menu_items

--To determine the number of categories I have in my menu
SELECT COUNT(DISTINCT category)
FROM dbo.menu_items

--To list out each individual category
SELECT DISTINCT category
FROM dbo.menu_items

--To count different menu items based on their category
SELECT  COUNT(*)item_name
FROM dbo.menu_items
WHERE category= 'American'
GROUP BY category


--To find the most and least expensive Items in the menu
SELECT item_name,FORMAT(price,'0.00') AS Formatted_Price
FROM dbo.menu_items
ORDER BY price DESC

--How many italian dishes are on the menu
SELECT COUNT(item_name)
FROM dbo.menu_items
WHERE category= 'Italian'

--What are the least and most expensive Italian dishes on the menu
SELECT *
FROM dbo.menu_items
WHERE category= 'Italian'
ORDER BY price DESC

--How many dishes are in each category
SELECT COUNT(menu_item_id) AS 'No of items',category
FROM dbo.menu_items
GROUP BY category

--What is the average dish price within each category
SELECT category,AVG(price) AS Average_price
FROM dbo.menu_items
GROUP BY category
ORDER BY Average_price DESC


