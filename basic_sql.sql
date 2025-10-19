SELECT * 
FROM artistes;

SELECT 
	nom,
	style_musical
FROM artistes;

SELECT DISTINCT
	style_musical
FROM artistes;

SELECT *
FROM artistes
WHERE pays = 'USA';

SELECT * 
FROM artistes
WHERE pays != 'USA';

SELECT *
FROM artistes
WHERE pays <> 'France';

SELECT *
FROM artistes
WHERE style_musical = 'Jazz'
AND pays = 'France';

SELECT *
FROM artistes
WHERE nom LIKE 'D%';

SELECT *
FROM artistes
WHERE nom LIKE '%s';

SELECT *
FROM artistes
WHERE style_musical LIKE '%Jazz%';

SELECT  *
FROM artistes
WHERE style_musical ILIKE '%jazz%';

SELECT *
FROM artistes
WHERE style_musical NOT ILIKE '%jazz%';

SELECT  *
FROM artistes
WHERE pays = 'USA' OR pays = 'France';

SELECT *
FROM artistes
WHERE pays IN ('USA', 'France');

SELECT *
FROM artistes
WHERE style_musical ILIKE '%jazz%'
AND (pays ilike '%USA%' OR pays ILIKE '%France%');

SELECT 
	a.nom,
	a.pays
FROM artistes AS a
WHERE a.pays ILIKE '%inde%';

SELECT *
FROM artistes a
ORDER BY a.style_musical;

SELECT *
FROM artistes a
ORDER BY a.style_musical ASC;

SELECT *
FROM artistes a
ORDER BY a.style_musical DESC;

SELECT
	c.id_concert,
	s.nom AS nom_scene
FROM concerts AS c
INNER JOIN scenes AS s ON c.id_scene = s.id_scene ;

SELECT
	f.*,
	c.*
FROM festivaliers f 
INNER JOIN inscriptions i ON f.id_festivalier = i.id_festivalier 
INNER JOIN concerts c ON i.id_concert = c.id_concert;

SELECT
	c.
FROM artistes a
INNER JOIN participations p ON a.id_artiste = p.id_artiste 
INNER JOIN concerts c ON p.id_concert = c.id_concert;

