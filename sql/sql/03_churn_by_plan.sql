SELECT
    c.plan_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN s.status = 'churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN s.status = 'churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_percent,
    AVG(s.mrr) AS avg_mrr
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY c.plan_type
ORDER BY churn_rate_percent DESC;
