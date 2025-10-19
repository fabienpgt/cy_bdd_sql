-- Introduction au Langage SQL - Les bases
-- Le SQL (*Structured Query Language*) est le langage standard pour interagir avec les bases de données relationnelles.
-- Il permet de créer des tables, d’ajouter des données, de les consulter, de les modifier et de les relier entre elles.
-- Exemple fil rouge : le festival de jazz.

-- ---------------------------------------------------------------------------
-- CREATION DE TABLES
-- ---------------------------------------------------------------------------

-- CREATE TABLE : permet de créer une nouvelle table
-- SERIAL : identifiant auto-incrémenté
-- PRIMARY KEY : identifiant unique de la table
-- VARCHAR(n) : champ texte limité à n caractères
-- NOT NULL : valeur obligatoire

CREATE TABLE artistes (
    id_artiste SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    style_musical VARCHAR(50),
    pays VARCHAR(50)
);

CREATE TABLE scenes (
    id_scene SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    capacite INTEGER
);

CREATE TABLE concerts (
    id_concert SERIAL PRIMARY KEY,
    date_concert DATE NOT NULL,
    heure_debut TIME NOT NULL,
    id_scene INT REFERENCES scenes(id_scene),
    id_artiste INT REFERENCES artistes(id_artiste)
);

-- ---------------------------------------------------------------------------
-- INSERTION DE DONNEES
-- ---------------------------------------------------------------------------

-- INSERT INTO ... VALUES (...) : insère une ou plusieurs lignes
INSERT INTO artistes (nom, style_musical, pays)
VALUES
('The Headhunters', 'Jazz Funk', 'USA'),
('Seun Kuti & Egypt 80', 'Afrobeat', 'Nigeria'),
('Jalen Ngonda', 'Soul', 'USA'),
('Isaiah Collier', 'Jazz', 'USA');

INSERT INTO scenes (nom, capacite)
VALUES
('Grande Halle de la Villette', 6000),
('Scène Extérieure', 2000);

INSERT INTO concerts (date_concert, heure_debut, id_scene, id_artiste)
VALUES
('2025-08-28', '20:00', 1, 1),
('2025-08-28', '21:00', 1, 2),
('2025-08-29', '20:00', 1, 3),
('2025-08-29', '21:00', 1, 4);

-- ---------------------------------------------------------------------------
-- SELECTION SIMPLE DE DONNEES
-- ---------------------------------------------------------------------------

-- SELECT * : sélectionne toutes les colonnes
SELECT * FROM artistes;

-- Sélectionner uniquement certaines colonnes
SELECT nom, pays FROM artistes;

-- ---------------------------------------------------------------------------
-- ALTER TABLE - MODIFIER UNE TABLE
-- ---------------------------------------------------------------------------

-- ALTER TABLE : permet de modifier la structure d’une table
-- ADD COLUMN : ajouter une colonne
-- DROP COLUMN : supprimer une colonne
-- RENAME COLUMN : renommer une colonne
-- ALTER COLUMN TYPE : changer le type de données
-- SET/DROP DEFAULT : ajouter ou supprimer une valeur par défaut
-- SET/DROP NOT NULL : rendre une colonne obligatoire ou non
-- RENAME TO : renommer la table

-- Ajouter une colonne
ALTER TABLE artistes
ADD COLUMN confirme BOOLEAN DEFAULT TRUE;

-- Modifier le type d’une colonne
ALTER TABLE artistes
ALTER COLUMN nom TYPE VARCHAR(150);

-- Supprimer une colonne
ALTER TABLE artistes
DROP COLUMN confirme;

-- Renommer une colonne
ALTER TABLE artistes
RENAME COLUMN pays TO pays_origine;

-- Renommer une table
ALTER TABLE artistes
RENAME TO musiciens;

-- ---------------------------------------------------------------------------
-- SELECTION AVEC CONTRAINTES
-- ---------------------------------------------------------------------------

-- WHERE : filtre les résultats
-- AND / OR : combiner plusieurs conditions
-- Opérateurs : =, !=, <, <=, >, >=
-- BETWEEN / NOT BETWEEN : valeurs comprises ou non dans un intervalle
-- IN / NOT IN : vérifier si une valeur appartient à une liste
-- LIKE / ILIKE : recherche par motif (sensible ou non à la casse)
-- % : motif pour plusieurs caractères
-- _ : motif pour un seul caractère

-- Artistes américains
SELECT nom, style_musical
FROM musiciens
WHERE pays_origine = 'USA';

-- Artistes américains de style Jazz
SELECT nom, style_musical
FROM musiciens
WHERE pays_origine = 'USA' AND style_musical = 'Jazz';

-- Artistes venant de certains pays
SELECT nom, pays_origine
FROM musiciens
WHERE pays_origine IN ('USA', 'Nigeria');

-- Recherche par motif (ILIKE insensible à la casse)
SELECT nom, style_musical
FROM musiciens
WHERE style_musical ILIKE '%jazz%';

-- ---------------------------------------------------------------------------
-- TRIER LES RESULTATS
-- ---------------------------------------------------------------------------

-- ORDER BY : trier les résultats
-- ASC : ordre croissant
-- DESC : ordre décroissant

SELECT nom, pays_origine
FROM musiciens
ORDER BY nom ASC;

SELECT nom, pays_origine
FROM musiciens
ORDER BY pays_origine DESC;

-- ---------------------------------------------------------------------------
-- ELIMINER LES DOUBLONS
-- ---------------------------------------------------------------------------

-- DISTINCT : supprime les doublons
SELECT DISTINCT style_musical
FROM musiciens;

-- ---------------------------------------------------------------------------
-- MODIFIER ET SUPPRIMER DES DONNEES
-- ---------------------------------------------------------------------------

-- UPDATE ... SET ... WHERE ... : mettre à jour
-- DELETE FROM ... WHERE ... : supprimer

UPDATE musiciens
SET style_musical = 'Jazz Spirituel'
WHERE nom = 'Isaiah Collier';

DELETE FROM musiciens
WHERE nom = 'The Headhunters';

-- ---------------------------------------------------------------------------
-- ALIAS
-- ---------------------------------------------------------------------------

-- Un alias est un nom temporaire que l’on donne à une table ou une colonne
-- Il sert à :
--   - raccourcir le nom d’une table ou d’une colonne
--   - rendre les résultats plus lisibles
--   - simplifier les requêtes avec plusieurs jointures
--
-- Syntaxe :
-- SELECT colonne AS alias_colonne
-- FROM table AS alias_table;

-- Exemple simple : alias pour une colonne
SELECT nom AS artiste, pays_origine AS pays
FROM musiciens;

-- Exemple avec alias pour une table
-- Ici on renomme la table musiciens en "a" pour écrire moins de texte
SELECT a.nom, a.style_musical
FROM musiciens AS a;

-- Exemple avec deux tables et alias
-- On veut afficher la programmation des concerts avec les artistes
SELECT c.date_concert, c.heure_debut, a.nom AS artiste, s.nom AS scene
FROM concerts AS c
JOIN musiciens AS a ON c.id_artiste = a.id_artiste
JOIN scenes AS s ON c.id_scene = s.id_scene;

-- Dans cette requête :
--   c = alias pour concerts
--   a = alias pour musiciens
--   s = alias pour scenes
--   On affiche la date, l'heure, le nom de l’artiste et la scène.

-- ---------------------------------------------------------------------------
-- Exercices sur les alias
-- ---------------------------------------------------------------------------

-- 1. Sélectionner le nom et le pays des artistes en renommant les colonnes
--    en "Artiste" et "Origine".
-- 2. Sélectionner les concerts en utilisant des alias pour les tables :
--    afficher la date (appelée "Jour"), l'heure (appelée "Début")
--    et l'identifiant de l'artiste.
-- 3. Faire une requête qui affiche la liste des concerts
--    avec le nom de l’artiste et le nom de la scène,
--    en utilisant des alias courts pour toutes les tables.

-- ---------------------------------------------------------------------------
-- FONCTIONS D’AGREGATION
-- ---------------------------------------------------------------------------

-- Les fonctions d’agrégation permettent de faire des calculs sur plusieurs lignes
-- et de retourner une seule valeur.
--
-- Principales fonctions :
--   COUNT(*)     : compte le nombre de lignes
--   SUM(colonne) : somme des valeurs
--   AVG(colonne) : moyenne
--   MIN(colonne) : valeur minimum
--   MAX(colonne) : valeur maximum

-- Exemple : nombre total d’artistes
SELECT COUNT(*) AS nb_artistes
FROM musiciens;

-- Exemple : capacité totale des scènes
SELECT SUM(capacite) AS capacite_totale
FROM scenes;

-- Exemple : capacité moyenne des scènes
SELECT AVG(capacite) AS capacite_moyenne
FROM scenes;

-- Exemple : date du premier et du dernier concert
SELECT MIN(date_concert) AS premier_concert,
       MAX(date_concert) AS dernier_concert
FROM concerts;

-- ---------------------------------------------------------------------------
-- Exercices sur les agrégations
-- ---------------------------------------------------------------------------

-- 1. Compter le nombre total de concerts.
-- 2. Calculer la durée moyenne des concerts (après avoir ajouté une colonne duree).
-- 3. Trouver la capacité minimale et maximale des scènes.


-- ---------------------------------------------------------------------------
-- GROUP BY
-- ---------------------------------------------------------------------------

-- GROUP BY permet de regrouper les résultats selon une ou plusieurs colonnes.
-- On l’utilise toujours avec une fonction d’agrégation.

-- Exemple : nombre d’artistes par pays
SELECT pays_origine, COUNT(*) AS nb_artistes
FROM musiciens
GROUP BY pays_origine;

-- Exemple : nombre d’artistes par style musical
SELECT style_musical, COUNT(*) AS nb
FROM musiciens
GROUP BY style_musical;

-- Exemple : capacité totale par scène
SELECT s.nom, SUM(s.capacite) AS capacite_totale
FROM scenes AS s
GROUP BY s.nom;

-- On peut combiner GROUP BY avec ORDER BY
-- Exemple : pays ayant le plus d’artistes
SELECT pays_origine, COUNT(*) AS nb_artistes
FROM musiciens
GROUP BY pays_origine
ORDER BY nb_artistes DESC;

-- ---------------------------------------------------------------------------
-- Exercices sur GROUP BY
-- ---------------------------------------------------------------------------

-- 1. Afficher combien de concerts ont lieu par date.
-- 2. Afficher combien d’artistes différents viennent de chaque pays.
-- 3. Trouver le style musical le plus représenté.


-- ---------------------------------------------------------------------------
-- JOINS
-- ---------------------------------------------------------------------------

-- Les JOINS permettent de combiner des données provenant de plusieurs tables.
-- Types principaux :
--   INNER JOIN : retourne uniquement les lignes qui correspondent dans les deux tables
--   LEFT JOIN  : retourne toutes les lignes de la table de gauche, même si pas de correspondance
--   RIGHT JOIN : retourne toutes les lignes de la table de droite
--   FULL JOIN  : retourne toutes les lignes des deux tables (même sans correspondance)

-- Exemple : concerts avec le nom des artistes
SELECT c.date_concert, c.heure_debut, a.nom AS artiste
FROM concerts AS c
INNER JOIN musiciens AS a ON c.id_artiste = a.id_artiste;

-- Exemple : concerts avec le nom des artistes et des scènes
SELECT c.date_concert, c.heure_debut, a.nom AS artiste, s.nom AS scene
FROM concerts AS c
INNER JOIN musiciens AS a ON c.id_artiste = a.id_artiste
INNER JOIN scenes AS s ON c.id_scene = s.id_scene;

-- Exemple : artistes avec ou sans concert (LEFT JOIN)
SELECT a.nom, c.date_concert
FROM musiciens AS a
LEFT JOIN concerts AS c ON a.id_artiste = c.id_artiste;

-- Exemple : scènes avec ou sans concert (LEFT JOIN)
SELECT s.nom AS scene, c.date_concert
FROM scenes AS s
LEFT JOIN concerts AS c ON s.id_scene = c.id_scene;

-- ---------------------------------------------------------------------------
-- Exercices sur les JOINS
-- ---------------------------------------------------------------------------

-- 1. Afficher la programmation complète du festival :
--    date, heure, artiste et scène.
-- 2. Afficher le nombre de concerts par scène.
-- 3. Afficher tous les artistes même ceux qui n’ont pas encore de concert prévu.
-- 4. Afficher toutes les scènes même celles qui n’accueillent pas encore de concert.