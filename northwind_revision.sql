--------------------------------
-- SELECTION ET FILTRE SIMPLE --
--------------------------------

-- 1) Afficher les produits dont le prix unitaire ('unit_price') est strictement supérieur à 50, 
-- triés par prix décroissant.
-- Tables : products
-- Colonnes à afficher : product_id, product_name, unit_price
SELECT
    product_id,
    product_name,
    unit_price
FROM products
WHERE unit_price > 50
ORDER BY unit_price DESC;

-- 2) Afficher les clients situés au 'Canada'
-- Tables : customers
-- Colonnes à afficher : customer_id, company_name, city, postal_code
SELECT
    customer_id,
    company_name,
    city,
    postal_code
FROM customers
WHERE country = 'Canada';

-- 3) Afficher les 15 produits ayant le plus d'unité en stock ('units_in_stock') dans l'ordre décroissant
-- Tables : products
-- Colonnes à afficher : product_id, p.product_name, p.units_in_stock
SELECT
    p.product_id,
    p.product_name,
    p.units_in_stock
FROM products AS p
ORDER BY p.units_in_stock DESC
LIMIT 15;


-- 4) Afficher les employés dont le titre contient le mot 'representative' peu importe la casse,
-- triés par last_name dans l'ordre alphabétique
-- Tables : employees
-- Colonnes à afficher : employee_id, last_name, first_name, title
SELECT
    employee_id,
    last_name,
    first_name,
    title
FROM employees
WHERE title ILIKE '%representative%'
ORDER BY last_name ASC;

--------------
-- JOINTURE --
--------------

-- 5) Afficher les commandes passé par un client au Brésil ('Brazil')
-- Tables : orders, customers
-- Colonnes à afficher : order_id, order_date, company_name
SELECT
    o.order_id,
    o.order_date,
    c.company_name
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE c.country = 'Brazil';

-- 6) Afficher les produits qui ne sont plus fournis ('discontinued') avec les 
-- informations du fournisseurs.
-- Tables : products, suppliers
-- Colonnes à afficher : supplier_id, company_name, product_id, product_name
SELECT
    s.supplier_id,
    s.company_name,
    p.product_id,
    p.product_name
FROM products AS p
JOIN suppliers AS s
    ON p.supplier_id = s.supplier_id
WHERE p.discontinued = 1;

-- 7) Afficher la liste d'employés ainsi que le nom de leur manager ('reports_to') s'ils en ont.
-- Indication : Il faut afficher tous les employés même ceux sans manager.
-- Tables : employees
-- Colonnes à afficher : employee_id, employee_last_name, employee_first_name, manager_last_name, manager_first_name
SELECT
    e.employee_id,
    e.last_name AS employee_last_name,
    e.first_name AS employee_first_name,
    m.last_name AS manager_last_name,
    m.first_name AS manager_first_name
FROM employees AS e
LEFT JOIN employees AS m
    ON e.reports_to = m.employee_id;
-----------------
-- AGGREGATION --
-----------------

-- 8) Afficher le nombre total de produits en stock ainsi que le prix moyen unitaire.
-- Tables : products
-- Colonnes à afficher : nombre_total_produits_en_stock, prix_moyen_unitaire
SELECT
    SUM(units_in_stock) AS nombre_total_produits_en_stock,
    AVG(unit_price) AS prix_moyen_unitaire
FROM products;

-- 9) Afficher les catégories de produits dont la somme des quantités de produits commandés 
-- dépasse strictement les 5000 unités et afficher le résultat dans l'ordre croissant des 
-- quantités commandées.
-- Tables : categories, products, order_details
-- Colonnes à afficher : category_id, category_name, quantite_produits_commandes
SELECT
    c.category_id,
    c.category_name,
    SUM(od.quantity) AS quantite_produits_commandes
FROM categories AS c
JOIN products AS p ON c.category_id = p.category_id
JOIN order_details AS od ON p.product_id = od.product_id
GROUP BY
    c.category_id,
    c.category_name
HAVING SUM(od.quantity) > 5000
ORDER BY quantite_produits_commandes ASC;

-- 10) Afficher le nombre de commandes traiter par chacun des employées 
-- même ceux n'ayant traité aucune commande et dans l'ordre croissant.
-- Tables : employees, orders
-- Colonnes à afficher : employee_id, last_name, first_name, nombre_commandes
SELECT
    e.employee_id,
    e.last_name,
    e.first_name,
    COUNT(o.order_id) AS nombre_commandes
FROM employees AS e
LEFT JOIN orders AS o
    ON e.employee_id = o.employee_id
GROUP BY
    e.employee_id,
    e.last_name,
    e.first_name
ORDER BY
    nombre_commandes ASC,
    e.last_name ASC,
    e.first_name ASC;

------------------------------
-- SOUS REQUETES DANS WHERE --
------------------------------

--11) Afficher les commandes dont le prix de livraison ('freight') est supérieur à la moyenne
-- dans l'ordre décroissant du prix de livraison
-- Tables : orders
-- Colonnes à afficher : order_id, freight
SELECT
    order_id,
    freight
FROM orders
WHERE freight > (
    SELECT AVG(freight)
    FROM orders
)
ORDER BY freight DESC;

--12) Afficher les produits de la categorie 'Condiments' donc le stock ('units_in_stock') 
-- est inférieur au stock moyen de la catégorie et afficher le résultat dans l'ordre croissant 
-- d'unité en stock.
-- Tables : products, categories
-- Colonnes à afficher : product_id, p.product_name, p.units_in_stock
SELECT
    p.product_id,
    p.product_name,
    p.units_in_stock
FROM products AS p
JOIN categories AS c
    ON p.category_id = c.category_id
WHERE c.category_name = 'Condiments'
  AND p.units_in_stock < (
      SELECT AVG(p2.units_in_stock)
      FROM products AS p2
      JOIN categories AS c2
          ON p2.category_id = c2.category_id
      WHERE c2.category_name = 'Condiments'
  )
ORDER BY p.units_in_stock ASC;

-----------------------------
-- MANIPULATION DE DONNEES --
-----------------------------

--13) Ajouter un employé avec les informations suivantes
-- employee_id : 99
-- last_name : Durand
-- first_name : Marc
-- title : Geomaticien
INSERT INTO employees (employee_id, last_name, first_name, title)
VALUES (99, 'Durand', 'Marc', 'Geomaticien');