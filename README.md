# Introduction
📊 Explore the job landscape for data professionals!
This analysis focuses on data analyst positions, examining:
💰 The most lucrative opportunities
🔥 Skills currently in high demand
📈 Sweet spots where data scientist roles offer both strong demand and top pay
Check them out: [ Project_sql folder](/Project_sql/)

# Background
🌟 Project Inspiration:
Navigating the data scientist/data engineer job market more efficiently
Identifying lucrative skills and optimal career paths
📊 Data Source: [SQL Datas]()
Derived from a comprehensive SQL course


🔍 Key Questions Explored:
💰 Highest-paying data analyst positions?
🧠 Skills required for top-tier roles?
🔥 Most sought-after data analyst competencies?
📈 Skills correlating with higher salaries?
🎯 Most valuable skills to acquire?

# Tools I Used
🔍 Tools Powering My Data Job Market Analysis:
**🛠️ SQL**: Core analysis engine for extracting vital insights from the database
**🐘 PostgreSQL:** Robust database system chosen to manage job listing information
**💻 Visual Studio Code:** Preferred platform for database operations and SQL query execution
**🔄 Git & GitHub:** Crucial for:
- Version control
- Sharing SQL scripts and findings
- Facilitating teamwork
- Monitoring project progress

# The Analysis
🔎 Query Focus: Dissecting the Data Analyst Job Market.

Approach to Key Question:
### 1.Highest-Paying Data Scientist Roles
Here were the steps followed
- Filtered positions by
- Average annual salary
- Job location
- Spotlight on remote opportunities
- Query result: Showcases top-tier salary prospects in the field

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    NAME AS company_name
FROM
    job_postings_fact
    LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere' AND
    salary_year_avg is NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 15;
```
### Here is the visualiation for better understanding
[Top 10 Data Scientist Jobs in 2023](Assets/tops.png)

### 2. Skills for Top Paying Jobs
🔍 Uncovering Skills for Top-Tier Salaries:

- Merged job listing data with skill requirements
- Revealed key competencies employers prize in high-paying positions
- Provided insights into valuable abilities for maximizing earning potential
```
With top_paying_jobs as (
    
    SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        NAME AS company_name
    FROM
        job_postings_fact
        LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Scientist' AND
        job_location = 'Anywhere' AND
        salary_year_avg is NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 30
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
Inner JOIN  skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
Inner JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
order BY
    salary_year_avg DESC
```
### 3. In Demand Skills for Data Scientist
🔎 Pinpointing High-Demand Skills:

- Analyzed job posting frequency of various skills
- Highlighted competencies most sought after by employers
- Guided attention towards areas of significant market demand
```
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
Inner JOIN  skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
Inner JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title = 'Data Scientist' 
    
GROUP BY
    skills  
ORDER BY
    demand_count DESC
LIMIT 20;
```
Here is the overview according to the given output for the in demand skills.
| Skill      | Demand Count |
|------------|--------------|
| python     | 32,418       |
| sql        | 22,296       |
| r          | 17,046       |
| tableau    | 8,336        |
| aws        | 7,757        |
| sas        | 7,242        |
| spark      | 6,772        |
| azure      | 6,404        |
| tensorflow | 5,783        |
| pandas     | 4,967        |
- Python dominates: With 32,418 mentions, Python is by far the most requested skill. This aligns with its popularity as a versatile language for data analysis, machine learning, and general-purpose programming.
- SQL is crucial: Coming in second with 22,296 mentions, SQL demonstrates the ongoing importance of database skills in data science roles.
- R remains relevant: With 17,046 mentions, R is the third most in-demand skill, showing its continued significance in statistical analysis and data visualization.
- Visualization matters: Tableau (8,336 mentions) is the top visualization tool mentioned, highlighting the importance of data presentation skills.
- Cloud platforms are key: AWS (7,757) and Azure (6,404) both appear in the top 10, indicating the growing importance of cloud computing skills in data science.

### 4. Skills Based on Salary
 
 ```
SELECT 
    skills,
    job_title,
    Round(avg(salary_year_avg),2) as avg_salary
FROM job_postings_fact
Inner JOIN  skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
Inner JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short= 'Data Scientist' AND
    salary_year_avg is NOT NULL
GROUP BY
    skills,
    job_title 
ORDER BY
    avg_salary DESC
LIMIT 30
 ```
 Here is the detailed output of above code which shows excel and python/sql most important skills for getting paid more. 
 *These insights highlight that while general-purpose tools like Excel can be valuable in specialized contexts, core data science skills such as Python and SQL remain crucial for top-tier positions in the field.*
 | Skill     | Job Title                                             | Average Salary |
|-----------|-------------------------------------------------------|----------------|
| excel     | Geographic Information Systems Analyst - GIS Analyst  | $585,000       |
| python    | Staff Data Scientist/Quant Researcher                 | $550,000       |
| sql       | Staff Data Scientist/Quant Researcher                 | $550,000       |
| sql       | Staff Data Scientist - Business Analytics             | $525,000       |
| sql       | Data Scientist (L5) - Member Product                  | $450,000       |
| r         | Data Scientist (L5) - Member Product                  | $450,000       |
| python    | Data Scientist (L5) - Member Product                  | $450,000       |
| sas       | Director Data Science, AI Infra                       | $375,000       |
| r         | Data Science Director, Adoption & Enterprise          | $375,000       |
| slack     | Director of Data Science                              | $375,000       |
### 5.🎯 Identifying Prime Skills for Career Growth
This analysis fused data on skill demand with salary information to spotlight abilities that are both highly sought-after and well-compensated in the job market.
```
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
Here is the table showing the detail information.
| skill_id | skills       | demand_count | avg_salary |
|----------|--------------|--------------|------------|
| 26       | c            | 48           | 164,865    |
| 8        | go           | 57           | 164,691    |
| 187      | qlik         | 15           | 164,485    |
| 185      | looker       | 57           | 158,715    |
| 96       | airflow      | 23           | 157,414    |
| 77       | bigquery     | 36           | 157,142    |
| 3        | scala        | 56           | 156,702    |
| 81       | gcp          | 59           | 155,811    |
| 80       | snowflake    | 72           | 152,687    |
| 101      | pytorch      | 115          | 152,603    |
| 78       | redshift     | 36           | 151,708    |
| 99       | tensorflow   | 126          | 151,536    |
| 233      | jira         | 22           | 151,165    |
| 92       | spark        | 149          | 150,188    |
| 76       | aws          | 217          | 149,630    |
| 94       | numpy        | 73           | 149,089    |
| 106      | scikit-learn | 81           | 148,964    |
| 95       | pyspark      | 34           | 147,544    |
| 182      | tableau      | 219          | 146,970    |
| 2        | nosql        | 31           | 146,110    |
| 4        | java         | 64           | 145,706    |
| 196      | powerpoint   | 23           | 145,139    |
| 93       | pandas       | 113          | 144,816    |
| 213      | kubernetes   | 25           | 144,498    |
| 1        | python       | 763          | 143,828    |



# What I Learned
SQL Skill Enhancement Journey:
This project significantly boosted my SQL proficiency:

- Advanced Query Construction: Mastered complex SQL techniques, including expert table joining and sophisticated temporary table manipulation using WITH clauses.
- Effective Data Summarization: Became proficient with GROUP BY operations and leveraged aggregate functions such as COUNT() and AVG() for powerful data condensation.
- Practical Problem-Solving: Developed the ability to translate real-world questions into informative SQL queries, enhancing analytical capabilities.

This hands-on experience with a real-world data insights project, coupled with comprehensive SQL training, has greatly enhanced my database skills and market value.

# Conclusions
*This venture upgraded my SQL abilities and given profitable experiences into the information analyst/scientist/engineer work showcase. The discoveries from the investigation serve as a direct to prioritizing expertise improvement and work look endeavors. Yearning information scientist/engineer can superior position themselves in a competitive work showcase by centering on high-demand, high-salary abilities. This investigation highlights the significance of ceaseless learning and adjustment to developing patterns within the field of information scientist/engineer.*