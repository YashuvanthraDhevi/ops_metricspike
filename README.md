# ops_metricspike
Operation Analytics and Investigating Metric Spike using SQL

# Case Study 1: Job Data Analysis

Involves a table named job_data with the following columns:

job_id: Unique identifier of jobs

actor_id: Unique identifier of actor

event: The type of event (decision/skip/transfer).

language: The Language of the content

time_spent: Time spent to review the job in seconds.

org: The Organization of the actor

ds: The date in the format yyyy/mm/dd (stored as text).


Tasks:

1. Jobs Reviewed Over Time: Calculate the number of jobs reviewed per hour for each day in November 2020.
2. Throughput Analysis: Calculate the 7-day rolling average of throughput (number of events per second).
3. Language Share Analysis:Calculate the percentage share of each language in the last 30 days.
4. Duplicate Rows Detection:Identify duplicate rows in the data.

# Case Study 2: Investigating Metric Spike

Involves three tables:

users: Contains one row per user, with descriptive information about that user’s account.

events: Contains one row per event, where an event is an action that a user has taken (e.g., login, messaging, search).

email_events: Contains events specific to the sending of emails.

Tasks:

1. Weekly User Engagement:Measure the activeness of users on a weekly basis.
2. User Growth Analysis:Analyze the growth of users over time for a product.
3. Weekly Retention Analysis:Analyze the retention of users on a weekly basis after signing up for a product.
4. Weekly Engagement Per Device:Measure the activeness of users on a weekly basis per device.
5. Email Engagement Analysis:Analyze how users are engaging with the email service.
