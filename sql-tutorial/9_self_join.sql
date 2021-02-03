-- How many stops are in the database
SELECT
  count(id)
FROM
  stops;
-- Find the id value for the stop 'Craiglockhart'
SELECT
  id
FROM
  stops
WHERE
  name = 'Craiglockhart';
-- Give the id and the name for the stops on the '4' 'LRT' service
SELECT
  stops.id,
  stops.name
FROM
  route
  JOIN stops ON route.stop = stops.id
WHERE
  route.num = 4
  AND route.company = 'LRT'
ORDER BY
  route.pos;
-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
-- Run the query and notice the two services that link these stops have a count of 2
-- Add a HAVING clause to restrict the output to these two routes
SELECT
  company,
  num,
  COUNT(*)
FROM
  route
WHERE
  STOP = 149
  OR STOP = 53
GROUP BY
  company,
  num
HAVING
  count(*) = 2;
-- Show  the services from Craiglockhart to London Road
SELECT
  a.company,
  a.num,
  a.stop,
  b.stop
FROM
  route a
  JOIN route b ON (
    a.company = b.company
    AND a.num = b.num
  )
WHERE
  a.stop = 53
  AND b.stop = 149;
-- Show the services between 'Craiglockhart' and 'London Road', but this time joining to
SELECT
  a.company,
  a.num,
  stopa.name,
  stopb.name
FROM
  route a
  JOIN route b ON (
    a.company = b.company
    AND a.num = b.num
  )
  JOIN stops stopa ON (a.stop = stopa.id)
  JOIN stops stopb ON (b.stop = stopb.id)
WHERE
  stopa.name = 'Craiglockhart'
  AND stopb.name = 'London Road';
-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT
  DISTINCT a.company,
  a.num
FROM
  route a
  JOIN route b ON (
    a.company = b.company
    AND a.num = b.num
  )
WHERE
  a.stop = 115
  AND b.stop = 137
  OR a.stop = 137
  AND b.stop = 115;
-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT
  a.company,
  a.num
FROM
  route a
  JOIN route b ON (
    a.num = b.num
    AND a.company = b.company
  )
  JOIN stops stopsa ON a.stop = stopsa.id
  JOIN stops stopsb ON b.stop = stopsb.id
WHERE
  stopsa.name = 'Craiglockhart'
  AND stopsb.name = 'Tollcross';
-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company
-- Include the company and bus no. of the relevant services
SELECT
  bus1.num,
  bus1.company,
  bus2.transfer,
  bus2.num,
  bus2.company
FROM
  (
    SELECT
      DISTINCT a.num,
      a.company,
      stopb.name AS transfer
    FROM
      route a
      JOIN route b ON (
        a.num = b.num
        AND a.company = b.company
      )
      JOIN stops stopa ON (stopa.id = a.stop)
      JOIN stops stopb ON (stopb.id = b.stop)
    WHERE
      stopa.name = 'Craiglockhart'
  ) AS bus1
  JOIN (
    SELECT
      DISTINCT a.num,
      a.company,
      stopb.name AS transfer
    FROM
      route a
      JOIN route b ON (
        a.num = b.num
        AND a.company = b.company
      )
      JOIN stops stopa ON (stopa.id = a.stop)
      JOIN stops stopb ON (stopb.id = b.stop)
    WHERE
      stopa.name = 'Lochend'
  ) AS bus2 ON (bus1.transfer = bus2.transfer)
ORDER BY
  bus1.num,
  bus1.transfer,
  bus2.num;
