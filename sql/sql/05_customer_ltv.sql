SELECT
    c.plan_type,
    ROUND(AVG(s.mrr), 2) AS avg_mrr,
    ROUND(AVG(DATEDIFF(
        COALESCE(s.end_date, '2023-12-31'), s.start_date
    ) / 30), 1) AS avg_months_active,
    ROUND(AVG(s.mrr) * AVG(DATEDIFF(
        COALESCE(s.end_date, '2023-12-31'), s.start_date
    ) / 30), 2) AS customer_lifetime_value
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY c.plan_type
ORDER BY customer_lifetime_value DESC;
