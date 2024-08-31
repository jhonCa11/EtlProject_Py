SELECT 
    pct.product_category_name_english AS Category,
    COUNT(DISTINCT o.order_id) AS Num_order,
    SUM(op.payment_value) AS Revenue
FROM 
    olist_orders o
JOIN 
    olist_order_items oi ON o.order_id = oi.order_id
JOIN 
    olist_products p ON oi.product_id = p.product_id
JOIN 
    product_category_name_translation pct ON p.product_category_name = pct.product_category_name
JOIN 
    olist_order_payments op ON o.order_id = op.order_id
WHERE 
    o.order_status = 'delivered' 
    AND o.order_delivered_customer_date IS NOT NULL
    AND pct.product_category_name_english IS NOT NULL
GROUP BY 
    pct.product_category_name_english
ORDER BY 
    Revenue ASC
LIMIT 10;

