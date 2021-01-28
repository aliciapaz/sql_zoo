-- List the films where the yr is 1962 [Show id, title]
SELECT
  id,
  title
FROM
  movie
WHERE
  yr = 1962;
-- Give year of 'Citizen Kane'
SELECT
  yr
FROM
  movie
WHERE
  title = 'Citizen Kane';
-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year
SELECT
  id,
  title,
  yr
FROM
  movie
WHERE
  title LIKE ('%Star Trek%')
ORDER BY
  yr;
-- What id number does the actor 'Glenn Close' have?
SELECT
  id
FROM
  actor
WHERE
  name = 'Glenn Close';
-- What is the id of the film 'Casablanca'
SELECT
  id
FROM
  movie
WHERE
  title = 'Casablanca';
-- Obtain the cast list for 'Casablanca'
SELECT
  name
FROM
  actor
  JOIN casting ON (id = actorid)
WHERE
  movieid = (
    SELECT
      id
    FROM
      movie
    WHERE
      title = 'Casablanca'
  );
-- Obtain the cast list for the film 'Alien'
SELECT
  name
FROM
  actor
  JOIN casting ON (id = actorid)
WHERE
  movieid = (
    SELECT
      id
    FROM
      movie
    WHERE
      title = 'Alien'
  );
-- List the films in which 'Harrison Ford' has appeared
SELECT
  DISTINCT title
FROM
  movie
  JOIN casting ON (id = movieid)
WHERE
  id IN(
    SELECT
      movieid
    FROM
      casting
      JOIN actor ON (actorid = id)
    WHERE
      name = 'Harrison Ford'
  );
-- List the films where 'Harrison Ford' has appeared - but not in the starring role
SELECT
  DISTINCT title
FROM
  movie
  JOIN casting ON (id = movieid)
WHERE
  id IN(
    SELECT
      movieid
    FROM
      casting
      JOIN actor ON (actorid = id)
    WHERE
      name = 'Harrison Ford'
      AND ord != 1
  );
-- List the films together with the leading star for all 1962 films
SELECT
  title,
  name
FROM
  movie
  JOIN casting ON (id = movieid)
  JOIN actor ON actorid = actor.id
WHERE
  yr = 1962
  AND ord = 1;
