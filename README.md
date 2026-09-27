# Bedtime Screen Time & Sleep Debt Analysis

## 1. Project Overview

This project analyzes behavioral and sleep-related data from **8,500 users** to identify patterns connecting bedtime phone usage, sleep duration, sleep latency, sleep quality, morning snoozing, caffeine consumption, and next-day fatigue.

The analysis is designed from a **Senior Data Analyst / Business Intelligence perspective**. The objective is not simply to describe the dataset, but to convert behavioral data into measurable business insights, risk segments, and potential intervention opportunities.
**Important analytical note:** This is observational data. Relationships and correlations should not be interpreted as proof that one behavior causes another.



## 2. Business Problem

Organizations developing digital wellness products, employee-wellbeing programs, sleep coaching products, or behavioral analytics solutions could use this dataset to answer:

- How strongly is bedtime phone use associated with next-day fatigue?
- Which sleep-debt groups require the most attention?
- Which occupation groups show higher sleep-risk patterns?
- Do chronotypes differ meaningfully in sleep outcomes?
- Which bedtime apps are associated with higher fatigue in this sample?
- Does late caffeine consumption show a measurable relationship with sleep outcomes?
- Is blue-light-filter usage associated with better outcomes?
- Can high-risk users be identified for targeted interventions?


## 3. Dataset

### Dataset size

- **Rows:** 8,500
- **Columns:** 18
- **Unique users:** 8,500
- **Missing values:** 0
- **Duplicate rows:** 0
- **Duplicate user IDs:** 0

### Key fields

| Field | Description |
|---|---|
| `user_id` | Unique user identifier |
| `age` | User age |
| `gender` | Gender category |
| `occupation_type` | Work/life context |
| `chronotype` | Morning Lark, Intermediate, Night Owl |
| `bedtime_phone_minutes` | Phone use around bedtime |
| `primary_bedtime_app` | Main app used around bedtime |
| `screen_brightness_pct` | Screen brightness |
| `blue_light_filter_active` | Blue-light filter indicator |
| `caffeine_post_5pm_mg` | Caffeine consumed after 5 PM |
| `physical_activity_min` | Physical activity minutes |
| `sleep_latency_min` | Time required to fall asleep |
| `total_sleep_hours` | Total sleep duration |
| `deep_sleep_pct` | Deep sleep percentage |
| `rem_sleep_pct` | REM sleep percentage |
| `morning_alarm_snoozes` | Number of morning snoozes |
| `next_day_fatigue_score` | Next-day fatigue score |
| `sleep_debt_category` | Overall sleep-debt classification |


## 4. Tools & Technologies

- **Python:** pandas, NumPy, Matplotlib, SciPy
- **SQL:** MS SQL
- **GitHub:** Project documentation and version control
- **EDA:** Descriptive statistics, distributions, segmentation, correlations
- **Visualization:** Scatter plots, bar charts, trend comparisons


## 5. Analytical Workflow

1. Data loading
2. Data-quality validation
3. Descriptive statistics
4. Categorical analysis
5. Sleep-debt segmentation
6. Phone-use segmentation
7. Occupation analysis
8. Chronotype analysis
9. Bedtime-app analysis
10. Caffeine analysis
11. Blue-light-filter comparison
12. Correlation analysis
13. Business-risk segmentation
14. Visualization
15. Executive recommendations
16. Conclusion


# 6. Key Business Insights

## Insight 1 — Moderate Sleep Debt Is the Largest User Segment
**4,462 users**, or approximately **52.5%** of the dataset, are classified as having Moderate Sleep Debt.

This is important because the largest opportunity may not be only the severe-risk population. A large moderate-risk population can represent a broader prevention and behavior-improvement opportunity.

---

## Insight 2 — Bedtime Phone Usage Has a Strong Association with Fatigue

Pearson correlation: **Bedtime phone minutes vs next-day fatigue = +0.711**

As bedtime phone use increases, fatigue also tends to increase in this dataset.

The relationship becomes particularly pronounced in higher phone-use segments.

| Phone use | Avg sleep | Avg fatigue | Severe debt |
|---|---:|---:|---:|
| <=30 min | 7.15 h | 1.93 | 0.15% |
| 31–60 min | 6.58 h | 2.88 | 0.82% |
| 61–90 min | 5.88 h | 4.58 | 6.16% |
| 91–120 min | 5.28 h | 6.26 | 16.98% |
| >120 min | 4.45 h | 8.36 | 54.86% |

This is one of the clearest segmentation patterns in the dataset.


## Insight 3 — Sleep Duration Is Strongly Associated with Next-Day Fatigue

Pearson correlation: **Total sleep hours vs next-day fatigue = -0.879**

This is the strongest negative relationship observed among the major sleep variables.

Users with lower sleep duration generally report substantially higher next-day fatigue.


## Insight 4 — Alarm Snoozing Is the Strongest Positive Fatigue Signal

Pearson correlation:

**Morning alarm snoozes vs fatigue = +0.881**

Snoozing may therefore function as a useful behavioral indicator of poor recovery or insufficient sleep in this dataset.

For an analytics product, this could be useful as a simple monitoring metric.


## Insight 5 — Severe Sleep Debt Is Concentrated in Specific Occupation Groups

Healthcare / Shift Workers show the highest severe-debt rate: **18.25%**

Their average sleep duration is approximately **5.02 hours**, while average fatigue is approximately **5.54/10**.

This suggests that work schedule and occupational context should be considered when designing sleep-risk interventions.


## Insight 6 — Chronotype Is Strongly Associated with Sleep Outcomes

| Chronotype | Avg sleep | Avg fatigue | Severe debt |
|---|---:|---:|---:|
| Morning Lark | 7.38 h | 2.53 | 2.59% |
| Intermediate | 6.44 h | 3.48 | 5.85% |
| Night Owl | 5.01 h | 5.40 | 14.83% |
Night Owls in this sample have substantially lower sleep duration and higher fatigue.
This suggests that a one-size-fits-all sleep recommendation may be less appropriate than chronotype-aware recommendations.


## Insight 7 — Bedtime App Category Shows Meaningful Differences

Average fatigue varies across primary bedtime app categories.
TikTok / Reels users have the highest average fatigue among the listed app groups in this sample, while News / Reading users have the lowest.
However, this should **not** be interpreted as an app category causing fatigue. App choice may be confounded by age, occupation, chronotype, sleep habits, or other factors.



## Insight 8 — Late Caffeine Shows a Weaker but Directional Relationship

Caffeine after 5 PM has a positive relationship with fatigue:

**Pearson r ≈ +0.181**

The relationship is much weaker than the relationships involving sleep duration, snoozing, phone use, and sleep latency.

This suggests caffeine is a secondary signal rather than the primary explanatory variable in this dataset.

---

## Insight 9 — Blue-Light Filter Users Have Modestly Better Outcomes

Users with the blue-light filter active show:

- Slightly higher average sleep
- Lower sleep latency
- Lower average fatigue
- Lower severe-debt percentage

However, the difference is relatively modest, and the dataset is observational. The analysis therefore supports **association**, not a causal claim that enabling the filter improves sleep.

---

# 7. Senior Analyst Interpretation

The most important business pattern is not a single variable. It is the **combination of bedtime behavior and recovery outcomes**.
A high-risk user profile can be characterized by several signals appearing together:
- High bedtime phone usage
- Short total sleep duration
- High sleep latency
- Frequent alarm snoozing
- High next-day fatigue
- Severe sleep-debt classification

This creates an opportunity to move from descriptive reporting toward **behavioral risk segmentation**.
For example, a wellness platform could create intervention tiers:

### Low-risk segment
- Low phone use
- Adequate sleep
- Low fatigue
- Few snoozes

### Moderate-risk segment
- Moderate phone use
- Reduced sleep
- Increasing latency or snoozing
- Moderate debt

### High-risk segment
- >90–120 minutes phone use
- <6 hours sleep
- High latency
- Frequent snoozing
- High fatigue
- Severe sleep debt

These segments could support personalized notifications, sleep coaching, digital-wellness recommendations, or employee wellbeing programs.

---

# 8. SQL Analysis

The `sql_analysis.sql` file contains queries covering:

- Dataset validation
- KPI summary
- Sleep-debt distribution
- Occupation comparison
- Chronotype comparison
- Bedtime app analysis
- Phone-use segmentation
- Caffeine segmentation
- Blue-light-filter comparison
- High-risk user identification
- Composite risk segmentation

---

# 9. Python Analysis

The `bedtime_sleep_analysis.py` script performs:

- Dataset inspection
- Missing-value checks
- Duplicate checks
- Descriptive statistics
- Category distributions
- Derived segmentation
- Correlation analysis
- Pearson statistical tests
- Business summary tables
- Eight business-focused visualizations
- Executive insight output

# 10. Limitations

1. The dataset appears to be cross-sectional rather than longitudinal.
2. Correlation does not prove causation.
3. Unobserved variables may influence sleep and fatigue.
4. App category does not capture actual content consumed.
5. Occupation categories may contain substantial behavioral variation.
6. Sleep quality measurements may depend on device measurement accuracy.
7. The dataset does not establish whether behavior changes preceded sleep changes.

# 11. Conclusion

The analysis shows a clear behavioral pattern: **higher bedtime phone exposure is associated with shorter sleep, longer sleep latency, greater alarm snoozing, higher sleep debt, and greater next-day fatigue**.

The strongest statistical signals are:
- Sleep duration ↔ fatigue: **r ≈ -0.879**
- Alarm snoozes ↔ fatigue: **r ≈ +0.881**
- Sleep latency ↔ fatigue: **r ≈ +0.745**
- Bedtime phone use ↔ fatigue: **r ≈ +0.711**

The most concerning segment is the group using their phone for **more than 120 minutes at bedtime**, where average sleep falls to approximately **4.45 hours**, average fatigue reaches **8.36/10**, and severe sleep debt reaches approximately **54.9%**.

From a business analytics perspective, the dataset supports moving beyond basic reporting toward **early-risk detection and personalized behavioral interventions**. The next analytical step would be a multivariate model to determine whether bedtime phone use remains a strong predictor of fatigue after controlling for chronotype, occupation, caffeine, age, activity, and other behavioral variables.
