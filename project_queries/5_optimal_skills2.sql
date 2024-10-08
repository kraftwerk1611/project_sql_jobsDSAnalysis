/*
Find skills that are both in high demand and that offer the highest
salaries. A shorter version of the query without using CTE's
*/



SELECT skills_dim.skill_id, skills_dim.skills, 
count (skills_job_dim.job_id) as demand_count,
round(avg(job_postings_fact.salary_year_avg),0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
where
job_postings_fact.salary_year_avg is not null
and job_postings_fact.job_title_short='Data Analyst'
and job_work_from_home=True
group by skills_dim.skill_id
having count (skills_job_dim.job_id) > 10
order by 
demand_count desc, avg_salary desc
limit 25
;

