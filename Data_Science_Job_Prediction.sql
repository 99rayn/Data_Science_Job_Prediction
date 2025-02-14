-- Creating Dataset --
use data_science_job;
drop table if exists data_science_job_table;
create table data_science_job_table
(
enrollee_id int,
city	varchar(10),
city_development_index	decimal(2,2),
gender	Char(6),
relevent_experience	varchar(25),
enrolled_university	varchar(20),
education_level	varchar(15),
major_discipline	varchar(16),
experience	int,
company_size varchar(10),
company_type	varchar(20),
training_hours	int,
target tinyint
);

-- SQL Quaries -- 

select *
from data_science_job_table;

-- What is the distribution of job seekers across different cities? --

select city, count(*) as Job_Seekers
from data_science_job_table
where target=1
group by city
order by Job_Seekers DESC LIMIT 10;

-- How does the city development index correlate with job-seeking status? --

select target, avg(city_development_index) as Average_City_Development
from data_science_job_table
group by target;
/* A higher city development index might indicate a better economy, which could affect job-seeking behavior. */

-- What is the gender distribution among job seekers? --

select gender, count(*) as Totat_Job_Seekers
from data_science_job_table
where target = 1
group by gender;

-- What are the most common education levels and major disciplines among job seekers? --

select education_level,count(*) as count, major_discipline
from data_science_job_table
where target = 1
group by education_level,major_discipline
order by count DESC limit 5;

-- How does relevant experience affect the likelihood of job-seeking? --

select experience, count(*) as Total_job_seeker
from data_science_job_table
where target = 1
group by experience
order by experience ASC;

-- Relationship between company size and job-seeking behavior--

SELECT company_size, COUNT(*) AS count 
FROM data_science_job_table 
WHERE target = 1 
GROUP BY company_size 
ORDER BY count DESC;
 
-- How do training hours vary across different education levels and experience levels? --

select education_level, avg(training_hours) as Training_Hours
from data_science_job_table
group by education_level
order by Training_Hours DESC;

-- Can we build a predictive model to determine whether a person is actively seeking a job? --

select education_level, major_discipline, company_size, avg(target) as Average_job_seeker
from data_science_job_table
group by education_level, major_discipline, company_size
order by Average_job_seeker DESC;

-- What are the most important features that influence job-seeking behavior? -- 

select education_level, count(*) as Education_Level, avg(target) as Job_Seeker
from data_science_job_table
group by education_level
order by Job_seeker desc ;

select company_type, count(*) as Company_type, avg(target) as Job_Seeker
from data_science_job_table
group by company_type
order by Job_seeker desc ;

-- How does previous work experience affect job-seeking probability --

select relevent_experience, avg(target) as Average_Job_Seeking
from data_science_job_table
group by relevent_experience
order by Average_Job_Seeking DESC;

-- Does living in larger cities (higher city development index) reduce job-seeking -- 

select 
	case
		when city_development_index >= 0.8 then 'High Development'
        when city_development_index between 0.5 and 0.79 then 'Medium Development'
        else 'Low Development'
	end as City_category, avg(target) as Job_seekers
from data_science_job_table
group by City_category
order by Job_seekers;

-- Does company type (e.g., private vs. startup) affect job-seeking tendencies --

select company_type, count(*) as Total, avg(target) as Average_Job_seekers
from data_science_job_table
group by company_type
order by Average_Job_seekers;

-- What is the impact of having a STEM background on job-seeking status? --

select 
	case
		when major_discipline = 'STEM' then 'STEM'
        else 'Non STEM'
	end as Discipline, avg(target) as Job_Seekers
from data_science_job_table
group by major_discipline
order by Job_Seekers;

-- How do training hours influence job-seeking behavior? --

select 
	case
		when training_hours < 30 then 'Low Training'
        when training_hours >30 and training_hours<80 then 'Mid Training'
        else 'High Training'
	end as Training_Type, avg(target) as Job_Seekers
from data_science_job_table
where training_hours is not null
group by training_hours
order by Job_Seekers DESC;

