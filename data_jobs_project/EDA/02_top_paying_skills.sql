/* 
Question: What are the top paying skills for data engineers
 in remote jobs?
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
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
HAVING COUNT(jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 25;


/*
Here are breakdown of the highest paying skills for data engineers in remote jobs, along with their median salaries and demand counts. The query joins the job
postings fact table with the skills dimension tables to calculate the median salary for each skill associated with data engineer roles that are remote. 
The results are filtered to include only skills with more than 100 job postings, providing insights into the most valuable skills for data engineers seeking remote work.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ spark      │      138875.0 │          154 │
│ snowflake  │      131500.0 │          110 │
│ azure      │      127500.0 │          163 │
│ sql        │      123875.0 │          306 │
│ python     │      123500.0 │          294 │
│ databricks │      122750.0 │          109 │
│ aws        │      102620.0 │          176 │

*/
