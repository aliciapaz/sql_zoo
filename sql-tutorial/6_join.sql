-- Show the matchid and player name for all goals scored by Germany
SELECT
  matchid,
  player
FROM
  goal
WHERE
  teamid = 'GER';
-- Show id, stadium, team1, team2 for just game 1012
SELECT
  id,
  stadium,
  team1,
  team2
FROM
  game
WHERE
  id = 1012;
-- Show the player, teamid, stadium and mdate for every German goal
SELECT
  player,
  teamid,
  stadium,
  mdate
FROM
  game
  JOIN goal ON (id = matchid)
WHERE
  teamid = 'GER';
-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT
  team1,
  team2,
  player
FROM
  game
  JOIN goal ON (id = matchid)
WHERE
  player LIKE 'Mario%';
-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT
  player,
  teamid,
  coach,
  gtime
FROM
  goal
  JOIN eteam ON teamid = id
WHERE
  gtime <= 10;
-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach
SELECT
  mdate,
  teamname
FROM
  game
  JOIN eteam ON (team1 = eteam.id)
WHERE
  coach = 'Fernando Santos';
-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT
  player
FROM
  game
  JOIN goal ON (id = matchid)
WHERE
  stadium = 'National Stadium, Warsaw';
-- Show the name of all players who scored a goal against Germany
SELECT
  DISTINCT player
FROM
  game
  JOIN goal ON (id = matchid)
WHERE
  id IN(
    SELECT
      id
    FROM
      game
    WHERE
      team1 = 'GER'
      OR team2 = 'GER'
  )
  AND teamid != 'GER';
-- Show teamname and the total number of goals scored
SELECT
  teamname,
  count(player) AS goals
FROM
  eteam
  JOIN goal ON id = teamid
GROUP BY
  teamname;
-- Show the stadium and the number of goals scored in each stadium
SELECT
  stadium,
  count(player) AS goals
FROM
  game
  JOIN goal ON id = matchid
GROUP BY
  stadium;
-- For every match involving 'POL', show the matchid, date and the number of goals scored
SELECT
  matchid,
  mdate AS date,
  count(matchid) AS goals
FROM
  game
  JOIN goal ON id = matchid
WHERE
  team1 = 'POL'
  OR team2 = 'POL'
GROUP BY
  matchid,
  mdate;
-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT
  matchid,
  mdate,
  count(*)
FROM
  game
  JOIN goal ON id = matchid
WHERE
  teamid = 'GER'
GROUP BY
  matchid,
  mdate;
-- List every match with the goals scored by each team as shown. Sort your result by mdate, matchid, team1 and team2
SELECT
  mdate,
  team1,
  sum(
    CASE
      WHEN teamid = team1 THEN 1
      ELSE 0
    END
  ) score1,
  team2,
  sum(
    CASE
      WHEN teamid = team2 THEN 1
      ELSE 0
    END
  ) score2
FROM
  game
  JOIN goal ON id = matchid
GROUP BY
  matchid,
  mdate,
  team1,
  team2
ORDER BY
  mdate,
  matchid,
  team1,
  team2;
