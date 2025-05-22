SELECT
  d.forename || ' ' || d.surname AS driver_name,
  c.name AS constructor_name,
  r.name AS race_name,
  rs.position,
  rs.points
FROM formula1.results rs
INNER JOIN formula1.drivers d ON rs.driverId = d.driverId
INNER JOIN formula1.constructors c ON rs.constructorId = c.constructorId
INNER JOIN formula1.races r ON rs.raceId = r.raceId
WHERE r.year = 2023
ORDER BY r.round, rs.position;



WITH race_results_cte AS (
  SELECT
    rs.resultId,
    d.forename || ' ' || d.surname AS driver_name,
    c.name AS constructor_name,
    r.name AS race_name,
    r.year,
    r.round,
    rs.position,
    rs.points
  FROM formula1.results rs
  INNER JOIN formula1.drivers d ON rs.driverId = d.driverId
  INNER JOIN formula1.constructors c ON rs.constructorId = c.constructorId
  INNER JOIN formula1.races r ON rs.raceId = r.raceId
)
SELECT
  driver_name,
  constructor_name,
  race_name,
  position,
  points
FROM race_results_cte
WHERE year = 2023
ORDER BY round, position;



WITH sprint_performance AS (
  SELECT
    sr.sprintResultId,
    d.forename || ' ' || d.surname AS driver_name,
    c.name AS constructor_name,
    r.name AS race_name,
    r.year,
    r.round,
    sr.position,
    sr.points
  FROM formula1.sprintResults sr
  INNER JOIN formula1.drivers d ON sr.driverId = d.driverId
  INNER JOIN formula1.constructors c ON sr.constructorId = c.constructorId
  INNER JOIN formula1.races r ON sr.raceId = r.raceId
)
SELECT
  driver_name,
  constructor_name,
  race_name,
  position,
  points
FROM sprint_performance
WHERE year = 2023
ORDER BY round, position;

-- Fastest Lap Time in Each Race
SELECT
  r.name AS race_name,
  d.forename || ' ' || d.surname AS driver_name,
  MIN(lt.milliseconds) AS fastest_lap_ms
FROM formula1.lapTimes lt
INNER JOIN formula1.drivers d ON lt.driverId = d.driverId
INNER JOIN formula1.races r ON lt.raceId = r.raceId
GROUP BY r.name, d.forename, d.surname
ORDER BY r.name, fastest_lap_ms;


--  Driver with the Fastest Pit Stop in a Given Year- 2023

SELECT
  d.forename || ' ' || d.surname AS driver_name,
  r.name AS race_name,
  ps.milliseconds AS pit_stop_ms
FROM formula1.pitStops ps
INNER JOIN formula1.drivers d ON ps.driverId = d.driverId
INNER JOIN formula1.races r ON ps.raceId = r.raceId
WHERE r.year = 2023
ORDER BY ps.milliseconds ASC
LIMIT 1;

-- Average Lap Time per Driver in a Specific Race

SELECT
  d.forename || ' ' || d.surname AS driver_name,
  AVG(lt.milliseconds) AS avg_lap_time_ms
FROM formula1.lapTimes lt
INNER JOIN formula1.drivers d ON lt.driverId = d.driverId
--WHERE lt.raceId = 1050  -- replace with actual raceId
GROUP BY d.driverId, d.forename, d.surname
ORDER BY avg_lap_time_ms ASC;

-- Total Time Spent in Pit Stops per Driver for the Season

SELECT
  d.forename || ' ' || d.surname AS driver_name,
  SUM(ps.milliseconds) AS total_pit_time_ms
FROM formula1.pitStops ps
INNER JOIN formula1.drivers d ON ps.driverId = d.driverId
INNER JOIN formula1.races r ON ps.raceId = r.raceId
WHERE r.year = 2023
GROUP BY d.driverId, d.forename, d.surname
ORDER BY total_pit_time_ms;


-- Compare Race Time Between Drivers

SELECT
  d.forename || ' ' || d.surname AS driver_name,
  r.name AS race_name,
  rs.milliseconds AS race_time_ms,
  r.year as year 
FROM formula1.results rs
INNER JOIN formula1.drivers d ON rs.driverId = d.driverId
INNER JOIN formula1.races r ON rs.raceId = r.raceId
WHERE r.year = 2023 AND rs.milliseconds IS NOT NULL
ORDER BY race_time_ms asc;

-- Rank Drivers by Fastest Lap Time in Each Race


SELECT
r.year,
  r.name AS race_name,
  d.forename || ' ' || d.surname AS driver_name,
  lt.lap,
  lt.milliseconds,
  (lt.milliseconds || ' milliseconds')::interval AS time_formatted,
  RANK() OVER (PARTITION BY lt.raceId order by lt.milliseconds ASC) AS lap_rank
FROM formula1.lapTimes lt
INNER JOIN formula1.drivers d ON lt.driverId = d.driverId
INNER JOIN formula1.races r ON lt.raceId = r.raceId
WHERE lt.milliseconds IS NOT NULL
ORDER BY r.name, lap_rank;



-- list top 5 fastest rounds in each race. 

with table_cte as (
SELECT
r.year,
  r.name AS race_name,
  d.forename || ' ' || d.surname AS driver_name,
  lt.milliseconds,
  (lt.milliseconds || ' milliseconds')::interval AS time_formatted,
  RANK() OVER (PARTITION BY lt.raceId order by lt.milliseconds ASC) AS lap_rank
FROM formula1.lapTimes lt
INNER JOIN formula1.drivers d ON lt.driverId = d.driverId
INNER JOIN formula1.races r ON lt.raceId = r.raceId
--inner join formula1.results rs on rs.raceId=r.raceId
WHERE lt.milliseconds IS NOT NULL )
select * from table_cte c
where lap_rank between 1 and 5 
order by year desc, milliseconds asc



-- 
SELECT 
    d.forename || ' ' || d.surname AS driver_name,
    r.raceid,                   
    d.driverId,            
    d.forename,            
    d.surname,            
    d.number,
	--r.fastestlapspeed,A
    CAST(AVG(ROUND(r.fastestlapspeed::FLOAT)) AS INT) AS average_fastest_lap_speed
FROM formula1.results r
INNER JOIN formula1.drivers d ON r.driverId = d.driverId  
LEFT JOIN formula1.lapTimes lt ON r.raceId = lt.raceId AND r.driverId = lt.driverId  -- Join lapTimes to calculate fastest lap
GROUP BY r.raceId, d.driverId, d.forename, d.surname, d.number
ORDER BY r.raceId, d.surname;



-- Lap-by-Lap Performance Data with Status for Driver(s) in the 2024 Season - Race "Australian Grand Prix"

SELECT
  d.number AS driver_number,
  l.time,
  l.milliseconds AS lap_time_ms,
  l.raceId,
  l.position,
  l.lap AS lap_number,
  d.forename || ' ' || d.surname AS driver_name,
  r.name AS race_name,
  rs.milliseconds AS race_time_ms,
  (rs.milliseconds || ' milliseconds')::interval AS time_formatted,
  r.year AS year,
  r.date AS race_date,
  CASE 
    WHEN s.status = 'Engine' THEN 'Engine Failure'
    WHEN s.status = 'Brakes' THEN 'Brake Failure'
    ELSE s.status 
  END AS race_status
FROM formula1.results rs
INNER JOIN formula1.drivers d ON rs.driverId = d.driverId
INNER JOIN formula1.races r ON rs.raceId = r.raceId
INNER JOIN formula1.laptimes l ON l.raceId = rs.raceId AND l.driverId = rs.driverId
INNER JOIN formula1.status s ON rs.statusId = s.statusId
WHERE r.year = 2024
 -- AND d.number = 44
  AND l.raceId = 1123
ORDER BY l.lap, l.milliseconds;


-- constructor standings 

SELECT 
    c.constructorId,
    c.name AS constructor_name,
    r.raceId,
    r.name AS race_name,
    r.date,
    cs.points,
    cs.position,
    cs.wins
FROM 
    formula1.constructorstandings cs
JOIN 
    formula1.constructors c ON cs.constructorId = c.constructorId
JOIN 
    formula1.races r ON cs.raceId = r.raceId
	order by cs.points desc;


-- The winners only table:
select "raceId" from formula1.races ;
where raceid=18

select * from formula1.results
where raceid=18

with driver_wins as (
SELECT 
    r.year,
	r.date,
	d.number,
    r.name AS race_name,
	d.forename || ' ' || d.surname AS driver_name,
    d.nationality,
    res.position AS race_position,
	count(res.position) over (partition by d.driverid order by year) as total_number_of_wins, 
    count(res.position) over (partition by d.driverid,r.year order by year) as number_of_wins_perseason,-- -- total number of wins per season
    ds.points AS championship_points,
    ds.position AS championship_position
FROM formula1.results res
left JOIN formula1.races r ON res.raceId = r."raceId"
left join formula1.drivers d ON res.driverId = d.driverId
left join formula1.driverstandings ds 
    ON ds.raceId = r."raceId" AND ds.driverId = d.driverId
	--where year=2024
	where res.position=1
	--and d.number=33 
	)
select dw.year,
dw.date,
dw.race_name,
dw.race_position,
dw.driver_name,
dw.total_number_of_wins,
dw.number_of_wins_perseason
from driver_wins dw
ORDER BY total_number_of_wins desc,year desc;


# --------

-- status count by season  

SELECT 
    distinct(d.driverRef),
    d.number,
    d.forename || ' ' || d.surname AS driver_name,
    r.year,
    s.status,
    --COUNT(s.status) AS statuscount,
	count(s.status) OVER (PARTITION BY s.status, r.year) AS total_points
FROM formula1.results res
INNER JOIN formula1.status s ON res.statusId = s."statusId"
INNER JOIN formula1.races r ON res.raceId = r."raceId"
INNER JOIN formula1.drivers d ON res.driverId = d.driverId
where d.number!=0
and driverref='piastri'

ORDER BY 
r.year desc,
    total_points DESC;


select distinct(status) from formula1.status


SELECT *
FROM crosstab(
    $$SELECT 
        d.driverRef || '_' || r.year AS driver_year,
        s.status,
        COUNT(*) AS status_count
    FROM formula1.results res
    INNER JOIN formula1.status s ON res.statusId = s."statusId"
    INNER JOIN formula1.races r ON res.raceId = r."raceId"
    INNER JOIN formula1.drivers d ON res.driverId = d.driverId
    WHERE d.number != 0
	 AND d.driverRef like '%piastri%'
    GROUP BY d.driverRef, r.year, s.status
    ORDER BY r.year DESC, s.status$$,

    $$SELECT unnest(ARRAY[
	    '+1 Lap',
        'Electrical',
        'Fuel pipe',
        'Brake duct',
        'Gearbox',
        'Finished',
        'Disqualified',
        'Turbo',
        'Crankshaft',
        'Power Unit',
        'Suspension',
        'Collision',
        'Wheel nut',
        'ERS',
        'Water leak',
        'Mechanical',
		'Collision damage',
		'Radiator'
		
    ])::text$$
) AS ct (
    driver_year text,
	"+1 Lap" int,
    "Electrical" int,
    "Fuel pipe" int,
    "Brake duct" int,
    "Gearbox" int,
    "Finished" int,
    "Disqualified" int,
    "Turbo" int,
    "Crankshaft" int,
    "Power Unit" int,
    "Suspension" int,
    "Collision" int,
    "Wheel nut" int,
    "ERS" int,
    "Water leak" int,
    "Mechanical" int,
	"Collision damage" int,
	"Radiator" int
);