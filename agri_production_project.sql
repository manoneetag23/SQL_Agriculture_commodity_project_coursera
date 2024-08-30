 /* SQL for DS Project by Manoneet Gawali*/ 
 /* RUN the Query individually after Importing csv data for results.*/
 
 
/* total milk production for the year 2023 */
SELECT SUM(Value) TOTAL_MILK_PRODUCTION
FROM milk_production 
WHERE Year = '2023';
 
/* coffee production data for the year 2015 */
SELECT SUM(Value) TOTAL_COFFEE_PRODUCTION
FROM coffee_production 
WHERE Year = '2015';

/*average honey production for the year 2022*/
SELECT AVG(Value) AVG_PRODUCTION
FROM honey_production 
WHERE Year = '2022'; 

/* state names with their corresponding ANSI codes from the state_lookup table */
/* State "Iowa" */
SELECT
 ST.State_ANSI
FROM DBO.state_lookup ST
WHERE ST.State = 'Iowa';

/*states where both honey and milk were produced in 2022 */
/* State_ANSI “35” produce both honey and milk in 2022 */
SELECT *
FROM state_lookup SL
LEFT JOIN DBO.honey_production HP
ON SL.State_ANSI  = HP.State_ANSI
LEFT JOIN DBO.milk_production MP
ON SL.State_ANSI = MP.State_ANSI
WHERE HP.Year = '2022' 
AND MP.Year = '2022'
AND SL.State_ANSI = '35';

/*highest yogurt production value for the year 2022 */
SELECT MAX(Value) 
FROM yogurt_production 
WHERE Year = '2022';

/*Total yogurt production for states that also produced cheese in 2022*/
SELECT SUM(YP.Value) TOTAL_YOGHURT_PRODUCTION
FROM DBO.yogurt_production YP
WHERE YP.Year = '2022'
 AND YP.State_ANSI IN (
  SELECT DISTINCT
   CP.State_ANSI
  FROM DBO.cheese_production CP
  WHERE CP.Year = '2022'
 );
 
 /*total milk production for 2023*/
 SELECT SUM(P.Value) TOTAL_MILK_PRODUCTION_2023
FROM milk_production P
WHERE P.Year = 2023;

/*states had cheese production greater than 100 million in April 2023*/
SELECT L.State,L.State_ANSI
FROM cheese_production P
INNER JOIN state_lookup L
ON P.State_ANSI = L.State_ANSI
WHERE P.Value > 100000000
 AND P.Period = 'APR'
 AND P.Year = 2023;

/*total value of coffee production for 2011*/
SELECT P.Year, SUM(P.Value) TOTAL_COFFEE_PRO_IN_2011
FROM coffee_production P
GROUP BY P.Year
HAVING P.Year = 2011;

/*average honey production for 2022*/
SELECT AVG(P.Value) AVG_HONEY_PRO_IN_2022
FROM honey_production P
WHERE P.Year = 2022;

/*State_ANSI code for Florida*/
SELECT *
FROM state_lookup L
WHERE L.State = 'FLORIDA';

/* cheese production value total for NEW JERSEY*/
SELECT L.State, SUM(P.Value) TOTAL_CHEESE_PRODUCTION
FROM state_lookup L
LEFT JOIN cheese_production P
ON L.State_ANSI = P.State_ANSI
WHERE P.Period = 'APR'
 AND P.Year = 2023
GROUP BY L.State
HAVING L.State = 'NEW JERSEY';

/*total yogurt production for states in the year 2022 which also have cheese production data from 2023*/
SELECT SUM(YP.Value) TOTAL_YOGHURT_PRODUCTION
FROM DBO.yogurt_production YP
WHERE YP.Year = '2022'
 AND YP.State_ANSI IN (
  SELECT DISTINCT
   CP.State_ANSI
  FROM DBO.cheese_production CP
  WHERE CP.Year = '2023'
 );

/*State that are missing from milk production in 2023*/
SELECT COUNT(DISTINCT S.State) COUNT_OF_MISSING_MILK_PRODUCTION_STATE_IN_2023
FROM DBO.state_lookup S
LEFT JOIN DBO.milk_production P
ON S.State_ANSI = P.State_ANSI
 AND P.Year = 2023
WHERE P.State_ANSI IS NULL;

/*Delaware production of cheese in April 2023*/
SELECT DISTINCT S.State, --P.Period,P.Year,--P.Value,--s.state
 ISNULL(P.Value, 0) AS production_amount
FROM DBO.state_lookup S
LEFT JOIN DBO.cheese_production P
ON P.State_ANSI = S.State_ANSI 
 AND P.Year = 2023
 AND P.Period = 'APR'
WHERE S.State = 'DELAWARE';

/*average coffee production for all years where the honey production exceeded 1 million*/
SELECT AVG(P.Value) AVERAGE_COFFEE_PRODUCTION
FROM DBO.coffee_production P
WHERE P.Year IN (
 SELECT
  HP.Year
 FROM dbo.honey_production HP
 WHERE HP.Value > 1000000
);



