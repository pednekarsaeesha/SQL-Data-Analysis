select * from facts;

#1.What is the total population of all countries in the dataset?
SELECT 
    SUM(population) AS total_population
FROM
    facts
WHERE
    name != 'World';

#2.What is the name and population of the country with the highest population?

SELECT 
    name, SUM(population) AS highest_population
FROM
    facts
WHERE
    name != 'World'
GROUP BY population
ORDER BY SUM(population) DESC
LIMIT 1;


#3.What is the name and population of the country with the lowest population?
SELECT 
    name, SUM(population) AS lowest_population
FROM
    facts
WHERE
    name != 'World'
GROUP BY population
HAVING SUM(population) != 0
ORDER BY SUM(population) ASC
LIMIT 1;



#4.What is the average population across all countries?
SELECT 
    AVG(population) AS avg_population
FROM
    facts
WHERE
    name != 'World';

#5.What is the average population growth rate across all countries?

SELECT 
    AVG(population_growth) AS average_population_growth
FROM
    facts;

#6.Which country has the highest population growth rate?
SELECT 
    name, SUM(population_growth) AS highest_growth_rate
FROM
    facts
WHERE
    name != 'World'
GROUP BY name
ORDER BY highest_growth_rate DESC
LIMIT 1;

#7.Which country has the highest birth rate?
SELECT 
    name, max(birth_rate) AS highest_birth_rate
FROM
    facts
ORDER BY highest_birth_rate DESC
LIMIT 1;

#8.Which country has the highest death rate?
SELECT 
    name, max(death_rate) AS highest_death_rate
FROM
    facts
ORDER BY highest_death_rate DESC
LIMIT 1;


#9.Which country has the highest migration rate?

SELECT 
    name, max(migration_rate) AS highest_migration_rate
FROM
    facts
ORDER BY highest_migration_rate DESC
LIMIT 1;

#10.Which country has the largest area?
SELECT 
    name, max(area) AS highest_area
FROM
    facts
ORDER BY highest_area DESC
LIMIT 1;

#11.Which country has the largest land area?
select name,max(area_land) as highest_land_area from facts order by highest_land_area desc limit 1;

#12.Which country has the largest water area?
select name,max(area_water) as highest_water_area from facts order by highest_water_area desc limit 1;


#13.What is the population density (population per square kilometer) of each country?
SELECT name, population/area_land AS population_density
FROM facts
ORDER BY population_density DESC;

#14.Which country has the highest population density?
SELECT name, population/area_land AS population_density
FROM facts 
ORDER BY population_density DESC;

#15.Which country has the lowest population density?
SELECT name, population/area_land AS population_density
FROM facts group by name having population_density!=0
ORDER BY population_density asc limit 1;




