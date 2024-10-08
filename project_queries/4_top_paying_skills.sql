/*
What are the top skills based on salary.
Many-to-Many is implemented using two inner joins. Each table is joined with junction table on its
primary key.
*/
select skills, round(avg(salary_year_avg),0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id= skills_job_dim.job_id 
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
where job_postings_fact.job_title_short='Data Analyst'
and job_postings_fact.job_work_from_home=True
and salary_year_avg is not null
group by skills

order by avg_salary desc
limit 25
;
