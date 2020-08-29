/*SELECT MIN(yearid), MAX(yearid)
FROM teams;

Q1: 1871 Through 2016*/

/*found minimum height to be 43
SELECT MIN(CAST(height AS int))
FROM people;*/

/*SELECT CONCAT(namefirst,' ',namelast) AS Full_name, MIN(p.height), a.g_all, t.name
FROM people p
LEFT JOIN appearances a
ON p.playerid = a.playerid
LEFT JOIN teams t
ON a.teamid = t.teamid
WHERE p.playerid = 'gaedeed01'
GROUP BY Full_name, a.g_all, t.name;

Q2 Eddie Gaedel, his height was '43' and he played one game for the St. Louis Browns*/

/*SELECT *
FROM collegeplaying
WHERE schoolid ILIKE 'vandy';*/

--above query to figure out vandy school ID

/*SELECT p.playerid, p.nameFirst, p.nameLast, SUM(s.salary) AS total_salary
FROM salaries s
LEFT JOIN people p
ON s.playerid = p.playerid
LEFT JOIN collegeplaying c
ON c.playerid = s.playerid
WHERE schoolid = 'vandy'
GROUP BY p.playerid
ORDER BY SUM(s.salary) DESC;

Q3 The highest paid player from Vandy was David Price with a total salary of 245553888 in the majors.*/

/*SELECT 
	CASE 
		WHEN pos = 'OF' THEN 'Outfield'
		WHEN pos = 'SS' OR
			 pos = '1B' OR
			 pos = '2B' OR
			 pos = '3B' THEN 'Infield'
		WHEN pos = 'P'  OR
			 pos = 'C'  THEN 'Battery'
		END as position_bucket,
	SUM(po)
FROM fielding
WHERE yearid = '2016'
GROUP BY position_bucket;

Q4 Infield 58934, Battery 41424, Outfield 29560*/

/*SELECT
	CASE
		WHEN yearid > '2009' THEN '2010s'
		WHEN yearid > '1999' THEN '2000s'
		WHEN yearid > '1989' THEN '1990s'
		WHEN yearid > '1979' THEN '1980s'
		WHEN yearid > '1969' THEN '1970s'
		WHEN yearid > '1959' THEN '1960s'
		WHEN yearid > '1949' THEN '1950s'
		WHEN yearid > '1939' THEN '1940s'
		WHEN yearid > '1929' THEN '1930s'
		WHEN yearid > '1919' THEN '1920s'
		END AS year_bin,
		ROUND(AVG(so),2) AS avg_strikeout,
		ROUND(AVG(hr),2) AS avg_homerun
FROM(
	SELECT yearid, HR, SO
	FROM pitching
	UNION ALL
	SELECT yearid, HR, SO
	FROM pitchingpost) AS subquery
GROUP BY year_bin
ORDER BY year_bin;

Q5: There was a spike in both averages beginnings in the 50's for homeruns and the 60's for strikeouts, both of which tapered off again over the next few decades*/


/*WITH subquery AS(

	SELECT yearid, playerid, sb, cs, (sb + cs) AS stolen_atmpt
	FROM batting
	WHERE sb > '0' Or cs > '0'
	UNION ALL
	SELECT yearid, playerid, sb, cs, (sb + cs) AS stolen_atmpt
	FROM battingpost
	WHERE sb > '0' OR cs > '0'
)

SELECT 
	CONCAT(p.nameFIRST,' ',nameLAST) AS playername, 
	MAX(sb/stolen_atmpt::numeric) AS stl_sccss
FROM subquery
LEFT JOIN people p
ON subquery.playerid = p.playerid
WHERE yearid = '2016' AND stolen_atmpt >= '20'
GROUP BY playername
ORDER BY stl_sccss DESC;

Q6: Chris Owings with %91.304 success rate */

/*SELECT name, MAX(w)
FROM teams
WHERE
	WSWin = 'Y' AND
	yearid >= '1970'
GROUP BY name
ORDER BY MIN(w);*/

--Above query is to find the teams with the least or most wins who won or lost the world series.

/*SELECT 
	SUM(maxchamp::integer) / COUNT(*)::numeric AS percent_maxchamp
FROM(
WITH most_wins_year AS (
	SELECT yearid, MAX(w) AS High_wins
	FROM teams
	GROUP BY yearid
	ORDER BY yearid
),
WSchamp_wins AS (
	SELECT name AS WSchamp, w AS champ_wins, yearid
	FROM teams
	WHERE WSwin = 'Y'
	ORDER BY yearid
)
SELECT 
	most_wins_year.yearid, 
	High_wins, WSchamp, 
	champ_wins,
	CASE
	WHEN high_wins = champ_wins THEN '1'
		ELSE '0' END AS maxchamp
FROM most_wins_year
LEFT JOIN WSchamp_wins
ON most_wins_year.yearid = WSchamp_wins.yearid
WHERE most_wins_year.yearid >= '1970') AS combo_table;

Q7: Seattle Mariners 116 didn't win. LA Dodgers 63 did win, there was a players strike which let them get to the WS
with so few wins. If you exclude 1981, the least wins to win the World
Series was 83 by the St. Louis Cardinals in 2006. The team with the most wins wins the world series %25.53 of the time.*/