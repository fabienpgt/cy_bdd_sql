--------------------------------
-- SELECTION ET FILTRE SIMPLE --
--------------------------------

-- 1) Afficher les produits dont le prix unitaire ('unit_price') est strictement supérieur à 50, 
-- triés par prix décroissant.
-- Tables : products
-- Colonnes à afficher : product_id, product_name, unit_price

-- 2) Afficher les clients situés au 'Canada'
-- Tables : customers
-- Colonnes à afficher : customer_id, company_name, city, postal_code

-- 3) Afficher les 15 produits ayant le plus d'unité en stock ('units_in_stock') dans l'ordre décroissant
-- Tables : products
-- Colonnes à afficher : product_id, p.product_name, p.units_in_stock

-- 4) Afficher les employés dont le titre contient le mot 'representative' peu importe la casse,
-- triés par last_name dans l'ordre alphabétique
-- Tables : employees
-- Colonnes à afficher : employee_id, last_name, first_name, title

--------------
-- JOINTURE --
--------------

-- 5) Afficher les commandes passé par un client au Brésil ('Brazil')
-- Tables : orders, customers
-- Colonnes à afficher : order_id, order_date, company_name

-- 6) Afficher les produits qui ne sont plus fournis ('discontinued') avec les 
-- informations du fournisseurs.
-- Tables : products, suppliers
-- Colonnes à afficher : supplier_id, company_name, product_id, product_name

-- 7) Afficher la liste d'employés ainsi que le nom de leur manager ('reports_to') s'ils en ont.
-- Indication : Il faut afficher tous les employés même ceux sans manager.
-- Tables : employees
-- Colonnes à afficher : employee_id, employee_last_name, employee_first_name, manager_last_name, manager_first_name

-----------------
-- AGGREGATION --
-----------------

-- 8) Afficher le nombre total de produits en stock ainsi que le prix moyen unitaire.
-- Tables : products
-- Colonnes à afficher : nombre_total_produits_en_stock, prix_moyen_unitaire

-- 9) Afficher les catégories de produits dont la somme des quantités de produits commandés 
-- dépasse strictement les 5000 unités et afficher le résultat dans l'ordre croissant des 
-- quantités commandées.
-- Tables : categories, products, order_details
-- Colonnes à afficher : category_id, category_name, quantité_produits_commandés

-- 10) Afficher le nombre de commandes traiter par chacun des employées 
-- même ceux n'ayant traité aucune commande et dans l'ordre croissant.
-- Tables : employees, orders
-- Colonnes à afficher : employee_id, last_name, first_name, nombre_commandes

------------------------------
-- SOUS REQUETES DANS WHERE --
------------------------------

--11) Afficher les commandes dont le prix de livraison ('freight') est supérieur à la moyenne
-- dans l'ordre décroissant du prix de livraison
-- Tables : orders
-- Colonnes à afficher : order_id, freight

--12) Afficher les produits de la categorie 'Condiments' donc le stock ('units_in_stock') 
-- est inférieur au stock moyen de la catégorie et afficher le résultat dans l'ordre croissant 
-- d'unité en stock.
-- Tables : products, categories
-- Colonnes à afficher : product_id, p.product_name, p.units_in_stock

-----------------------------
-- MANIPULATION DE DONNEES --
-----------------------------

--13) Ajouter un employé avec les informations suivantes
-- employee_id : 99
-- last_name : Durand
-- first_name : Marc
-- title : Geomaticien