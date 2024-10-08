/*
Find skills that are both in high demand and that offer the highest
salaries.
Results of two CTE's are joined to get the results for this query.
*/

WITH skills_demand AS (
    SELECT skills_dim.skill_id, skills_dim.skills, COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
    
),
high_paying_jobs AS (
    SELECT skills_dim.skill_id, skills_dim.skills, ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.job_work_from_home = TRUE
    AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
    
    
)

SELECT skills_demand.skill_id, skills_demand.skills, 
high_paying_jobs.avg_salary,
skills_demand.demand_count 
FROM skills_demand
INNER JOIN high_paying_jobs ON skills_demand.skill_id = high_paying_jobs.skill_id
where demand_count > 10
order by 
skills_demand.demand_count desc, high_paying_jobs.avg_salary desc
limit 25

