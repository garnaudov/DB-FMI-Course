
--I.За базата от данни Movies
USE movies;

--1. Напишете заявка, която извежда имената на актьорите мъже, участвали във
--филма The Usual Suspects.

SELECT name FROM moviestar WHERE gender='M'
INTERSECT
SELECT starname FROM starsin WHERE movietitle = 'The Usual Suspects';

--2. Напишете заявка, която извежда имената на актьорите, участвали във филми от
--1995, продуцирани от студио MGM.

SELECT DISTINCT starname
FROM starsin, movie
WHERE movieyear=1995 AND studioname='MGM';

--3. Напишете заявка, която извежда имената на продуцентите, които са
--продуцирали филми на студио MGM.

SELECT DISTINCT name
FROM movieexec, movie
WHERE PRODUCERC# = CERT# AND STUDIONAME='MGM';

--4. Напишете заявка, която извежда имената на всички филми с дължина, поголяма от дължината на филма Star Wars.

SELECT title
FROM movie
WHERE LENGTH > (
	SELECT length
	FROM movie
	WHERE title='Star Wars'
);

--5. Напишете заявка, която извежда имената на продуцентите с нетни активи поголеми от тези на Stephen Spielberg.

SELECT name
FROM movieexec
WHERE networth > (
	SELECT networth
	FROM MOVIEEXEC
	WHERE name='Stephen Spielberg'
);

--6. Напишете заявка, която извежда имената на всички филми, които са
--продуцирани от продуценти с нетни активи по-големи от тези на Stephen
--Spielberg.

SELECT title
FROM movie
WHERE PRODUCERC# in (
	SELECT cert#
	FROM movieexec
	WHERE NETWORTH > (
		SELECT networth
		FROM movieexec
		WHERE name='Stephen Spielberg'
	)
)

--II.За базата от данни PC
USE pc;

--1. Напишете заявка, която извежда производителя и честотата на лаптопите с
--размер на диска поне 9 GB.

SELECT DISTINCT maker,speed
FROM laptop l
JOIN product p ON p.model = l.model 
WHERE type='Laptop' AND hd>9

--2. Напишете заявка, която извежда модел и цена на продуктите, произведени от
--производител с име B.


--3. Напишете заявка, която извежда производителите, които произвеждат лаптопи,
--но не произвеждат персонални компютри.

SELECT DISTINCT maker FROM product WHERE type='Laptop'
EXCEPT
SELECT DISTINCT maker FROM product WHERE type='PC'

--4. Напишете заявка, която извежда размерите на тези дискове, които се предлагат
--в поне два различни персонални компютъра (два компютъра с различен код).

--5. Напишете заявка, която извежда двойките модели на персонални компютри,
--които имат еднаква честота и памет. Двойките трябва да се показват само по
--веднъж, например само (i, j), но не и (j, i).

USE pc;
SELECT p1.model as model_1, p2.model as model_2, p1.speed, p1.ram
FROM pc p1
JOIN pc p2 ON p1.speed = p2.speed AND p1.ram = p2.ram AND p1.model < p2.model;

--6. Напишете заявка, която извежда производителите на поне два различни
--персонални компютъра с честота поне 400.

--III.За базата от данни SHIPS
USE ships;

--1. Напишете заявка, която извежда името на корабите с водоизместимост над
--50000.
--2. Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на
--всички кораби, участвали в битката при Guadalcanal.
--3. Напишете заявка, която извежда имената на тези държави, които имат както
--бойни кораби, така и бойни крайцери.
--4. Напишете заявка, която извежда имената на тези кораби, които са били
--повредени в една битка, но по-късно са участвали в друга битка.

SELECT DISTINCT * FROM (
	SELECT o.ship, o.result, b.date
	FROM outcomes o
	JOIN battles b ON o.battle=b.name
	WHERE o.result='damaged') data1	JOIN (
		SELECT o.ship,o.result,b.date
		FROM outcomes o
		JOIN battles b ON o.battle=b.name
	) data2	ON data1.date < data2.date AND data1.ship = data2.ship
