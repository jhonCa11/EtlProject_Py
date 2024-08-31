WITH monthly_revenue AS (
    SELECT 
        CAST(STRFTIME('%m', order_purchase_timestamp) AS INTEGER) AS month_no,
        STRFTIME('%Y', order_purchase_timestamp) AS year,
        SUM(payment_value) AS revenue
    FROM 
        olist_orders
    JOIN 
        olist_order_payments ON olist_orders.order_id = olist_order_payments.order_id
    GROUP BY 
        year, month_no
)
SELECT 
    month_no,
    CASE 
        WHEN month_no = 1 THEN 'Jan'
        WHEN month_no = 2 THEN 'Feb'
        WHEN month_no = 3 THEN 'Mar'
        WHEN month_no = 4 THEN 'Apr'
        WHEN month_no = 5 THEN 'May'
        WHEN month_no = 6 THEN 'Jun'
        WHEN month_no = 7 THEN 'Jul'
        WHEN month_no = 8 THEN 'Aug'
        WHEN month_no = 9 THEN 'Sep'
        WHEN month_no = 10 THEN 'Oct'
        WHEN month_no = 11 THEN 'Nov'
        WHEN month_no = 12 THEN 'Dec'
    END AS month,
    COALESCE(SUM(CASE WHEN year = '2016' THEN revenue END), 0.00) AS Year2016,
    COALESCE(SUM(CASE WHEN year = '2017' THEN revenue END), 0.00) AS Year2017,
    COALESCE(SUM(CASE WHEN year = '2018' THEN revenue END), 0.00) AS Year2018
FROM 
    monthly_revenue
GROUP BY 
    month_no
ORDER BY 
    month_no;