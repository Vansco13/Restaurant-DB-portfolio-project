# Restaurant Data Analysis Project

## Project Overview

**Project Title**: Restaurant Data Analysis Project
**Database**: `Restaurant DB`

This is a SQL-based exploration of menu item perfomance and customer ordering behaviour.

## Objectives

1. **Set up a restaurant database**: Create and populate a restaurant database with menu and orders data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Restaurant Db`.
- **Table Creation**: A table named `menu_items`  and `order_details`  is created to store the sales data. 


### 2. Data Exploration & Cleaning

- **Record Check**: Look at all the records in the menu.
- **Item Count**: Find out how many unique items are in the menu.
- **Category Count**: Identify all unique item categories in the dataset.
- **Category Item Count**:To count different menu items based on their category
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT * 
FROM dbo.menu_items

SELECT COUNT(*) AS num_menu_items
FROM dbo.menu_items 

SELECT COUNT(DISTINCT category) AS No_of_categories
FROM dbo.menu_items

SELECT  category, COUNT(menu_item_id) AS num_items
FROM dbo.menu_items
GROUP BY category

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **What is the average dish price within each category**:
```sql

SELECT category,ROUND(AVG(price),2) AS Average_price
FROM dbo.menu_items
GROUP BY category
ORDER BY Average_price DESC

```

2. **What is the number of total orders made & items ordered during this period?**:
```sql

SELECT MIN(order_date) AS 'First order date',
MAX(order_date) AS 'last order date',
COUNT(DISTINCT order_id) AS Tot_Num_orders, 
COUNT(*) AS Total_no_of_ordered_items
 FROM dbo.order_details

```

3. **Which day had the most orders?**:
```sql

SELECT order_date, COUNT(DISTINCT order_id) AS Num_orders
 FROM dbo.order_details
 GROUP BY order_date

```

4. **Which orders had the most number of items**:
```sql
SELECT order_id,COUNT(item_id) AS no_of_items
FROM dbo.order_details
GROUP BY order_id
ORDER BY no_of_items DESC
```

5. **Identifies high volume orders useful for targeting bulk promotions or group deals**:
```sql
SELECT order_id,COUNT(item_id) AS no_of_items
FROM dbo.order_details
GROUP BY order_id
HAVING COUNT(item_id) > 12
ORDER BY no_of_items DESC
```

6. **What is the number of total orders made, items ordered and revenue generated within this period?**:
```sql
SELECT MIN(order_date) AS 'First order date',
MAX(order_date) AS 'last order date',
COUNT(DISTINCT order_id) AS Tot_Num_orders, 
COUNT(*) AS Total_no_of_ordered_items,
ROUND(SUM(price),2) AS Tot_revenue
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
```

7. **Which category had the most items ordered?**:
```sql
SELECT  category, COUNT(order_details_id) AS Num_items_ordered
FROM [dbo].[order_details] od 
LEFT JOIN [dbo].[menu_items] mi
ON od.item_id=mi.menu_item_id
WHERE category IS NOT NULL
GROUP BY category
ORDER BY Num_items_ordered DESC
```

8. **Which category generated the most revenue**:
```sql
SELECT  category,
ROUND(SUM(price), 2) AS Total_Revenue
FROM [dbo].[order_details] od 
LEFT JOIN [dbo].[menu_items] mi
ON od.item_id=mi.menu_item_id
WHERE category IS NOT NULL
GROUP BY category
ORDER BY Total_Revenue DESC
```

9. **What were the least and most ordered items? What category were they in?**:
```sql
	SELECT [item_name],
	[category],
	COUNT([order_details_id]) AS num_purchases
	FROM [dbo].[order_details] od
	LEFT JOIN [dbo].[menu_items] mi
	ON od.item_id=mi.menu_item_id
	GROUP BY [item_name],[category]
	ORDER BY num_purchases ASC
```

10. **What were the top 5 orders that spent the most money**:
```sql
SELECT TOP (5) [order_id],[category],ROUND(SUM([price]),2) AS tot_spend
	FROM [dbo].[order_details]
	LEFT JOIN [dbo].[menu_items]
	ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
	GROUP BY [order_id],[category]
	ORDER BY tot_spend DESC
```

11. **View the details of the top 5 highest spend ordersr**
```sql
SELECT [order_id],[category],COUNT([item_id]) AS num_items
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id  
WHERE [order_id] IN (440,4232,2547,2075,17)
GROUP BY [order_id],[category]
ORDER BY [order_id]
```

12. **View the details of the highest spend order**
```sql
SELECT * 
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
WHERE [order_id]= 440
```

13. **What category did they order the most from?**
```sql
SELECT [category], COUNT([item_id]) AS Items_ordered
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
WHERE [order_id]= 440
GROUP BY [category]
ORDER BY Items_ordered DESC
```

14. **How much did they spend spend on each category?**
```sql
SELECT [category], COUNT([item_id]) AS Items_ordered,SUM(price) AS total_spent
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
WHERE [order_id]= 440
GROUP BY [category]
ORDER BY total_spent DESC
```



## Findings

- **Order behaviour**: Reveals the most popular menu category, guiding inventory and marketing focus
- **High-Value Transactions**: Identifies the most valuable transactions, useful for understanding high spending customer behaviour
- **Revenue generation**: Reveals the most profitable categories, guiding menu strategy,pricing and marketing priorities.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Categories Summary**: A detailed report summarizing total sales, orders, and category performance.
- **Top customers spending habits**: Insights into their preferences and peak ordering times.
- **Business overview**: A summary of the total orders,purchases and revenue over the date range.

## Conclusion

This project serves as a means to understand customer behaviour, the best selling items, and the overall perfomance of the business during a given date range.

