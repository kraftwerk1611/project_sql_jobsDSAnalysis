/*
Here we will try to find out the skills that are required in those high paying
job. 
This query will build on the query of previous problem.
*/

With high_paying_jobs as

(
select job_id, job_title_short, company_name, salary_year_avg
from job_postings_fact

left join company_dim on job_postings_fact.company_id=company_dim.company_id
where job_location='Anywhere'
And job_title_short='Data Analyst'
And salary_year_avg is not null
order by salary_year_avg desc
limit 10
)

select jobs.* ,skills
from high_paying_jobs as jobs
inner join skills_job_dim sj on jobs.job_id=sj.job_id
inner join skills_dim s on s.skill_id=sj.skill_id 

