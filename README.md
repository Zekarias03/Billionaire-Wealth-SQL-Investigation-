# The Billionaire Wealth Investigation
## Introduction

This SQL project analyses wealth distribution among the world's 200 richest people, based on the Forbes list. SQL (SQLite) is used to answer 10 business questions from the project brief and 21 additional questions, covering countries, industries, ages, net worth and continents. The additional questions include INNER, LEFT and RIGHT JOINs, subqueries, window functions and CASE WHEN. The key results are summarised in a dashboard of six charts.

## About the Dataset

The dataset (Top_200_Richest_Person_in_the_World.xlsx) lists the 200 richest people in the world according to Forbes. It has 200 rows and 7 columns. Each row is one billionaire, although 43 entries are family fortunes (for example, "Bernard Arnault & family"), so their age and net worth may not describe a single person.

### Column	Description
serial_number	Sequential number of the billionaire in the dataset
rank	Global rank by net worth (Forbes)
name	Name of the billionaire
age	Age of the billionaire
country	Country the billionaire belongs to
networth_billion	Net worth in billion US dollars
industry	Industry the wealth is mainly attributed to

The dataset has only one table, so two small lookup tables were created in SQL to practise JOINs:

- country_region: links each of the 35 countries to a continent (Russia and Cyprus are grouped under Europe).
- continent_list: the seven continents, including Antarctica, which has no billionaires.
## Problem Statement

The goal of this project is to understand wealth distribution among the 200 richest people in the world. The task is to analyse the dataset and answer important business questions using SQL.

## Visualization

Dashboard_Image.png

The dashboard shows six views of the data:

- Top 10 richest: net worth of the ten richest people ($B)
- Billionaires by country: the five countries with the most billionaires
- Total wealth by continent: result of the SQL JOIN between the dataset and country_region ($B)
- Total wealth by industry: the six industries with the most wealth ($B)
- Billionaires by age group: how many billionaires fall in each age group
- Billionaires by wealth tier: result of a CASE WHEN query

The footer shows the key totals: total wealth $6,368.5B, average $31.84B and median $19.25B.

## SQL Skills Used
- Filtering and sorting: WHERE, ORDER BY, LIMIT
- Aggregation: COUNT, SUM, AVG, ROUND, GROUP BY, HAVING
- Subqueries and derived tables
- CASE WHEN for age groups and wealth tiers
- Window functions: ROW_NUMBER(), LEAD()
- Joins: INNER JOIN, LEFT JOIN, RIGHT JOIN
- CREATE TABLE and INSERT for the lookup tables
## Insights
- Total wealth: the 200 billionaires hold $6,368.5 billion in total. The average net worth is $31.84 billion, but the median is only $19.25 billion, because a few very large fortunes pull the average up.
- Richest people: Bernard Arnault (France) is first with $233 billion, followed by Elon Musk ($195 billion) and Jeff Bezos ($194 billion). Mark Zuckerberg is fourth with $177 billion.
- Wealth concentration: the top 10 hold $1,552 billion, which is 24.4% of the total wealth. Eight of the ten are from the United States.
- Countries: the United States has 79 billionaires (39.5% of the list), more than the next four countries combined: China (17), India (13), Germany (11) and Russia (11) together have 52.
- Continents (JOIN): North America holds $3,387.6 billion (53.2% of all wealth) with 85 billionaires. Europe has $1,415.9 billion (22.2%) with 47, and Asia has $1,334.4 billion (21.0%) with 55. Asia has more billionaires than Europe but less wealth. South America, Oceania and Africa together hold less than 4%, and Antarctica has none.
- Richest person on each continent (JOIN + window function): Bernard Arnault in Europe, Elon Musk in North America, Mukesh Ambani in Asia, Gina Rinehart in Oceania ($30.8 billion), Eduardo Saverin in South America ($28.0 billion) and Aliko Dangote in Africa ($13.4 billion).
- Industries: Technology holds the most wealth ($1,739 billion, 27.3% of the total), followed by Fashion & Retail ($1,166 billion) and Finance & Investments ($853 billion). These three industries together hold about 59% of all wealth.
- Wealth tiers (CASE WHEN): the 14 billionaires with $100 billion or more hold $1,973 billion (31.0% of all wealth), slightly more than the 120 billionaires below $25 billion, who hold 28.0%.
- Age: the 70-79 group is the largest (58 billionaires). 107 of the 200 billionaires (53.5%) are 70 or older, and only 16 are under 50.
- Young wealth: the 16 billionaires under 50 hold $508.3 billion, and 10 of them work in Technology.
- Above the country average (JOIN to a derived table): Bernard Arnault is $164.6 billion above the average of France ($68.4 billion), and Elon Musk is $155.4 billion above the United States average ($39.6 billion).
- Data quality: 43 entries are family fortunes, and the dataset covers 35 countries and 18 industries. A LEFT JOIN check showed that every billionaire was matched to a continent.
## Recommendation
- Report the median together with the average when describing typical wealth, because the average is pulled up by a few very large fortunes.
- Track the technology industry separately, since it holds the largest share of wealth and the youngest billionaires.
- Mark family fortunes in the data so that their age and net worth are not read as single individuals.
- When comparing countries or continents, use a minimum group size (for example, 5 billionaires) so that one person does not decide the result.
## Conclusion

Wealth among the world's 200 richest people is highly concentrated. The United States, North America and the technology industry dominate, the top 10 hold almost a quarter of all wealth, and more than half of the billionaires are 70 or older. The main takeaway is that averages alone give a misleading picture, so medians and shares of the total should be reported alongside them.

## Files
- billionaire_queries.sql: all SQL questions (Q1 to Q31) with queries
- Top_200_Richest_Person_in_the_World.xlsx: the dataset
- Dashboard_Image.png: dashboard image of the key results
- README.md: this file
## Tools

SQL (SQLite), Excel, GitHub
