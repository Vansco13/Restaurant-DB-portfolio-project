--Retrieve both tables
SELECT * FROM dbo.menu_items
SELECT * FROM dbo.order_details 

--Combine both tables
SELECT * 
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id


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
SELECT [category], COUNT([item_id])
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id
WHERE [order_id]= 440
GROUP BY [category]

--View the details of the top 5 highest spend orders
SELECT [order_id],[category],COUNT([item_id]) AS num_items
FROM [dbo].[order_details]
LEFT JOIN [dbo].[menu_items]
ON [dbo].[order_details].item_id=[dbo].[menu_items].menu_item_id  
WHERE [order_id] IN (440,4232,2547,2075,17)
GROUP BY [order_id],[category]
ORDER BY [order_id]

--Get insights based on the consumer behaviors





