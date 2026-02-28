SELECT
    DATE_FORMAT(end_date, '%Y-%m') AS churn_month,
    COUNT(*) AS churned_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM subscriptions), 2) AS churn_rate_percent
FROM subscriptions
WHERE status = 'churned'
    AND end_date IS NOT NULL
GROUP BY DATE_FORMAT(end_date, '%Y-%m')
ORDER BY churn_month;
