/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE jpf.job_title ILIKE '%data engineer%'
    AND jpf.job_location ILIKE '%remote%'
GROUP BY
    sd.skills
ORDER BY demand_count DESC
LIMIT 10;

/*
This query retrieves the top 10 most in-demand skills for data engineers in remote job 
postings. It joins the job postings fact table with the skills dimension tables to count 
the occurrences of each skill associated with data engineer roles that are remote. 
The results are ordered by demand count in descending order, providing insights into the 
most valuable skills for data engineers seeking remote work.
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │          306 │
│ python     │          294 │
│ aws        │          176 │
│ azure      │          163 │
│ spark      │          154 │
│ snowflake  │          110 │
│ databricks │          109 │
│ kafka      │           85 │
│ airflow    │           83 │
│ scala      │           74 │
└────────────┴──────────────┘
*/
