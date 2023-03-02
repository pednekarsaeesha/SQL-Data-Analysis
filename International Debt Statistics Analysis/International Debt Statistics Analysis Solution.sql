create schema database5;
use database5;
select * from ids_data;

#1. How many unique countries are there in the dataset?.
SELECT 
    COUNT(DISTINCT country_name) AS no_of_unique_countries
FROM
    ids_data;

#3. Finding out the distinct debt indicators.
SELECT 
    COUNT(DISTINCT indicator_code) AS unique_debt_indicators
FROM
    ids_data;

#4. Totaling the amount of debt owed by the countries
SELECT 
    SUM(debt) AS total_amount
FROM
    ids_data;

#5Which country has the highest amount of debt in the dataset? What is the amount?

SELECT 
    country_name, SUM(debt) AS highest_debt
FROM
    ids_data
GROUP BY country_name
ORDER BY highest_debt DESC
LIMIT 1;

#6. Average amount of debt across indicators
SELECT 
    indicator_code, AVG(debt) AS avg_amount, indicator_name
FROM
    ids_data
GROUP BY indicator_name
ORDER BY avg_amount;

#7. The highest amount of principal repayments.
SELECT 
    *
FROM
    ids_data
WHERE
    indicator_name = 'Principal repayments on external debt, long-term (AMT, current US$)'
ORDER BY debt DESC
LIMIT 1;
 
#8. The most common debt indicator
SELECT 
    indicator_name,
    indicator_code,
    COUNT(indicator_code) AS numbers
FROM
    ids_data
GROUP BY indicator_code
ORDER BY numbers DESC limit 1;

#9.What is the total amount of debt owed by all countries in the dataset?
SELECT 
    country_name, SUM(debt)
FROM
    ids_data
GROUP BY country_name;


#10.Which country has the lowest amount of debt in the dataset? What is the amount?
SELECT 
    country_name, SUM(debt) AS lowest_debt
FROM
    ids_data
GROUP BY country_name
ORDER BY lowest_debt ASC
LIMIT 1;

#11.What is the average debt amount for all countries in the dataset?
SELECT 
    country_name, AVG(debt) AS avg_debt_amount
FROM
    ids_data
GROUP BY country_name
ORDER BY avg_debt_amount;

#12.What are the top 5 countries with the highest debt amount?
SELECT 
    country_name, SUM(debt) AS highest_debt
FROM
    ids_data
GROUP BY country_name
ORDER BY highest_debt DESC
LIMIT 5;

#13.What are the top 5 indicators with the highest debt amount?
SELECT 
    indicator_code, indicator_name, SUM(debt) AS highest_debt
FROM
    ids_data
GROUP BY indicator_code
ORDER BY highest_debt DESC
LIMIT 5;

#14.Which country has the most diverse set of indicators with debt greater than 0?
SELECT country_name, COUNT(DISTINCT indicator_name) AS unique_indicators
FROM ids_data
WHERE debt > 0
GROUP BY country_name
ORDER BY unique_indicators DESC limit 1
;