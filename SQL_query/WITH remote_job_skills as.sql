WITH remote_job_skills as (
    SELECT 
        skill_id,
        Count(*) as skills_count
    FROM
        skills_job_dim as skills_to_jobs
    INNER JOIN job_postings_fact as job_postings ON job_postings.job_id = skills_to_jobs.job_id

    WHERE 
        job_postings.job_work_from_home = True
    GROUP BY 
        skill_id
    LIMIT 10
)
SELECT 
    skills.skill_id,
    skills as skill_name,
    skills_count
FROM remote_job_skills
INNER JOIN skills_dim as skills ON skills.skill_id = remote_job_skills.skill_id 
order BY
    skills_count desc
LIMIT 5;