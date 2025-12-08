-- =========================================================
-- SUJET B - Examen SQL DVD Rental
-- =========================================================

-- I. SÉLECTION AVEC FILTRE
-- ---------------------------------------------------------

-- Question 1 (1 point)
-- Consigne :
-- Afficher les acteurs dont le nom de famille commence par la lettre "m"
-- (peu importe la casse).
-- Trier les résultats par prénom puis par nom de famille dans l’ordre alphabétique.
--
-- Tables : "actor"
-- Colonnes à afficher : 'first_name', 'last_name'



-- Question 2 (1 point)
-- Consigne :
-- Afficher les films dont le tarif de location ('rental_rate') est supérieur ou égal à 4.
-- Trier les résultats du tarif le plus élevé au plus bas.
--
-- Tables : "film"
-- Colonnes à afficher : 'film_id', 'title', 'rental_rate'



-- Question 3 (1 point)
-- Consigne :
-- Afficher les 10 premiers films dont le coût de remplacement ('replacement_cost')
-- est le plus élevé.
-- Trier par coût de remplacement du plus élevé au plus bas.
--
-- Tables : "film"
-- Colonnes à afficher : 'film_id', 'title', 'replacement_cost'



-- Question 4 (1 point)
-- Consigne :
-- Afficher les films dont la description contient le mot "dog"
-- ET le mot "cat", insensible à la casse.
--
-- Tables : "film"
-- Colonnes à afficher : 'film_id', 'title', 'description'



-- II. JOINTURES
-- ---------------------------------------------------------

-- Question 5 (2 points)
-- Consigne :
-- Afficher la liste de tous les acteurs avec les films dans lesquels ils ont joué.
-- Trier le résultat par nom de l’acteur, puis par titre du film
-- dans l’ordre inverse alphabétique.
--
-- Tables : "film_actor", "film", "actor"
-- Colonnes à afficher : 'actor_id', 'first_name', 'last_name', 'film_id', 'title'



-- Question 6 (2 points)
-- Consigne :
-- Afficher toutes les locations avec :
--   - l’identifiant, le prénom et le nom du client,
--   - l’identifiant et le titre du film loué,
--   - la date de location.
-- Trier par date de location décroissante.
--
-- Tables : "rental", "customer", "inventory", "film"
-- Colonnes à afficher : 'customer_id', 'first_name', 'last_name', 'film_id', 'title', 'rental_date'



-- III. AGRÉGATION
-- ---------------------------------------------------------

-- Question 7 (2 points)
-- Consigne :
-- Afficher la durée ('length') minimum, maximum et moyenne de l’ensemble des films.
--
-- Tables : "film"
-- Colonnes à afficher :
--   'duree_minimum' (alias),
--   'duree_maximum' (alias),
--   'duree_moyenne' (alias)



-- Question 8 (3 points)
-- Consigne :
-- Afficher, pour chaque client, le nombre total de paiements effectués.
-- Trier du plus grand au plus petit.
--
-- Tables : "rental", "customer", "payment"
-- Colonnes à afficher :
--   'customer_id', 'first_name', 'last_name', 'nombre_paiements' (alias)



-- IV. SOUS-REQUÊTE DANS LE WHERE
-- ---------------------------------------------------------

-- Question 9 (3 points)
-- Consigne :
-- Afficher toutes les locations dont la durée ('return_date' - 'rental_date')
-- est inférieure à la durée moyenne de toutes les locations.
--
-- Tables : "rental"
-- Colonnes à afficher : 'rental_id', 'customer_id', 'duree_location' (alias)



-- Question 10 (3 points)
-- Consigne :
-- Afficher les films de la catégorie "Action" dont la durée ('length')
-- est supérieure à la durée moyenne des films d’action.
-- Trier les résultats par durée croissante.
--
-- Tables : "film", "film_category", "category"
-- Colonnes à afficher : 'film_id', 'title', 'length'



-- V. MANIPULATION DE DONNÉES
-- ---------------------------------------------------------

-- Question 11 (1 point)
-- Consigne :
-- Insérer dans la table "film" un nouveau film avec les informations suivantes
-- de votre choix :
--   'title'
--   'release_year'
--   'rental_rate'
--   'length'
