/*
What are the top paying datta analhysgt jobs?
Steps to solve the problem
- identify the top 10 highest paying data analyst roles are avaialble remotely
-focuses on job postings with specified salaries (remove nulls)
- Why are we doing this? 
To highlight the top-paying opportunities for data analysts. 
*/

select job_id, job_title,salary_year_avg, company_name, job_location, job_schedule_type, 
job_posted_date::date
from job_postings_fact
left join company_dim on job_postings_fact.company_id=company_dim.company_id
where job_location='Anywhere'
And job_title_short='Data Analyst'
And salary_year_avg is not null
order by salary_year_avg desc
limit 10
;