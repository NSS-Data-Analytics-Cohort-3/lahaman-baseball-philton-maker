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

SELECT *
FROM pitching;