SELECT * FROM mydb.`life-expectancy-data-updated`;
# DATA PREVIEW

select * from `life-expectancy-data-updated`;


 #1 WHICH COUNTRIES ARE REPRESENTED IN THE DATASET?
 
select distinct(country) from `life-expectancy-data-updated`;


#2 HOW MANY UNIQUE COUNTRIES ARE THERE IN THE DATASET?

select count(distinct(country)) from `life-expectancy-data-updated`;


#3 WHAT IS THE AVERAGE LIFE EXPECTANCY FOR EACH COUNTRY? LIST THEM FROM HIGHEST TO LOWEST

select country , AVG(Life_expectancy) AS average_life_expectancy
FROM life_exp_up group by country 
order by average_life_expectancy desc;


#4 WHAT IS THE AVERAGE LIFE EXPECTANCY WITHIN EACH REGION? LIST THEM FROM HIGHEST TO LOWEST

select region , AVG(Life_expectancy) AS average_life_expectancy
FROM `life-expectancy-data-updated` group by region 
order by average_life_expectancy desc;


#5 WHAT IS THE AVERAGE POPULATION IN MILLIONS FOR EACH COUNTRY? LIST THEM IN DESCENDING ORDER

select country , AVG(Population_mln) AS average_population
FROM `life-expectancy-data-updated` group by country 
order by average_population desc;

#6 Find the region with the lowest average adult mortality rate.
SELECT Region, AVG(Adult_mortality) as Lowest_Average_Adult_Mortality
FROM `life-expectancy-data-updated`
GROUP BY Region
ORDER BY AVG(Adult_mortality) ASC
LIMIT 1;


#7 HOW HAS LIFE EXPECTANCY CHANGED OVER THE YEARS GLOBALLY 

select year, avg(life_expectancy) as averagelife_expectancy from `life-expectancy-data-updated`
group by year order by year;


#8 HOW HAS LIFE EXPECTANCY CHANGED OVER THE YEARS FOR A SPECIFIC COUNTRY

select year, avg(life_expectancy) as averagelife_expectancy from `life-expectancy-data-updated`
where country = "India" group by year order by year;


#9 HOW MANY COUNTRIES HAVE A LIFE EXPECTANCY OF 80 YEARS OR MORE IN EACH YEAR, AND HOW HAS THIS NUMBER CHANGED OVER THE YEARS?

select Year, count(Country) AS Number_of_Countries
from `life-expectancy-data-updated`
where life_expectancy >= 80 group by Year order by year;



 #10 IDENTIFY COUNTRIES WITH AN INCREASE IN LIFE EXPECTANCY OF MORE THAN 5 YEARS SINCE 2000.
 
select Country, MAX(Life_expectancy) - MIN(Life_expectancy) as Increase_in_Life_Expectancy
from `life-expectancy-data-updated`
group by  Country
having Increase_in_Life_Expectancy > 5;


#11 WHAT IS THE AVERAGE LIFE EXPECTANCY FOR EACH ECONOMIC STATUS CATEGORY IN THE DATASET?

select CASE 
        WHEN Economy_status_Developed = 1 THEN 'Developed' 
        ELSE 'Developing' 
END AS Economic_Status, AVG(Life_expectancy) AS Average_Life_Expectancy
from `life-expectancy-data-updated` group by Economic_Status;


#12 DETERMINE THE YEAR WITH THE HIGHEST NUMBER OF MEASLES OUTBREAKS ACROSS ALL COUNTRIES.

select Year, SUM(Measles) AS Total_Measles_Cases
from `life-expectancy-data-updated`
GROUP BY Year ORDER BY Total_Measles_Cases DESC LIMIT 1;


#13 HOW HAVE VACCINATION CAMPAIGNS (E.G., HEPATITIS B, POLIO) AFFECTED DISEASE PREVALENCE AND LIFE EXPECTANCY?

select avg(life_expectancy) from `life-expectancy-data-updated` where polio > (select avg(polio) from `life-expectancy-data-updated`);
select avg(life_expectancy) from `life-expectancy-data-updated` where polio < (select avg(polio) from `life-expectancy-data-updated`);


select avg(life_expectancy) from `life-expectancy-data-updated` where  Hepatitis_B > (select avg(Hepatitis_B) from `life-expectancy-data-updated`);
select avg(life_expectancy) from `life-expectancy-data-updated` where  Hepatitis_B < (select avg(Hepatitis_B) from `life-expectancy-data-updated`);



#14 LIST THE TOP 5 COUNTRIES WITH THE HIGHEST LIFE EXPECTANCY GROWTH RATE FROM 2000 TO 2015.

SELECT t1.Country, ((t2.life_expectancy - t1.life_expectancy) / t1.life_expectancy) * 100 as LifeExp_Growth_Rate
FROM `life-expectancy-data-updated` t1
JOIN `life-expectancy-data-updated` t2 ON t1.Country = t2.Country AND t2.Year = 2015
WHERE t1.Year = 2000
ORDER BY  LifeExp_Growth_Rate DESC
LIMIT 5;


#15 LIST THE TOP 5 COUNTRIES WITH THE HIGHEST GDP GROWTH RATE FROM 2000 TO 2015.

SELECT t1.Country, ((t2.GDP_per_capita - t1.GDP_per_capita) / t1.GDP_per_capita) * 100 as GDP_Growth_Rate
FROM `life-expectancy-data-updated` t1
JOIN `life-expectancy-data-updated` t2 ON t1.Country = t2.Country AND t2.Year = 2015
WHERE t1.Year = 2000
ORDER BY GDP_Growth_Rate DESC
LIMIT 5;



#16 CALCULATE THE AVERAGE ALCOHOL CONSUMPTION PER DECADE.

SELECT FLOOR(Year / 10) * 10 AS Decade, AVG(Alcohol_consumption) AS Avg_Alcohol_Consumption
FROM `life-expectancy-data-updated`
GROUP BY Decade;


#17 HOW DOES GDP CORRELATE WITH LIFE EXPECTANCY? 

select (count(*) * sum(GDP_per_capita * life_expectancy) - sum(GDP_per_capita ) * sum(life_expectancy)) /  
(sqrt((count(*) * sum(GDP_per_capita  * GDP_per_capita ) - sum(GDP_per_capita) * sum(GDP_per_capita)) * (count(*) * sum(life_expectancy* life_expectancy) - sum(life_expectancy) 
* sum(life_expectancy)))) as correlation from `life-expectancy-data-updated`;

#18 IS THERE ANY CORRELATIONS BETWEEN BMI AND LIFE EXPECTANCY?

select (count(*) * sum(BMI * life_expectancy) - sum(BMI) * sum(life_expectancy)) /  
(sqrt((count(*) * sum(BMI  * BMI) - sum(BMI) * sum(BMI)) * (count(*) * sum(life_expectancy* life_expectancy) - sum(life_expectancy) 
* sum(life_expectancy)))) as correlation from `life-expectancy-data-updated`;

#19 HOW DOES ADULT MORTALITY CORRELATE WITH LIFE EXPECTANCY?

select (count(*) * sum(adult_mortality * life_expectancy) - sum(adult_mortality) * sum(life_expectancy)) /  
(sqrt((count(*) * sum(adult_mortality  * adult_mortality) - sum(adult_mortality) * sum(adult_mortality)) * 
(count(*) * sum(life_expectancy * life_expectancy) - sum(life_expectancy) 
* sum(life_expectancy)))) as correlation from `life-expectancy-data-updated`;

#20 IS THERE A CORRELATION BETWEEN LIFE EXPECTANCY AND SCHOOLING?

SELECT (COUNT(*) * SUM(schooling * life_expectancy) - SUM(schooling) *
 SUM(life_expectancy)) /(SQRT((COUNT(*) * SUM(schooling * schooling) - SUM(schooling) * SUM(schooling)) *
 (COUNT(*) * SUM(life_expectancy * life_expectancy) - SUM(life_expectancy) * SUM(life_expectancy))))
 AS correlation from `life-expectancy-data-updated`;
