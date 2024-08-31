SELECT 
    customer_state AS State,
    CAST(AVG(JULIANDAY(STRFTIME('%Y-%m-%d', order_delivered_customer_date)) - JULIANDAY(order_estimated_delivery_date)) AS INTEGER) AS Delivery_Difference
FROM 
    olist_orders
JOIN 
    olist_customers ON olist_orders.customer_id = olist_customers.customer_id
WHERE 
    order_status = 'delivered' 
    AND order_delivered_customer_date IS NOT NULL
GROUP BY 
    customer_state
ORDER BY 
    Delivery_Difference DESC;