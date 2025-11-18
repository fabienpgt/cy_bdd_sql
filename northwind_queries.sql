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



-- ============================================================
-- EXERCICES : AGRÉGATIONS & SOUS-REQUÊTES
-- ============================================================

-- ------------------------------------------------------------
-- 1) AGRÉGATIONS SANS GROUP BY
-- ------------------------------------------------------------

-- Calculer le prix moyen de tous les produits du catalogue (table products).


-- Compter le nombre total de commandes enregistrées (table orders).


-- Trouver le prix unitaire minimum et le prix unitaire maximum parmi tous les produits (table products).


-- Calculer la quantité totale vendue (somme de quantity) sur l’ensemble des lignes de commande (table order_details).


-- Calculer le chiffre d’affaires total global sur toutes les commandes,
-- en utilisant unit_price, quantity et discount dans la table order_details.


-- ------------------------------------------------------------
-- 2) AGRÉGATIONS AVEC GROUP BY
-- ------------------------------------------------------------


-- Afficher le nombre de produits par catégorie.
-- (tables products et categories, regroupement par category_name ou category_id).


-- Afficher le nombre de clients par pays.
-- (table customers, regroupement par country).


-- Afficher le montant total des ventes pour chaque commande.
-- (table order_details, regroupement par order_id).


-- Afficher le prix moyen des produits pour chaque fournisseur.
-- (tables products et suppliers, regroupement par supplier_id ou company_name).


-- Afficher la quantité totale commandée pour chaque produit.
-- (tables products et order_details, regroupement par product_id / product_name).


-- ------------------------------------------------------------
-- 3) AGRÉGATIONS AVEC HAVING
-- ------------------------------------------------------------


-- Afficher les catégories dont le prix moyen des produits dépasse 30.
-- (GROUP BY sur la catégorie + HAVING sur AVG(unit_price) > 30).


-- Afficher les pays comptant au moins 5 clients.
-- (GROUP BY country + HAVING COUNT(*) >= 5).


-- Afficher les fournisseurs ayant au moins 10 produits dans leur catalogue.
-- (GROUP BY supplier_id + HAVING COUNT(*) >= 10).


-- Afficher les produits dont la quantité totale commandée dépasse 500 unités.
-- (GROUP BY product_id + HAVING SUM(quantity) > 500).


-- Afficher les commandes dont le montant total dépasse 1 000 (monnaie du catalogue).
-- (GROUP BY order_id + HAVING SUM(unit_price * quantity * (1 - discount)) > 1000).


-- ------------------------------------------------------------
-- 4) SOUS-REQUÊTES DANS WHERE
-- ------------------------------------------------------------

-- Afficher les produits dont le prix unitaire est supérieur au prix unitaire moyen
-- de l’ensemble des produits.
-- (Sous-requête dans WHERE pour calculer AVG(unit_price)).


-- Afficher les produits dont le prix unitaire dépasse la moyenne des produits
-- de leur propre catégorie.
-- (Sous-requête corrélée dans WHERE, filtrée par category_id).


-- Afficher les clients ayant passé au moins une commande,
-- en utilisant une sous-requête dans WHERE (IN ou EXISTS) sur la table orders.


-- Afficher les commandes dont le montant total est supérieur
-- au montant total moyen de l’ensemble des commandes.
-- (Sous-requête dans WHERE pour comparer chaque total à la moyenne des totaux).


-- Afficher les produits dont la quantité totale vendue est supérieure
-- à la quantité totale moyenne vendue par produit.
-- (Sous-requête dans WHERE pour comparer SUM(quantity) par produit
--  à la moyenne de ces sommes).


-- ------------------------------------------------------------
-- 5) SOUS-REQUÊTES DANS SELECT
-- ------------------------------------------------------------


-- Afficher chaque client (table customers) avec, dans une colonne calculée,
-- le nombre de commandes qu’il a passées (sous-requête dans SELECT sur orders).


-- Afficher chaque produit (table products) avec, dans une colonne calculée,
-- le montant total qu’il a généré en ventes
-- (sous-requête dans SELECT basée sur order_details).


-- Afficher chaque catégorie (table categories) avec :
-- - le prix moyen de tous les produits du catalogue,
-- - et le prix moyen de la catégorie,
-- dans deux colonnes calculées dans le SELECT.


-- Afficher chaque fournisseur (table suppliers) avec :
-- - le prix moyen de ses propres produits,
-- - et, dans une autre colonne, le prix moyen des produits des autres fournisseurs
--   (sous-requête dans SELECT qui exclut le supplier courant).

-- Afficher chaque commande (table orders) avec, dans une colonne calculée,
-- le montant total de la commande
-- (sous-requête dans SELECT basée sur order_details pour cette order_id).
