SELECT 
    c.customer_state,
    SUM(op.payment_value) AS Revenue
FROM 
    olist_orders o
JOIN 
    olist_customers c ON o.customer_id = c.customer_id
JOIN 
    olist_order_payments op ON o.order_id = op.order_id
WHERE 
    o.order_status = 'delivered' 
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 
    c.customer_state
ORDER BY 
    Revenue DESC
LIMIT 10;