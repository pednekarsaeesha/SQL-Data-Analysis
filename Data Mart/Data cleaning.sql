#Data Cleaning
/* Data Cleansing Steps
In a single query, perform the following operations and generate a new table in the data_mart schema named clean_weekly_sales:

Convert the week_date to a DATE format

Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc

Add a month_number with the calendar month for each week_date value as the 3rd column

Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values

Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value

segment	age_band
1	Young Adults
2	Middle Aged
3 or 4	Retirees
Add a new demographic column using the following mapping for the first letter in the segment values:
segment	demographic
C	Couples
F	Families
Ensure all null string values with an "unknown" string value in the original segment column as well as the new age_band and demographic columns

Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record
*/


use data_mart;
select * from data_mart;

set sql_safe_updates =0;

UPDATE data_mart 
SET 
    week_date = DATE_FORMAT(STR_TO_DATE(week_date, '%d/%m/%Y'),
            '%Y-%m-%d'); 

alter table data_mart
modify column week_date varchar(10);

describe data_mart;

select * from data_mart;

UPDATE data_mart 
SET 
    week_date = DATE_FORMAT(STR_TO_DATE(week_date, '%d/%m/%Y'),
            '%Y-%m-%d'); 


alter table data_mart
MODIFY COLUMN week_date date;
	
alter table data_mart
add column week_no int after week_date;

select * from data_mart;

UPDATE data_mart 
SET 
    week_no = WEEK(week_date);

alter table data_mart
add column month_no int after week_date;

UPDATE data_mart 
SET 
    month_no = MONTH(week_date);

alter table data_mart
add column calender_year int after month_no;


UPDATE data_mart 
SET 
    calender_year = YEAR(week_date);

alter table data_mart
add column age_band varchar(20) after segment;

UPDATE data_mart 
SET 
    age_band = CASE
        WHEN RIGHT(segment, 1) = '1' THEN 'Young adults'
        WHEN RIGHT(segment, 1) = '2' THEN 'Middle-aged'
        WHEN
            RIGHT(segment, 1) = '3'
                OR RIGHT(segment, 1) = '4'
        THEN
            'Retirees'
        ELSE 'Unknown'
    END;



alter table data_mart
add column demographic varchar(20) after age_band;

UPDATE data_mart 
SET 
    demographic = CASE
        WHEN LEFT(segment, 1) = 'C' THEN 'Couples'
        WHEN LEFT(segment, 1) = 'F' THEN 'Families'
        ELSE 'Unknown'
    END;



alter table data_mart
add column avg_transaction int after sales;

UPDATE data_mart 
SET 
    avg_transaction = ROUND((sales / transactions), 2);


select * from data_mart;
