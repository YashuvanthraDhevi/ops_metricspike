CREATE DATABASE job;

USE job;

CREATE TABLE job_data
(
    ds DATE,
    job_id INT NOT NULL,
    actor_id INT NOT NULL,
    event VARCHAR(15) NOT NULL,
    language VARCHAR(15) NOT NULL,
    time_spent INT NOT NULL,
    org CHAR(2)
);

INSERT INTO job_data (ds, job_id, actor_id, event, language, time_spent, org)
VALUES ('2020-11-30', 21, 1001, 'skip', 'English', 15, 'A'),
    ('2020-11-30', 22, 1006, 'transfer', 'Arabic', 25, 'B'),
    ('2020-11-29', 23, 1003, 'decision', 'Persian', 20, 'C'),
    ('2020-11-28', 23, 1005,'transfer', 'Persian', 22, 'D'),
    ('2020-11-28', 25, 1002, 'decision', 'Hindi', 11, 'B'),
    ('2020-11-27', 11, 1007, 'decision', 'French', 104, 'D'),
    ('2020-11-26', 23, 1004, 'skip', 'Persian', 56, 'A'),
    ('2020-11-25', 20, 1003, 'transfer', 'Italian', 45, 'C');
    
SELECT * FROM job_data;

/*A.No.of  jobs reviewed*/
SELECT ds, ROUND(1.0*COUNT(job_id)*3600/SUM(time_spent),2) AS throughput
FROM job_data
WHERE event IN ('transfer','decision')
AND ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds;


/*B.Throughput*/
WITH CTE AS (
SELECT ds, COUNT(job_id) AS num_jobs, SUM(time_spent) AS total_time
FROM job_data
WHERE event IN('transfer','decision')
AND ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY ds)
SELECT ds, ROUND(1.0*SUM(num_jobs) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) / SUM(total_time) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS throughput_7d
FROM CTE;

/*C.share of each language*/
WITH CTE AS (
SELECT DISTINCT language, COUNT(job_id) AS num_jobs
FROM job_data
WHERE event IN('transfer','decision')
AND ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY language),
total AS (
SELECT COUNT(job_id) AS total_jobs
FROM job_data
WHERE event IN('transfer','decision')
AND ds BETWEEN '2020-11-01' AND '2020-11-30')
SELECT language, ROUND(100.0*num_jobs/total_jobs,2) AS perc_jobs
FROM CTE join total
ORDER BY perc_jobs DESC;

/*D.Duplicate rows*/
SELECT j1.ds,j1.job_id,j1.actor_id,j1.event,j1.language,j1.time_spent,j1.org
FROM job_data j1 INNER JOIN job_data j2
ON j2.ds = j1.ds AND j2.job_id < j1.job_id;



