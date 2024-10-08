/*
What are the most in-demand skills for a given role.
Unlike the use of CTE in previous solution here many-to-many is implemented using two inner joins.
Each table is joined with junction table on the primary key. 
*/
select skills, count(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id 
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
where job_postings_fact.job_title_short='Data Analyst'
and job_postings_fact.job_work_from_home=True
group by skills
order by demand_count desc
limit 5
