-- =====================================================================
-- NORTHWIND – EXERCICES 
-- =====================================================================

-- ---------------------------------------------------------------------
-- DÉCOUVERTE & EXPLORATION
-- ---------------------------------------------------------------------
-- Afficher l’ensemble des informations disponibles pour les products.
-- Afficher le product_name, la quantity_per_unit et le unit_price des products.
-- Afficher la liste des pays uniques présents chez les customers, triés de A à Z.
-- Afficher les 10 produits au prix unitaire le plus bas.
-- Afficher les suppliers dont le siège est situé aux USA ou en France.
-- Afficher les customers dont le company_name commence par la lettre A.
-- Afficher les products dont le unit_price se situe dans une fourchette entre 10 à 20.
-- Afficher les commandes les plus récentes d’après leur order_date.
-- Afficher les customers installés dans un pays différent de Germany.
-- Afficher les shippers triés par company_name.


-- ---------------------------------------------------------
-- FILTRES ET CONDITIONS COMBINÉES
-- ---------------------------------------------------------
-- Afficher les products encore vendus dont le unit_price dépasse un seuil donné.
-- Afficher les customers localisés aux USA ou au UK dont la city est renseignée.
-- Afficher les employees dont la city correspond à London sans tenir compte de la casse.
-- Afficher les orders déjà expédiées avant le 1er juillet 1997.
-- Afficher les suppliers dont le company_name contient le mot “market”.
-- Afficher les products avec un stock important ou de nombreuses unités en commande.
-- Afficher les customers dépourvus de numéro de fax.
-- Afficher les orders dont le freight est élevé, classées du plus au moins élevé.
-- Afficher les employees ne rendant compte à aucun supérieur (pas de reports_to).
-- Afficher les products dont le product_name n’évoque pas une sauce.


-- ----------------------------------------
-- RELATIONS ENTRE TABLES (JOINTURES)
-- ----------------------------------------
-- Afficher les orders associées au customer qui les a passées.
-- Afficher les products enrichis de leur category_name et du supplier concerné.
-- Afficher les orders reliées à la fois au customer et au shipper utilisés.
-- Afficher les customers même lorsqu’ils n’ont passé aucune order.
-- Afficher les orders même lorsqu’aucun customer ne leur est associé.
-- Afficher, pour comparaison, les résultats obtenus avec différents types de jointures.
-- Afficher les employees avec le nom de leur manager (self-join via reports_to).
-- Afficher, pour chaque ligne de order_details, le product correspondant, la quantity et le unit_price appliqué.
-- Afficher les products avec le nombre d’orders distinctes dans lesquelles ils apparaissent.
-- Afficher les customers n’ayant jamais passé de commande.


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
