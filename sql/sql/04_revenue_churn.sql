SELECT
    c.plan_type,
    SUM(CASE WHEN s.status = 'churned' THEN s.mrr ELSE 0 END) AS churned_mrr,
    SUM(CASE WHEN s.status = 'active' THEN s.mrr ELSE 0 END) AS active_mrr,
    ROUND(SUM(CASE WHEN s.status = 'churned' THEN s.mrr ELSE 0 END) * 100.0 /
    SUM(s.mrr), 2) AS revenue_churn_percent
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY c.plan_type
ORDER BY churned_mrr DESC;
