-- =====================================================================
-- NORTHWIND – EXERCICES 
-- =====================================================================

-- ---------------------------------------------------------------------
-- DÉCOUVERTE & EXPLORATION
-- ---------------------------------------------------------------------
-- Afficher l’ensemble des informations disponibles pour les products.
SELECT *
FROM products; 

-- Afficher le product_name, la quantity_per_unit et le unit_price des products.
SELECT 
	product_name,
	quantity_per_unit,
	unit_price
FROM products; 

-- Afficher la liste des pays uniques présents chez les customers, triés de A à Z.
SELECT DISTINCT 
	country
FROM customers 
order BY country; 

-- Afficher les 10 produits au prix unitaire le plus bas.
SELECT *
FROM products 
ORDER BY unit_price ASC
LIMIT 10;

-- Afficher les suppliers dont le siège est situé aux USA ou en France.
SELECT *
FROM suppliers AS s  
WHERE s.country = 'USA' 
OR s.country = 'France';

SELECT *
FROM suppliers AS s  
WHERE s.country IN ('USA','France');

-- Afficher les customers dont le company_name commence par la lettre A.
SELECT *
FROM customers c
WHERE company_name ILIKE 'A%';

-- Afficher les products dont le unit_price se situe dans une fourchette entre 10 à 20.
SELECT 
	product_name, 
	unit_price
FROM products
WHERE unit_price BETWEEN 10 AND 20
ORDER BY unit_price ASC;

-- Afficher les commandes les plus récentes d’après leur order_date.
SELECT *
FROM orders
ORDER BY order_date DESC;

-- Afficher les customers installés dans un pays différent de Germany.
SELECT *
FROM customers c 
WHERE c.country != 'Germany';

SELECT *
FROM customers c 
WHERE c.country <> 'Germany';


-- Afficher les shippers triés par company_name.
SELECT *
FROM shippers s 
ORDER BY company_name ASC; 


-- ---------------------------------------------------------
-- FILTRES ET CONDITIONS COMBINÉES
-- ---------------------------------------------------------
-- Afficher les products encore vendus (discontinued = 1) dont le unit_price dépasse 30.
SELECT *
FROM products 
WHERE discontinued = 1 
AND unit_price > 30;

-- Afficher les customers localisés aux USA ou au UK dont la city est renseignée.
SELECT *
FROM customers c 
WHERE country IN ('USA', 'UK')
	AND city IS NOT NULL;

-- Afficher les employees dont la city correspond à London sans tenir compte de la casse.
SELECT *
FROM employees e 
WHERE city ILIKE 'LONDON';

-- Afficher les orders déjà expédiées avant le 1er juillet 1997.
SELECT *
FROM orders o 
WHERE order_date < '1997-07-01';

-- Afficher les suppliers dont le company_name contient le mot “Ltd”.
SELECT *
FROM suppliers 
WHERE company_name ILIKE '%Ltd%';

-- Afficher les products avec un stock strictement supérieur à 50 ou avec strictement plus de 50 unités en commande.
SELECT * 
FROM products p
WHERE p.units_in_stock > 50
	OR p.units_on_order > 50;

-- Afficher les customers dépourvus de numéro de fax.
SELECT * 
FROM customers c
WHERE c.fax IS NULL;
-- Afficher les orders dont le freight est supérieur à 200, classées du plus au moins élevé.
SELECT *
FROM orders o
WHERE o.freight > 200
ORDER BY o.freight DESC;

-- Afficher les employees ne rendant compte à aucun supérieur (pas de reports_to).
SELECT * 
FROM employees e
WHERE e.reports_to IS NULL;

-- Afficher les products dont le product_name ne contient pas le mot sauce.
SELECT *
FROM products p
WHERE p.product_name NOT ILIKE '%sauce%';


-- ----------------------------------------
-- RELATIONS ENTRE TABLES (JOINTURES)
-- ----------------------------------------
-- Afficher les orders associées au customer qui les a passées.

SELECT 
	o.*,
	c.company_name 
FROM orders o 
LEFT JOIN customers c ON o.customer_id = c.customer_id ;

-- Afficher les products enrichis de leur category_name et du supplier concerné.

SELECT 
	p.product_name,
	s.company_name,
	c.category_name 
FROM products p 
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
INNER JOIN categories c ON c.category_id = p.category_id;

-- Afficher les orders reliées à la fois au customer et au shipper utilisés.

SELECT 
	o.order_id,
	c.company_name,
	s.company_name 
FROM orders o 
INNER JOIN customers c ON c.customer_id = o.customer_id 
INNER JOIN shippers s ON s.shipper_id = o.ship_via ;

-- Afficher les customers et leurs commandes même lorsqu’ils n’ont passé aucune order.
SELECT c.company_name,
	 o.order_id 
FROM customers c 
LEFT JOIN orders o ON o.customer_id = c.customer_id;


-- Afficher les employees avec le nom de leur manager.
SELECT 
	e1.last_name AS employee_last_name,
	e1.first_name AS employee_first_name,
	e2.last_name AS manager_last_name,
	e2.first_name AS manager_first_name
FROM employees e1 
INNER JOIN employees e2 ON e1.reports_to = e2.employee_id; 


-- Afficher, pour chaque ligne de order_details, le product correspondant, la quantity et le unit_price appliqué.
SELECT 
    od.order_id,
    od.product_id,
    p.product_name,
    od.quantity,
    od.unit_price
FROM order_details od
INNER JOIN products p 
    ON p.product_id = od.product_id;


-- Afficher les customers n’ayant jamais passé de commande.
SELECT 
    c.*
FROM customers c
LEFT JOIN orders o 
    ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;


-- Afficher les produits qui n'apparaissent dans aucune commande.
SELECT 
    p.*
FROM products p
LEFT JOIN order_details od 
    ON od.product_id = p.product_id
WHERE od.order_id IS NULL;



-- ------------------------------------------
-- AGRÉGATIONS ET SYNTHÈSES
-- ------------------------------------------
-- Afficher le nombre de customers par country.
-- Afficher le nombre de products par category.
-- Afficher le prix moyen des products pour chaque supplier.
-- Afficher l’order au coût de transport (freight) le plus élevé.
-- Afficher, pour chaque order, le montant total calculé à partir des order_details.
-- Afficher les categories dont le prix moyen des products dépasse une valeur donnée.
-- Afficher les countries comptant un volume notable de customers.
-- Afficher les suppliers disposant d’un large catalogue de products.
-- Afficher la quantité moyenne commandée pour chaque product.
-- Afficher le chiffre d’affaires total regroupé par ship_country.


-- ---------------------------------------------
-- SOUS-REQUÊTES
-- ---------------------------------------------
-- Afficher les products dont le unit_price dépasse la moyenne globale des products.
-- Afficher les products dont le unit_price dépasse la moyenne de leur propre category.
-- Afficher les customers ayant déjà passé au moins une order.
-- Afficher les customers n’ayant jamais passé d’order en évitant les pièges liés aux valeurs manquantes.
-- Afficher les products apparaissant dans un grand nombre d’orders distinctes.
-- Afficher les orders dont le total dépasse la moyenne de l’ensemble des orders.
-- Afficher les employees dont le volume d’orders gérées excède la moyenne des employees.
-- Afficher les products plus chers que tous les products de la category 'Beverages'.
-- Afficher les customers ayant commandé au moins un product au prix unitaire maximal du catalogue.
-- Afficher les suppliers proposant au moins un product au prix unitaire maximal.


-- --------------------------------------------------------------
-- REQUÊTES AVANCEES
-- --------------------------------------------------------------
-- Afficher un classement des categories selon le total des ventes réalisées.
-- Afficher les customers ayant au moins une order expédiée par un transporteur donné.
-- Afficher le product le plus commandé (en quantité totale) ainsi que le chiffre d’affaires qu’il génère.
-- Afficher le mois présentant le plus fort chiffre d’affaires.
-- Afficher, pour chaque category, un ensemble d’indicateurs : nombre de products, prix moyen, stock total.
-- Afficher les employees supervisant au moins trois collègues.
-- Afficher les categories dont tous les products sont encore commercialisés.
-- Afficher les products n’ayant jamais été commandés.
-- Afficher, via une CTE, les cinq customers au plus fort chiffre d’affaires cumulé.
-- Afficher, en synthèse finale, pour chaque customer : le nombre d’orders, le chiffre d’affaires total et le pays de livraison.
