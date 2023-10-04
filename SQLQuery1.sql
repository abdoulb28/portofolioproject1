-- the data
select*
from portfolio1.dbo.NYPD_Shooting

-- total shooting cases
select count (INCIDENT_KEY) AS CASES
from portfolio1.dbo.NYPD_Shooting


-- reduced columns by useful informations order by occur date

select OCCUR_DATE, BORO, PERP_AGE_GROUP, PERP_RACE, PERP_SEX, VIC_AGE_GROUP, VIC_RACE, VIC_SEX
from portfolio1.dbo.NYPD_Shooting
order by 1,2


-- shooting count happen by boro
select count (INCIDENT_KEY) AS CASES
from portfolio1.dbo.NYPD_Shooting
WHERE BORO = 'BRONX'

select count (INCIDENT_KEY) AS CASES
from portfolio1.dbo.NYPD_Shooting
WHERE BORO = 'BROOKLYN'

select count (INCIDENT_KEY) AS CASES
from portfolio1.dbo.NYPD_Shooting
WHERE BORO = 'MANHATTAN'

select count (INCIDENT_KEY) AS CASES
from portfolio1.dbo.NYPD_Shooting
WHERE BORO = 'QUEENS'

select count (INCIDENT_KEY) AS CASES
from portfolio1.dbo.NYPD_Shooting
WHERE BORO = 'STATEN ISLAND'

SELECT BORO, 
COUNT (INCIDENT_KEY) AS CASES
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY BORO

-- count shooting cases by year and boro

SELECT COUNT (INCIDENT_KEY) AS cases, 
  year (OCCUR_DATE) AS year
FROM portfolio1.dbo.NYPD_Shooting
where (BORO ='BRONX')
GROUP BY year (OCCUR_DATE)
ORDER BY year

SELECT COUNT (INCIDENT_KEY) AS cases, 
  year (OCCUR_DATE) AS year
FROM portfolio1.dbo.NYPD_Shooting
where (BORO ='BROOKLYN')
GROUP BY year (OCCUR_DATE)
ORDER BY year

SELECT COUNT (INCIDENT_KEY) AS cases, 
  year (OCCUR_DATE) AS year
FROM portfolio1.dbo.NYPD_Shooting
where (BORO ='MANHATTAN')
GROUP BY year (OCCUR_DATE)
ORDER BY year

SELECT COUNT (INCIDENT_KEY) AS cases, 
  year (OCCUR_DATE) AS year
FROM portfolio1.dbo.NYPD_Shooting
where (BORO ='QUEENS')
GROUP BY year (OCCUR_DATE)
ORDER BY year

SELECT COUNT (INCIDENT_KEY) AS cases, 
  year (OCCUR_DATE) AS year
FROM portfolio1.dbo.NYPD_Shooting
where (BORO ='STATEN ISLAND')
GROUP BY year (OCCUR_DATE)
ORDER BY year

SELECT BORO,
year (OCCUR_DATE) AS YEAR,
COUNT (INCIDENT_KEY) AS CASES
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY YEAR (OCCUR_DATE), BORO
ORDER BY YEAR

-- total shooting cases by year

SELECT COUNT (INCIDENT_KEY) AS cases, 
  year (OCCUR_DATE) AS year
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY year (OCCUR_DATE)
ORDER BY year

-- boro percentage incident by total number of incidents

SELECT BORO, 
COUNT (INCIDENT_KEY) AS CASES,
count(*) * 100.0 / sum(count(*)) over() AS Percen_boro
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY BORO
ORDER BY BORO


-- BORO percentage incident by total number of incident by year

SELECT BORO,
year (OCCUR_DATE) AS YEAR,
COUNT (INCIDENT_KEY) AS CASES,
count(INCIDENT_KEY) * 100.0 / sum(count(INCIDENT_KEY)) over( partition by year(OCCUR_DATE)) AS Percen_boro
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY YEAR (OCCUR_DATE), BORO
ORDER BY YEAR

-- cases per perp age 

SELECT PERP_AGE_GROUP,
COUNT (INCIDENT_KEY) AS CASES
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY PERP_AGE_GROUP
ORDER BY PERP_AGE_GROUP
 
 UPDATE portfolio1.dbo.NYPD_Shooting
SET PERP_AGE_GROUP = 'UNKNOWN'
WHERE PERP_AGE_GROUP IS NULL

 UPDATE portfolio1.dbo.NYPD_Shooting
SET PERP_AGE_GROUP = 'UNKNOWN'
WHERE PERP_AGE_GROUP = '(null)'

DELETE FROM portfolio1.dbo.NYPD_Shooting WHERE PERP_AGE_GROUP = '1020'
DELETE FROM portfolio1.dbo.NYPD_Shooting WHERE PERP_AGE_GROUP = '940'
DELETE FROM portfolio1.dbo.NYPD_Shooting WHERE PERP_AGE_GROUP = '224'

-- perp age by boro

SELECT BORO, PERP_AGE_GROUP,
COUNT (INCIDENT_KEY) AS CASES
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY BORO, PERP_AGE_GROUP
ORDER BY BORO

-- perp age by boro and by year

SELECT BORO, PERP_AGE_GROUP,
COUNT (INCIDENT_KEY) AS CASES,
 year (OCCUR_DATE) AS year
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY BORO, PERP_AGE_GROUP, YEAR (OCCUR_DATE)
ORDER BY BORO

-- cases per victime age groupe 

SELECT VIC_AGE_GROUP,
COUNT (INCIDENT_KEY) AS CASES
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY VIC_AGE_GROUP
ORDER BY VIC_AGE_GROUP

 UPDATE portfolio1.dbo.NYPD_Shooting
SET VIC_AGE_GROUP = 'UNKNOWN'
WHERE VIC_AGE_GROUP = '1022'


-- victime age by boro

SELECT BORO, VIC_AGE_GROUP,
COUNT (INCIDENT_KEY) AS CASES
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY BORO, VIC_AGE_GROUP
ORDER BY BORO

-- victime age by year and by boro 

SELECT BORO, VIC_AGE_GROUP,
COUNT (INCIDENT_KEY) AS CASES,
 year (OCCUR_DATE) AS year
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY BORO, VIC_AGE_GROUP, YEAR (OCCUR_DATE)
ORDER BY year

-- table by boro, shooting cases, perp age, victime age, by YEAR

SELECT  year (OCCUR_DATE) AS year,
BORO, PERP_AGE_GROUP, VIC_AGE_GROUP,
COUNT (INCIDENT_KEY) AS CASES
 FROM portfolio1.dbo.NYPD_Shooting
 GROUP BY BORO, VIC_AGE_GROUP, PERP_AGE_GROUP, YEAR (OCCUR_DATE)
 ORDER BY year

 -- NEW TABLE CASES BY YEAR, BORO, AND PERCENTAGE PER YEAR

  USE portfolio1
SELECT year (OCCUR_DATE) AS YEAR,
BORO,
COUNT (INCIDENT_KEY) AS CASES,
count(INCIDENT_KEY) * 100.0 / sum(count(INCIDENT_KEY)) over( partition by year(OCCUR_DATE)) AS Percen_boro into NYPD_shooting_per_year1
FROM portfolio1.dbo.NYPD_Shooting
GROUP BY YEAR (OCCUR_DATE), BORO
ORDER BY YEAR
