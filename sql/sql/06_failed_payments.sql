SELECT
    COUNT(DISTINCT s.customer_id) AS total_churned,
    COUNT(DISTINCT CASE 
        WHEN p.payment_status = 'failed' 
        AND p.payment_date >= DATE_SUB(s.end_date, INTERVAL 30 DAY)
        THEN s.customer_id 
    END) AS churned_with_failed_payment,
    ROUND(COUNT(DISTINCT CASE 
        WHEN p.payment_status = 'failed' 
        AND p.payment_date >= DATE_SUB(s.end_date, INTERVAL 30 DAY)
        THEN s.customer_id 
    END) * 100.0 / COUNT(DISTINCT s.customer_id), 2) AS percent_with_failed_payment
FROM subscriptions s
JOIN payments p ON s.customer_id = p.customer_id
WHERE s.status = 'churned'
AND s.end_date IS NOT NULL
AND s.end_date < '2023-12-01';
