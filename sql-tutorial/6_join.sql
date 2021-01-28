-- Show the matchid and player name for all goals scored by Germany
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';
-- Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2
  FROM game
where id = 1012;
-- Show the player, teamid, stadium and mdate for every German goal
SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
where teamid = 'GER';
-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
select team1, team2, player
from game JOIN goal ON (id = matchid)
where player like 'Mario%';
-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal join eteam on teamid = id 
 WHERE gtime<=10;
-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach
select mdate, teamname
from game join eteam on (team1 = eteam.id)
where coach = 'Fernando Santos';
-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
select player
from game join goal on (id = matchid)
where stadium = 'National Stadium, Warsaw';
-- Show the name of all players who scored a goal against Germany
select distinct player
from game join goal on (id = matchid)
where id in(SELECT id from game where team1='GER' or team2='GER')
AND teamid!='GER';
-- Show teamname and the total number of goals scored
select teamname, count(player) as goals
from eteam join goal on id=teamid
group by teamname;
-- Show the stadium and the number of goals scored in each stadium
select stadium, count(player) as goals
from game join goal on id=matchid
group by stadium;
-- For every match involving 'POL', show the matchid, date and the number of goals scored
select matchid, mdate as date, count(matchid) as goals from game join goal on id=matchid where team1='POL' or team2= 'POL'
group by matchid, mdate;
-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
select matchid, mdate, count(*)
from game join goal on id = matchid
where teamid = 'GER'
group by matchid, mdate;
-- List every match with the goals scored by each team as shown. Sort your result by mdate, matchid, team1 and team2
select
mdate, 
team1,
sum(case when teamid=team1 then 1 else 0 end) score1,
team2,
sum(case when teamid=team2 then 1 else 0 end) score2
from game join goal on id=matchid
group by matchid, mdate, team1, team2
order by mdate, matchid, team1, team2;