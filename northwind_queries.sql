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
-- AGRÉGATIONS & SOUS-REQUÊTES
-- ============================================================

-- ------------------------------------------------------------
-- 1) AGRÉGATIONS SANS GROUP BY
-- ------------------------------------------------------------

-- Calculer le prix moyen de tous les produits du catalogue.
SELECT 
    AVG(unit_price) AS avg_unit_price
FROM products;


-- Compter le nombre total de commandes enregistrées.
SELECT 
    COUNT(*) AS nb_orders
FROM orders;


-- Trouver le prix unitaire minimum et maximum parmi tous les produits.
SELECT
    MIN(unit_price) AS min_unit_price,
    MAX(unit_price) AS max_unit_price
FROM products;


-- Calculer la quantité totale vendue (somme de quantity) sur l’ensemble des lignes de commande.
SELECT 
    SUM(quantity) AS total_quantity_sold
FROM order_details;


-- Calculer le chiffre d’affaires total global
-- (unit_price * quantity * (1 - discount)).
SELECT
    SUM(unit_price * quantity * (1 - COALESCE(discount, 0))) AS total_revenue
FROM order_details;


-- ------------------------------------------------------------
-- 2) AGRÉGATIONS AVEC GROUP BY
-- ------------------------------------------------------------

-- Afficher le nombre de produits par catégorie.
SELECT
    c.category_id,
    c.category_name,
    COUNT(p.product_id) AS nb_products
FROM categories c
LEFT JOIN products p ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY nb_products DESC;


-- Afficher le nombre de clients par pays.
SELECT
    country,
    COUNT(*) AS nb_customers
FROM customers
GROUP BY country
ORDER BY nb_customers DESC;


-- Afficher le montant total des ventes pour chaque commande.
SELECT
    order_id,
    SUM(unit_price * quantity * (1 - COALESCE(discount, 0))) AS order_total
FROM order_details
GROUP BY order_id
ORDER BY order_total DESC;


-- Afficher le prix moyen des produits pour chaque fournisseur.
SELECT
    s.supplier_id,
    s.company_name,
    AVG(p.unit_price) AS avg_unit_price
FROM suppliers s
JOIN products p
    ON p.supplier_id = s.supplier_id
GROUP BY s.supplier_id, s.company_name
ORDER BY avg_unit_price DESC;


-- Afficher la quantité totale commandée pour chaque produit.
SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_quantity
FROM products p
JOIN order_details od
    ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC;


-- ------------------------------------------------------------
-- 3) AGRÉGATIONS AVEC HAVING
-- ------------------------------------------------------------

-- Afficher les catégories dont le prix moyen des produits dépasse 30.
SELECT
    c.category_id,
    c.category_name,
    AVG(p.unit_price) AS avg_unit_price
FROM categories c
JOIN products p
    ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
HAVING AVG(p.unit_price) > 30
ORDER BY avg_unit_price DESC;

-- Afficher les pays comptant au moins 5 clients.
SELECT
    country,
    COUNT(*) AS nb_customers
FROM customers
GROUP BY country
HAVING COUNT(*) >= 5
ORDER BY nb_customers DESC;

-- Afficher les fournisseurs ayant au moins 10 produits dans leur catalogue.
SELECT
    s.supplier_id,
    s.company_name,
    COUNT(p.product_id) AS nb_products
FROM suppliers s
JOIN products p
    ON p.supplier_id = s.supplier_id
GROUP BY s.supplier_id, s.company_name
HAVING COUNT(p.product_id) >= 10
ORDER BY nb_products DESC;

-- Afficher les produits dont la quantité totale commandée dépasse 500 unités.
SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_quantity
FROM products p
JOIN order_details od
    ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(od.quantity) > 500
ORDER BY total_quantity DESC;

-- Afficher les commandes dont le montant total dépasse 1 000.
SELECT
    order_id,
    SUM(unit_price * quantity * (1 - COALESCE(discount, 0))) AS order_total
FROM order_details
GROUP BY order_id
HAVING SUM(unit_price * quantity * (1 - COALESCE(discount, 0))) > 1000
ORDER BY order_total DESC;


-- ------------------------------------------------------------
-- 4) SOUS-REQUÊTES DANS WHERE
-- ------------------------------------------------------------

-- Afficher les produits dont le prix unitaire est supérieur
-- au prix unitaire moyen de l’ensemble des produits.
SELECT
    product_id,
    product_name,
    unit_price
FROM products
WHERE unit_price > (
    SELECT AVG(unit_price)
    FROM products
)
ORDER BY unit_price DESC;

-- Afficher les clients ayant passé au moins une commande
-- (sous-requête dans WHERE avec IN).
SELECT
    customer_id,
    company_name
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM orders
)
ORDER BY company_name;

-- Afficher les clients n’ayant passé aucune commande
SELECT
    customer_id,
    company_name
FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM orders
)
ORDER BY company_name;

-- Afficher les produits qui n’ont jamais été commandés
SELECT
    product_id,
    product_name
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM order_details
)
ORDER BY product_name;
