SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS total_mrr
FROM payments
WHERE payment_status = 'success'
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;
