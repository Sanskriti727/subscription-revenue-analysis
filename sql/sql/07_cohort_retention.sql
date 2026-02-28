SELECT
    DATE_FORMAT(c.signup_date, '%Y-%m') AS cohort_month,
    COUNT(DISTINCT c.customer_id) AS cohort_size,
    ROUND(SUM(CASE WHEN DATEDIFF(COALESCE(s.end_date, '2023-12-31'), c.signup_date) >= 90 
        THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT c.customer_id), 1) AS retained_3_months,
    ROUND(SUM(CASE WHEN DATEDIFF(COALESCE(s.end_date, '2023-12-31'), c.signup_date) >= 180 
        THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT c.customer_id), 1) AS retained_6_months,
    ROUND(SUM(CASE WHEN DATEDIFF(COALESCE(s.end_date, '2023-12-31'), c.signup_date) >= 365 
        THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT c.customer_id), 1) AS retained_12_months
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY DATE_FORMAT(c.signup_date, '%Y-%m')
ORDER BY cohort_month;
