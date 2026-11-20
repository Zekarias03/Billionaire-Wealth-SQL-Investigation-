-- ============================================================
-- THE BILLIONAIRE WEALTH INVESTIGATION (SQL PROJECT)
-- Author: Zekarias Tamiru
-- Dataset: Top 200 Richest People in the World (Forbes)
-- Table: Top200RichestPersonintheWorldTop200RichestPersonintheWorld
-- Q1-Q10: questions from the project brief | Q11-Q22: extra questions
-- Q23-Q31: JOINs (INNER, LEFT, RIGHT), subqueries, window functions and CASE
-- ============================================================

-- Q1. Retrieve the 20 richest billionaires.
SELECT rank, name, country, networth_billion
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
ORDER BY networth_billion DESC
LIMIT 20;
-- Q2. Identify the five youngest billionaires.
SELECT name, age, country
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
ORDER BY age ASC
LIMIT 5;
-- Q3. Calculate the average age and average net worth.
SELECT ROUND(AVG(age), 2) AS avg_age,
       ROUND(AVG(networth_billion), 2) AS avg_networth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld;
-- Q4. Identify the five most represented countries.
SELECT country, COUNT(*) AS billionaire_count
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY country
ORDER BY billionaire_count DESC
LIMIT 5;
-- Q5. Calculate the combined net worth of billionaires from each country.
SELECT country, ROUND(SUM(networth_billion), 1) AS total_networth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY country
ORDER BY total_networth DESC;
-- Q6. Identify the five industries with the highest number of billionaires.
SELECT industry, COUNT(*) AS billionaire_count
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY industry
ORDER BY billionaire_count DESC
LIMIT 5;
-- Q7. Find countries with at least five billionaires.
SELECT country, COUNT(*) AS billionaire_count
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY country
HAVING COUNT(*) >= 5
ORDER BY billionaire_count DESC;
-- Q8. Calculate the total wealth of billionaires younger than 50.
SELECT COUNT(*) AS num_billionaires,
       ROUND(SUM(networth_billion), 1) AS total_networth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
WHERE age < 50;

-- Q9. Identify billionaires whose net worth exceeds the overall average net worth.
SELECT rank, name, country, networth_billion
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
WHERE networth_billion > (SELECT AVG(networth_billion)
                          FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld)
ORDER BY networth_billion DESC;
-- Q10. Identify the industry with the highest average net worth.
-- Note: minimum 5 billionaires per industry, so a single person cannot decide the result.
SELECT industry,
       ROUND(AVG(networth_billion), 2) AS avg_networth,
       COUNT(*) AS billionaire_count
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY industry
HAVING COUNT(*) >= 5
ORDER BY avg_networth DESC
LIMIT 1;

-- Q11. Total wealth and average
SELECT COUNT(*) AS total_billionaires,
       ROUND(SUM(networth_billion), 1) AS total_wealth,
       ROUND(AVG(networth_billion), 2) AS avg_networth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld;

-- Q12. Share of wealth held by the top 10
SELECT ROUND(SUM(networth_billion), 1) AS top10_wealth,
       ROUND(100.0 * SUM(networth_billion) /
             (SELECT SUM(networth_billion)
              FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld), 1) AS pct_of_total
FROM (SELECT networth_billion
      FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
      ORDER BY networth_billion DESC
      LIMIT 10) AS top10;

-- Q13. Total wealth and share by industry
SELECT industry,
       COUNT(*) AS billionaires,
       ROUND(SUM(networth_billion), 1) AS total_wealth,
       ROUND(100.0 * SUM(networth_billion) /
             (SELECT SUM(networth_billion)
              FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld), 1) AS pct_share
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY industry
ORDER BY total_wealth DESC;

-- Q14. Wealth by age group
SELECT CASE WHEN age < 50 THEN 'Under 50'
            WHEN age < 60 THEN '50-59'
            WHEN age < 70 THEN '60-69'
            WHEN age < 80 THEN '70-79'
            ELSE '80+' END AS age_band,
       COUNT(*) AS billionaires,
       ROUND(AVG(networth_billion), 1) AS avg_networth,
       ROUND(SUM(networth_billion), 1) AS total_wealth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY age_band
ORDER BY MIN(age);

-- Q15. Five oldest billionaires
SELECT name, age, country
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
ORDER BY age DESC
LIMIT 5;

-- Q16. Highest average net worth by country (minimum 5 billionaires)
SELECT country,
       COUNT(*) AS billionaires,
       ROUND(AVG(networth_billion), 1) AS avg_networth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY country
HAVING COUNT(*) >= 5
ORDER BY avg_networth DESC
LIMIT 5;

-- Q17. US share of billionaires and of wealth
SELECT ROUND(100.0 * SUM(CASE WHEN country = 'United States' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_of_billionaires,
       ROUND(100.0 * SUM(CASE WHEN country = 'United States' THEN networth_billion ELSE 0 END) /
             SUM(networth_billion), 1) AS pct_of_wealth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld;

-- Q18. Richest person in each industry
SELECT industry, name, networth_billion
FROM (SELECT *,
             ROW_NUMBER() OVER (PARTITION BY industry
                                ORDER BY networth_billion DESC) AS rn
      FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld) AS ranked
WHERE rn = 1
ORDER BY networth_billion DESC;

-- Q19. Countries with the most Technology billionaires
SELECT country, COUNT(*) AS tech_billionaires
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
WHERE industry = 'Technology'
GROUP BY country
ORDER BY tech_billionaires DESC
LIMIT 5;

-- Q20. Industries of the under-50 billionaires
SELECT industry, COUNT(*) AS billionaires_under_50
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
WHERE age < 50
GROUP BY industry
ORDER BY billionaires_under_50 DESC;

-- Q21. Gap between each billionaire and the next one down the list
SELECT name, rank, networth_billion,
       ROUND(networth_billion - LEAD(networth_billion) OVER (ORDER BY rank), 1) AS gap_to_next
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
ORDER BY gap_to_next DESC
LIMIT 3;

-- Q22a. Entries listed as family fortunes
SELECT COUNT(*) AS family_entries
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
WHERE name LIKE '%family%';

-- Q22b. Countries and industries covered
SELECT COUNT(DISTINCT country) AS countries,
       COUNT(DISTINCT industry) AS industries
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld;

-- ============================================================
-- PART 2: JOINS (Q23-Q30)
-- The dataset has one table, so two small lookup tables are created
-- (country -> continent, and a list of continents) to practise JOINs.
-- Russia and Cyprus are grouped under Europe.
-- ============================================================

-- Q23a. Create the lookup table that links each country to a continent
CREATE TABLE country_region (
    country   TEXT PRIMARY KEY,
    continent TEXT
);

INSERT INTO country_region (country, continent) VALUES
('Australia','Oceania'),
('Austria','Europe'),
('Brazil','South America'),
('Canada','North America'),
('Chile','South America'),
('China','Asia'),
('Colombia','South America'),
('Cyprus','Europe'),
('Czech Republic','Europe'),
('Denmark','Europe'),
('France','Europe'),
('Germany','Europe'),
('Hong Kong','Asia'),
('India','Asia'),
('Indonesia','Asia'),
('Israel','Asia'),
('Italy','Europe'),
('Japan','Asia'),
('Malaysia','Asia'),
('Mexico','North America'),
('Netherlands','Europe'),
('Nigeria','Africa'),
('Philippines','Asia'),
('Russia','Europe'),
('Singapore','Asia'),
('South Africa','Africa'),
('South Korea','Asia'),
('Spain','Europe'),
('Sweden','Europe'),
('Switzerland','Europe'),
('Taiwan','Asia'),
('Thailand','Asia'),
('United Arab Emirates','Asia'),
('United Kingdom','Europe'),
('United States','North America');

-- Q23b. Create a list of all seven continents
CREATE TABLE continent_list (continent TEXT PRIMARY KEY);

INSERT INTO continent_list (continent) VALUES
('Africa'),('Antarctica'),('Asia'),('Europe'),
('North America'),('Oceania'),('South America');

-- Q24. INNER JOIN: number of billionaires and total wealth by continent
SELECT cr.continent,
       COUNT(*) AS billionaires,
       ROUND(SUM(b.networth_billion), 1) AS total_wealth,
       ROUND(100.0 * SUM(b.networth_billion) /
             (SELECT SUM(networth_billion)
              FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld), 1) AS pct_of_wealth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld AS b
INNER JOIN country_region AS cr
        ON b.country = cr.country
GROUP BY cr.continent
ORDER BY total_wealth DESC;

-- Q25. LEFT JOIN (data check): billionaires whose country has no continent
-- An empty result means every billionaire was matched
SELECT b.country, COUNT(*) AS unmatched_billionaires
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld AS b
LEFT JOIN country_region AS cr
       ON b.country = cr.country
WHERE cr.country IS NULL
GROUP BY b.country;

-- Q26. LEFT JOIN: all continents, including those with no billionaires
SELECT cl.continent,
       COUNT(b.name) AS billionaires,
       ROUND(COALESCE(SUM(b.networth_billion), 0), 1) AS total_wealth
FROM continent_list AS cl
LEFT JOIN country_region AS cr
       ON cl.continent = cr.continent
LEFT JOIN Top200RichestPersonintheWorldTop200RichestPersonintheWorld AS b
       ON cr.country = b.country
GROUP BY cl.continent
ORDER BY total_wealth DESC;

-- Q27. RIGHT JOIN: how many countries in this dataset belong to each continent
-- (Antarctica appears with 0). RIGHT JOIN works in SQLite 3.39+, MySQL,
-- PostgreSQL and SQL Server.
SELECT cl.continent,
       COUNT(cr.country) AS countries_in_dataset
FROM country_region AS cr
RIGHT JOIN continent_list AS cl
        ON cr.continent = cl.continent
GROUP BY cl.continent
ORDER BY countries_in_dataset DESC;

-- Q28. JOIN + window function: richest billionaire in each continent
SELECT continent, name, country, networth_billion
FROM (SELECT cr.continent, b.name, b.country, b.networth_billion,
             ROW_NUMBER() OVER (PARTITION BY cr.continent
                                ORDER BY b.networth_billion DESC) AS rn
      FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld AS b
      INNER JOIN country_region AS cr
              ON b.country = cr.country) AS ranked
WHERE rn = 1
ORDER BY networth_billion DESC;

-- Q29. JOIN with a subquery: average age and net worth by continent
SELECT cr.continent,
       COUNT(*) AS billionaires,
       ROUND(AVG(b.age), 1) AS avg_age,
       ROUND(AVG(b.networth_billion), 1) AS avg_networth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld AS b
INNER JOIN country_region AS cr
        ON b.country = cr.country
GROUP BY cr.continent
ORDER BY avg_networth DESC;

-- Q30. JOIN to a derived table: billionaires far above their own country's
-- average (countries with at least 5 billionaires)
SELECT b.name, b.country, b.networth_billion,
       ROUND(c.country_avg, 1) AS country_avg,
       ROUND(b.networth_billion - c.country_avg, 1) AS above_country_avg
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld AS b
INNER JOIN (SELECT country, AVG(networth_billion) AS country_avg
            FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
            GROUP BY country
            HAVING COUNT(*) >= 5) AS c
        ON b.country = c.country
ORDER BY above_country_avg DESC
LIMIT 5;

-- Q31. CASE WHEN: billionaires by wealth tier
SELECT CASE WHEN networth_billion >= 100 THEN '1. $100B and above'
            WHEN networth_billion >= 50  THEN '2. $50B - $99B'
            WHEN networth_billion >= 25  THEN '3. $25B - $49B'
            ELSE '4. Under $25B' END AS wealth_tier,
       COUNT(*) AS billionaires,
       ROUND(SUM(networth_billion), 1) AS total_wealth,
       ROUND(100.0 * SUM(networth_billion) /
             (SELECT SUM(networth_billion)
              FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld), 1) AS pct_of_wealth
FROM Top200RichestPersonintheWorldTop200RichestPersonintheWorld
GROUP BY wealth_tier
ORDER BY wealth_tier;
