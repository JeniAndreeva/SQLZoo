1. How many stops are in the database.

SELECT COUNT(stops.id) AS Stops
FROM stops

2.Find the id value for the stop 'Craiglockhart'

SELECT id
FROM stops
WHERE name ='Craiglockhart'

3.Give the id and the name for the stops on the '4' 'LRT' service.

SELECT id, name
FROM stops
JOIN route ON(route.stop=stops.id)
WHERE num ='4'
AND company ='LRT'

4. The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53).
   Run the query and notice the two services that link these stops have a count of 2. 
   Add a HAVING clause to restrict the output to these two routes.
   
SELECT company,num,COUNT(*)
FROM route WHERE stop = 149 OR stop = 53
GROUP BY company,num
HAVING COUNT(*) = 2

5.Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, 
without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.

SELECT a.company, a.num, a.stop, b.stop
FROM route a
JOIN route b ON (a.num = b.num)
WHERE a.stop = 53
AND b.stop = 149

6.The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to
stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' 
are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a 
JOIN route b ON(a.company=b.company AND a.num=b.num)
JOIN stops stopa ON (a.stop=stopa.id)
JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' and stopb.name = 'London Road'

7.Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

SELECT a.company,a.num 
FROM route a 
JOIN route b ON (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop=137
GROUP BY a.company,a.num;

8.Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b ON(a.company=b.company AND a.num=b.num) 
JOIN stops stopa ON (stopa.id=a.stop)
JOIN stops stopb ON (stopb.id=b.stop)
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'

9.Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus,
including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.

SELECT DISTINCT stop1.name, route1.company, route1.num 
FROM stops stop1,stops stop2,route route1,route route2
WHERE stop2.id=route2.stop
AND   stop2.name='Craiglockhart'
AND   route2.company=route1.company
AND   route2.num=route1.num
AND   route1.stop=stop1.id

10.Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer,
and the bus no. and company for the second bus.

SELECT bus1.num, bus1.company, name, bus2.num, bus2.company 
FROM (SELECT start1.num, start1.company, stop1.stop FROM route start1 
JOIN route stop1 ON start1.num=stop1.num AND start1.company=stop1.company AND start1.stop!=stop1.stop AND start1.stop=(SELECT id FROM stops WHERE name='Craiglockhart')) bus1

JOIN (SELECT start2.num, start2.company, start2.stop FROM route start2 
JOIN route stop2 ON start2.num=stop2.num AND start2.company=stop2.company AND start2.stop!=stop2.stop AND stop2.stop=(SELECT id FROM stops WHERE name='Lochend')) bus2

ON bus1.stop=bus2.stop
JOIN stops ON stops.id=bus1.stop;









