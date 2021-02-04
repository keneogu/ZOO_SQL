1. How many stops are in the database.
SELECT COUNT(name)
FROM stops

2. Find the id value for the stop 'Craiglockhart'
SELECT id
FROM stops
WHERE name = 'Craiglockhart'

3. Give the id and the name for the stops on the '4' 'LRT' service.
SELECT id, name
FROM stops
  JOIN route
  ON id = stop
WHERE num = '4' AND company = 'LRT';

4. 
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

5. 
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop=149

6.
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

7.
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company =b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith'

8.
SELECT DISTINCT a.company, a.num
FROM route a
  JOIN route b ON (a.num=b.num AND a.company=b.company)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'

9.
SELECT DISTINCT stopb.name, a.company, a.num
FROM route a
  JOIN route b
  ON a.company = b.company AND a.num = b.num
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart';

10.
SELECT b.num, b.company, stops.name, d.num, d.company
  FROM route a
    JOIN route b ON a.num = b.num AND a.company = b.company
    JOIN (route c JOIN route d ON c.num = d.num AND c.company = d.company)
    JOIN stops ON b.stop = stops.id
  WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')
    AND c.stop = (SELECT id FROM stops WHERE name = 'Lochend')
    AND b.stop = d.stop ORDER BY b.num, b.company, stops.name, d.num;
