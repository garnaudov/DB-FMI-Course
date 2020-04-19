--I.За базата от данни Movies
USE movies;

SELECT CONCAT(title, year) FROM movie;

--1. Напишете заявка, която извежда имената на актрисите, които са също и
--продуценти с нетни активи над 10 милиона.

--with using subqueries, IN (better)
SELECT mstar.name
FROM moviestar mstar
WHERE gender = 'F' AND name IN (
	SELECT name
	FROM movieexec mexec
	WHERE networth > 10000000
);

--or with using INTERSECT

SELECT name FROM moviestar WHERE gender='F'
INTERSECT
SELECT name	FROM movieexec WHERE networth > 10000000

--2. Напишете заявка, която извежда имената на тези актьори (мъже и жени),
--които не са продуценти.

SELECT name
FROM moviestar
WHERE name NOT IN (
	SELECT name
	FROM movieexec
)

--or 

SELECT name FROM moviestar
EXCEPT
SELECT name	FROM movieexec

--3. Напишете заявка, която извежда имената на всички филми с дължина,
--по-голяма от дължината на филма ‘Star Wars’

SELECT title
FROM movie
WHERE length > (
	SELECT length
	FROM movie
	WHERE title='Star Wars'
);

--4. Напишете заявка, която извежда имената на продуцентите и имената на
--филмите за всички филми, които са продуцирани от продуценти с нетни
--активи по-големи от тези на ‘Merv Griffin’

SELECT e.name, m.title
FROM movie m
JOIN movieexec e ON m.PRODUCERC# = e.CERT#
WHERE networth > (
	SELECT networth
	FROM movieexec
	WHERE name='Merv Griffin'
)
ORDER BY name, title

--II.За базата от данни PC

USE pc;

--1. Напишете заявка, която извежда производителите на персонални
--компютри с честота над 500.

SELECT pr.maker
FROM product pr
WHERE pr.model IN (
	SELECT pc.model
	FROM pc
	WHERE speed > 500
)

--2. Напишете заявка, която извежда код, модел и цена на принтерите с най-висока цена.

SELECT code, model, price
FROM printer
WHERE price = (
	SELECT MAX(price)
	FROM printer
)

--3. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
--честотата на всички персонални компютри.

SELECT *
FROM laptop l
WHERE l.speed < ALL (
	SELECT pc.speed
	FROM pc
)
--4. Напишете заявка, която извежда модела и цената на продукта (PC,
--лаптоп или принтер) с най-висока цена.

SELECT all_product_1.model, all_product_1.price
FROM (
	SELECT model,price
	FROM printer
	UNION ALL
	SELECT model,price
	FROM pc
	UNION ALL
	SELECT model,price
	FROM laptop
) all_product_1
WHERE price=(
	SELECT MAX(all_products_2.price)
	FROM (
		SELECT model,price
		FROM printer
		UNION ALL
		SELECT model,price
		FROM pc
		UNION ALL
		SELECT model,price
		FROM laptop
	) all_products_2
)

--5. Напишете заявка, която извежда производителя на цветния принтер с
--най-ниска цена.

SELECT prod.maker
FROM product prod
WHERE prod.model IN (
	SELECT pr.model
	FROM printer pr
	WHERE pr.price = (
		SELECT MIN(price)
		FROM printer pr
		WHERE pr.color='y'
		) AND pr.color='y'
)

--6. Напишете заявка, която извежда производителите на тези персонални
--компютри с най-малко RAM памет, които имат най-бързи процесори.

SELECT maker
FROM product
WHERE product.model IN (
	SELECT pc.model
	FROM pc
	WHERE ram =(
		SELECT MIN(ram)	FROM pc
		) AND speed = (
			SELECT MAX(pc_min_ram.speed)
			FROM (
				SELECT speed
				FROM pc
				WHERE ram =(
					SELECT MIN(ram)
					FROM pc
					)
			) pc_min_ram
		) 
)

--III.За базата от данни SHIPS
USE ships;

--1. Напишете заявка, която извежда страните, чиито кораби са с най-голям
--брой оръдия.

SELECT DISTINCT c.country
FROM classes c
WHERE c.numguns = (
	SELECT MAX(c.numguns)
	FROM classes c
)

--2. Напишете заявка, която извежда класовете, за които поне един от
--корабите е потънал в битка.

SELECT DISTINCT s.class
FROM ships s
WHERE s.name IN (
	SELECT o.ship
	FROM outcomes o
	WHERE o.result = 'sunk'
)

--3. Напишете заявка, която извежда името и класа на корабите с 16 инчови
--оръдия.

SELECT s.name, s.class
FROM ships s
WHERE s.class IN (
	SELECT c.class
	FROM classes c
	WHERE c.bore='16'
)

--4. Напишете заявка, която извежда имената на битките, в които са
--участвали кораби от клас ‘Kongo’.

SELECT o.battle
FROM outcomes o
WHERE o.ship IN (
	SELECT s.name
	FROM ships s
	WHERE s.class = 'Kongo'
)

--5. Напишете заявка, която извежда класа и името на корабите, чиито брой
--оръдия е по-голям или равен на този на корабите със същия калибър
--оръдия.
