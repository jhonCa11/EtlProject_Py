WITH delivery_times AS (
    SELECT DISTINCT
        order_id,
        CAST(STRFTIME('%m', order_purchase_timestamp) AS INTEGER) AS month_no,
        STRFTIME('%Y', order_purchase_timestamp) AS year,
        JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_purchase_timestamp) AS real_time,
        JULIANDAY(order_estimated_delivery_date) - JULIANDAY(order_purchase_timestamp) AS estimated_time
    FROM 
        olist_orders
    WHERE 
        order_status = 'delivered' 
        AND order_delivered_customer_date IS NOT NULL
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
    AVG(CASE WHEN year = '2016' THEN real_time END) AS Year2016_real_time,
    AVG(CASE WHEN year = '2017' THEN real_time END) AS Year2017_real_time,
    AVG(CASE WHEN year = '2018' THEN real_time END) AS Year2018_real_time,
    AVG(CASE WHEN year = '2016' THEN estimated_time END) AS Year2016_estimated_time,
    AVG(CASE WHEN year = '2017' THEN estimated_time END) AS Year2017_estimated_time,
    AVG(CASE WHEN year = '2018' THEN estimated_time END) AS Year2018_estimated_time
FROM 
    delivery_times
GROUP BY 
    month_no
ORDER BY 
    month_no;