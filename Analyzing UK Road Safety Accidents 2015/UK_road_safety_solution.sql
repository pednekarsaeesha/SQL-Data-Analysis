#1 .What is the total number of accidents recorded in the dataset?
SELECT 
    COUNT(DISTINCT Accident_Index) AS total_num_of_accidents
FROM
    accidents;

#ans: 30194 the total number of accidents recorded in the dataset.

#2.What are the total number of accidents that occurred in the month of December in the year 2015?
SELECT 
    SUBSTRING(date, 4, 2) AS Dec_month,
    COUNT(*) AS no_of_accidents
FROM
    accidents
WHERE
    SUBSTRING(date, 4, 2) = 12;

#ans: 2480 are the total number of accidents that occurred in the month of December in the year 2015.

#3.What is the percentage of accidents that occurred on weekdays versus weekends in the year 2016?
SELECT 
    CASE
        WHEN Day_of_Week IN (1 , 2, 3, 4, 5) THEN 'Weekday'
        WHEN Day_of_Week = 6 OR 7 THEN 'Weekend'
    END AS versus,
    ROUND((COUNT(*) / 30194) * 100, 2) AS percentage_of_accidents
FROM
    accidents
GROUP BY versus;

#ans: Weekday 71.54 ,Weekend 28.46 the percentage of accidents that occurred on weekdays versus weekends in the year 2015


#4.What percentage of accidents occurred on a motorway?
SELECT 
    COUNT(*) AS motarway_accident,
    COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            accidents) * 100 AS percent_of_accidents
FROM
    accidents
WHERE
    1st_Road_Class = 1;

#ans: motarway_accident 455,1.5069 percentage of accidents occurred

#5.How many accidents involved male drivers? How many involved female drivers?

SELECT 
    Sex_of_Driver,
    COUNT(*),
    CASE
        WHEN Sex_of_Driver = 1 THEN 'M'
        WHEN Sex_of_Driver = 2 THEN 'F'
        ELSE 'other'
    END AS Sex
FROM
    vehicles_2015
GROUP BY Sex_of_Driver;

#ans:1506 Male and 664 Female accident involved drivers


#6.Which type of vehicle was involved in the most accidents? How many accidents did it account for?

SELECT 
    v.Vehicle_Type, t.label, COUNT(*) AS accident_count
FROM
    vehicles_2015 v
        JOIN
    vehicle_types t ON v.Vehicle_Type = t.code
GROUP BY v.Vehicle_Type
ORDER BY accident_count DESC
LIMIT 1;

 #ans : Car type of vehicle was involved in the most accidents ,1734 accidents it accounted for.

#7.What was the most common speed limit for accidents to occur? How many accidents occurred in this speed limit?
SELECT 
    Speed_limit AS most_common_limit,
    COUNT(*) AS accidents_occured
FROM
    accidents
GROUP BY Speed_limit
ORDER BY accidents_occured DESC
LIMIT 1;

#ans:30  the most common speed limit for accidents to occur ,25733accidents occurred in this speed limit

#8.What was the average number of vehicles involved in accidents?
SELECT 
    AVG(Number_of_Vehicles) AS average_no_of_vehicles
FROM
    accidents;

#9.What was the average age of drivers involved in accidents?
SELECT 
    AVG(Age_of_Driver) AS avg_age_of_driver
FROM
    vehicles_2015;

#ans: 1.7894 was the average age of drivers involved in accidents.

#10.How many accidents were fatal? What percentage of all accidents does this represent?
  SELECT 
    COUNT(*) AS no_of_fatal_accidents,
    COUNT(*) / (SELECT 
            COUNT(*)
        FROM
            accidents) * 100 AS percent_of_fatal_accidents
FROM
    accidents
WHERE
    Accident_Severity = 1;
  
  #ans: 194 accidents were fatal,0.6425 percentage of all accidents.

#11.Which day of the week had the most accidents? How many accidents occurred on this day?
SELECT 
    Day_of_Week, COUNT(*) AS no_of_accidents_occured
FROM
    accidents
GROUP BY Day_of_Week
ORDER BY COUNT(*) DESC
LIMIT 1;

#ans: 6 day of the week had the most accidents, 4703 accidents occurred on this day.

#12.What was the most common type of road surface for accidents to occur? How many accidents occurred on this type of surface?
SELECT 
    COUNT(*) AS no_of_accidents, Road_surface_conditions
FROM
    accidents
GROUP BY Road_surface_conditions
ORDER BY COUNT(*) DESC
LIMIT 1;

#ans : Dry was the most common type of road surface for accidents to occur, 24621 accidents occurred on this type of surface.

#13.How many accidents occurred in each month of 2015?
SELECT 
    SUBSTRING(Date, 4, 2) AS month_no,
    COUNT(*) AS accidents_occured
FROM
    accidents
GROUP BY month_no;

#14.What is the correlation between speed limit and accident severity?
SELECT 
    AVG(Accident_Severity), Speed_limit
FROM
    accidents
GROUP BY Speed_limit
ORDER BY speed_limit;

#15.Which age group had the highest number of casualties in 2015?
SELECT 
    v.Age_of_Driver,
    v.Age_Band_of_Driver,
    SUM(a.Number_of_casualties) AS highest_no_casualties
FROM
    Vehicles_2015 v
        JOIN
    accidents a ON v.Accident_Index = a.Accident_Index
GROUP BY v.Age_Band_of_Driver
ORDER BY highest_no_casualties DESC
LIMIT 1;

#ans: 6 group had the highest number of casualties in 2015

#16.Which police force had the highest number of accidents?
SELECT 
    police_force, COUNT(*)
FROM
    accidents
GROUP BY police_force
ORDER BY COUNT(*) DESC
LIMIT 1;

#ans: Metropolitan Police had the highest number of accidents.

#17.What was the most common accident severity level?
SELECT 
    Accident_Severity AS most_common_accident_severity_level
FROM
    accidents
GROUP BY Accident_Severity
ORDER BY COUNT(*) DESC
LIMIT 1;

#ans : slight was the most common accident severity level.

#18.What was the average number of casualties per accident?
SELECT 
    ROUND(AVG(number_of_casualties), 0)
FROM
    accidents;

#ans: 1 was the average number of casualties per accident.

#19.What was the most common time of day for accidents to occur?


SELECT 
    time,
    SUBSTRING(time, 1, 2) AS time_of_day,
    COUNT(*) AS No_of_accidents
FROM
    accidents
GROUP BY time_of_day
ORDER BY No_of_accidents DESC
LIMIT 1;


#20.What was the average time of day when accidents occurred?

SELECT 
    ROUND(AVG(SUBSTRING(time, 1, 2)), 0) AS avg_time_of_day
FROM
    accidents;

#ans: 14 was average time of day when accidents occurred.


#21.What was the most common day of the week for accidents to occur?
SELECT 
    day_of_week, COUNT(*) AS No_of_accidents
FROM
    accidents
GROUP BY day_of_week
ORDER BY No_of_accidents DESC
LIMIT 1;

#ans: 6 was the most common day of the week for accidents to occur.

#22.How many accidents occurred on each day of the week in 2015?

SELECT 
    day_of_week, COUNT(*) AS No_of_accidents
FROM
    accidents
GROUP BY day_of_week
ORDER BY day_of_week;





