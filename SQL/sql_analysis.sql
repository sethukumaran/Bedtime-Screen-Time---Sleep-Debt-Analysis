-- Bedtime Screen Time & Sleep Debt Analysis
-- SQL dialect: PostgreSQL / ANSI-style SQL
-- Replace `bedtime_screentime_sleep_debt` with your table name.

-- 1. Dataset size and uniqueness
SELECT
    COUNT(*) AS total_users,
    COUNT(DISTINCT user_id) AS unique_users
FROM bedtime_screentime_sleep_debt;

-- 2. Data-quality checks
SELECT
    COUNT(*) FILTER (WHERE user_id IS NULL) AS null_user_id,
    COUNT(*) FILTER (WHERE age IS NULL) AS null_age,
    COUNT(*) FILTER (WHERE total_sleep_hours IS NULL) AS null_sleep,
    COUNT(*) FILTER (WHERE next_day_fatigue_score IS NULL) AS null_fatigue
FROM bedtime_screentime_sleep_debt;

-- 3. Overall KPI profile
SELECT
    COUNT(*) AS users,
    ROUND(AVG(bedtime_phone_minutes),2) AS avg_bedtime_phone_min,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(sleep_latency_min),2) AS avg_sleep_latency_min,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue,
    ROUND(AVG(morning_alarm_snoozes),2) AS avg_alarm_snoozes
FROM bedtime_screentime_sleep_debt;

-- 4. Sleep debt distribution
SELECT
    sleep_debt_category,
    COUNT(*) AS users,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),2) AS pct_users,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue
FROM bedtime_screentime_sleep_debt
GROUP BY sleep_debt_category
ORDER BY avg_sleep_hours DESC;

-- 5. Severe sleep debt by occupation
SELECT
    occupation_type,
    COUNT(*) AS users,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue,
    ROUND(
        100.0 * AVG(
            CASE WHEN sleep_debt_category = 'Severe Sleep Debt' THEN 1.0 ELSE 0.0 END
        ),2
    ) AS severe_debt_pct
FROM bedtime_screentime_sleep_debt
GROUP BY occupation_type
ORDER BY severe_debt_pct DESC;

-- 6. Chronotype comparison
SELECT
    chronotype,
    COUNT(*) AS users,
    ROUND(AVG(bedtime_phone_minutes),2) AS avg_phone_min,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue,
    ROUND(
        100.0 * AVG(
            CASE WHEN sleep_debt_category = 'Severe Sleep Debt' THEN 1.0 ELSE 0.0 END
        ),2
    ) AS severe_debt_pct
FROM bedtime_screentime_sleep_debt
GROUP BY chronotype
ORDER BY avg_fatigue DESC;

-- 7. Primary bedtime app analysis
SELECT
    primary_bedtime_app,
    COUNT(*) AS users,
    ROUND(AVG(bedtime_phone_minutes),2) AS avg_phone_min,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue,
    ROUND(
        100.0 * AVG(
            CASE WHEN sleep_debt_category = 'Severe Sleep Debt' THEN 1.0 ELSE 0.0 END
        ),2
    ) AS severe_debt_pct
FROM bedtime_screentime_sleep_debt
GROUP BY primary_bedtime_app
ORDER BY avg_fatigue DESC;

-- 8. Phone-use bands and outcomes
WITH segmented AS (
    SELECT *,
        CASE
            WHEN bedtime_phone_minutes <= 30 THEN '<=30 min'
            WHEN bedtime_phone_minutes <= 60 THEN '31-60 min'
            WHEN bedtime_phone_minutes <= 90 THEN '61-90 min'
            WHEN bedtime_phone_minutes <= 120 THEN '91-120 min'
            ELSE '>120 min'
        END AS phone_band
    FROM bedtime_screentime_sleep_debt
)
SELECT
    phone_band,
    COUNT(*) AS users,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(sleep_latency_min),2) AS avg_latency_min,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue,
    ROUND(
        100.0 * AVG(
            CASE WHEN sleep_debt_category = 'Severe Sleep Debt' THEN 1.0 ELSE 0.0 END
        ),2
    ) AS severe_debt_pct
FROM segmented
GROUP BY phone_band
ORDER BY MIN(bedtime_phone_minutes);

-- 9. Late caffeine analysis
WITH segmented AS (
    SELECT *,
        CASE
            WHEN caffeine_post_5pm_mg = 0 THEN '0 mg'
            WHEN caffeine_post_5pm_mg <= 25 THEN '1-25 mg'
            WHEN caffeine_post_5pm_mg <= 50 THEN '26-50 mg'
            WHEN caffeine_post_5pm_mg <= 100 THEN '51-100 mg'
            ELSE '>100 mg'
        END AS caffeine_band
    FROM bedtime_screentime_sleep_debt
)
SELECT
    caffeine_band,
    COUNT(*) AS users,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(sleep_latency_min),2) AS avg_latency_min,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue
FROM segmented
GROUP BY caffeine_band
ORDER BY MIN(caffeine_post_5pm_mg);

-- 10. Blue-light filter comparison
SELECT
    CASE WHEN blue_light_filter_active = 1 THEN 'Active' ELSE 'Inactive' END AS filter_status,
    COUNT(*) AS users,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(sleep_latency_min),2) AS avg_latency_min,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue,
    ROUND(
        100.0 * AVG(
            CASE WHEN sleep_debt_category = 'Severe Sleep Debt' THEN 1.0 ELSE 0.0 END
        ),2
    ) AS severe_debt_pct
FROM bedtime_screentime_sleep_debt
GROUP BY blue_light_filter_active;

-- 11. High-risk users for intervention
SELECT
    user_id,
    age,
    occupation_type,
    chronotype,
    bedtime_phone_minutes,
    caffeine_post_5pm_mg,
    sleep_latency_min,
    total_sleep_hours,
    morning_alarm_snoozes,
    next_day_fatigue_score,
    sleep_debt_category
FROM bedtime_screentime_sleep_debt
WHERE bedtime_phone_minutes > 120
  AND sleep_debt_category = 'Severe Sleep Debt'
ORDER BY next_day_fatigue_score DESC;

-- 12. Composite risk segmentation
WITH risk AS (
    SELECT *,
        (
            CASE WHEN bedtime_phone_minutes > 90 THEN 1 ELSE 0 END +
            CASE WHEN total_sleep_hours < 6 THEN 1 ELSE 0 END +
            CASE WHEN sleep_latency_min > 60 THEN 1 ELSE 0 END +
            CASE WHEN morning_alarm_snoozes >= 4 THEN 1 ELSE 0 END +
            CASE WHEN caffeine_post_5pm_mg > 100 THEN 1 ELSE 0 END
        ) AS risk_flags
    FROM bedtime_screentime_sleep_debt
)
SELECT
    risk_flags,
    COUNT(*) AS users,
    ROUND(AVG(total_sleep_hours),2) AS avg_sleep_hours,
    ROUND(AVG(next_day_fatigue_score),2) AS avg_fatigue,
    ROUND(
        100.0 * AVG(
            CASE WHEN sleep_debt_category = 'Severe Sleep Debt' THEN 1.0 ELSE 0.0 END
        ),2
    ) AS severe_debt_pct
FROM risk
GROUP BY risk_flags
ORDER BY risk_flags;
