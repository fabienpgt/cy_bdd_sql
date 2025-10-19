# SQL - Les bases

Télécharger le fichier contenant les données du festival -> [festival.zip]({{'datasets/festival.zip' | relative_url }})

## Sélection simple – `SELECT` et `FROM`

La commande `SELECT` est utilisée pour extraire des données d’une table.
La commande `FROM` indique la table contenant les données.

### Afficher toutes les colonnes
```sql
SELECT *
FROM artistes;
```

Le caractère * signifie toutes les colonnes.

---

### Afficher certaines colonnes
```sql
SELECT 
    nom,
    style_musical
FROM artistes;
```
Ici, seules les colonnes `nom` et `style_musical` sont affichées.

---

### Supprimer les doublons avec `DISTINCT`
```sql
SELECT DISTINCT
    style_musical
FROM artistes;
```
`DISTINCT` permet d’afficher une seule fois chaque valeur unique.

---

## Filtrer les données – `WHERE`

La clause `WHERE` permet de **filtrer** les lignes selon une ou plusieurs conditions.

### Exemple 1 : égalité
```sql
SELECT *
FROM artistes
WHERE pays = 'USA';
```

---

### Exemple 2 : différent de
```sql
SELECT *
FROM artistes
WHERE pays <> 'France';
```
`<>` est la forme standard SQL pour “différent de”.  
`!=` fonctionne également en PostgreSQL.

---

### Exemple 3 : plusieurs conditions avec `AND` et `OR`
```sql
SELECT *
FROM artistes
WHERE style_musical = 'Jazz'
  AND pays = 'France';
```
L’artiste doit être **à la fois** Jazz **et** Français.

```sql
SELECT *
FROM artistes
WHERE pays = 'USA' OR pays = 'France';
```
L’artiste peut venir **de l’un ou de l’autre**.

---

### Exemple 4 : liste de valeurs avec `IN`
```sql
SELECT *
FROM artistes
WHERE pays IN ('USA', 'France');
```
C’est une manière plus lisible d’écrire plusieurs conditions `OR`.

---

## 3. Recherches textuelles – `LIKE` et `ILIKE`

### Exemple 1 : commence par une lettre
```sql
SELECT *
FROM artistes
WHERE nom LIKE 'D%';
```
`%` représente **n’importe quelle suite de caractères**.  
Ici : tous les artistes dont le nom **commence par D**.

---

### Exemple 2 : se termine par une lettre
```sql
SELECT *
FROM artistes
WHERE nom LIKE '%s';
```
Tous les artistes dont le nom **se termine par s**.

---

### Exemple 3 : contient un mot
```sql
SELECT *
FROM artistes
WHERE style_musical LIKE '%Jazz%';
```

---

### Exemple 4 : insensible à la casse avec `ILIKE` (PostgreSQL)
```sql
SELECT *
FROM artistes
WHERE style_musical ILIKE '%jazz%';
```
`ILIKE` ignore la casse (`Jazz`, `JAZZ`, `jazz`…).

---

### Exemple 5 : exclure un mot
```sql
SELECT *
FROM artistes
WHERE style_musical NOT ILIKE '%jazz%';
```

---

## 4. Combiner plusieurs filtres

```sql
SELECT *
FROM artistes
WHERE style_musical ILIKE '%jazz%'
  AND (pays = 'USA' OR pays = 'France');
```
Cette requête affiche les artistes jouant du Jazz **et** venant des États-Unis ou de France.

---

## 5. Alias de tables et de colonnes

Les **alias** rendent les requêtes plus lisibles, surtout lorsqu’on travaille avec plusieurs tables.

```sql
SELECT 
    a.nom,
    a.pays
FROM artistes AS a
WHERE a.pays ILIKE '%inde%';
```
L’alias `a` remplace temporairement `artistes` pour alléger la syntaxe.

---

## 6. Trier les résultats – `ORDER BY`

### Exemple 1 : tri alphabétique
```sql
SELECT *
FROM artistes
ORDER BY style_musical;
```

---

### Exemple 2 : tri explicite ascendant
```sql
SELECT *
FROM artistes
ORDER BY style_musical ASC;
```

---

### Exemple 3 : tri descendant
```sql
SELECT *
FROM artistes
ORDER BY style_musical DESC;
```


---

## 7. Jointures – `JOIN`

Une **jointure** relie plusieurs tables entre elles à partir d’une **clé commune**, souvent une clé primaire et une clé étrangère.  
C’est ce qui permet de combiner plusieurs sources d’informations (par exemple : un concert et la scène sur laquelle il a lieu).


---

### Les types de jointures en SQL

Il existe plusieurs types de jointures, chacune avec un comportement spécifique :

#### 1. `INNER JOIN` – jointure interne  
C’est le type de jointure le plus courant.  
Elle ne garde que les lignes qui existent **dans les deux tables**.  
Autrement dit : seules les correspondances sont affichées.

```sql
SELECT
    c.id_concert,
    s.nom AS nom_scene
FROM concerts AS c
INNER JOIN scenes AS s
    ON c.id_scene = s.id_scene;
```

Cette requête affiche uniquement les concerts **ayant une scène associée**.  
Les concerts sans scène, ou les scènes sans concert, ne sont pas visibles.

---

#### 2. `LEFT JOIN` – jointure externe gauche  
Elle garde **toutes les lignes** de la table de gauche (celle indiquée avant `JOIN`),  
et ajoute les données correspondantes de la table de droite lorsqu’elles existent.  
S’il n’y a pas de correspondance, les valeurs de la table de droite sont remplacées par `NULL`.

```sql
SELECT
    p.nom,
    a.role
FROM personnels AS p
LEFT JOIN assignations AS a
    ON p.id_personnel = a.id_personnel;
```

Cette requête affiche tous les membres du personnel,  
y compris ceux **sans assignation** (leur rôle apparaîtra en `NULL`).

---

#### 3. `RIGHT JOIN` – jointure externe droite  
C’est l’inverse du `LEFT JOIN`.  
Elle garde toutes les lignes de la table de droite et ajoute les données de la table de gauche quand elles existent.

```sql
SELECT
    c.id_concert,
    s.nom AS nom_scene
FROM concerts AS c
RIGHT JOIN scenes AS s
    ON c.id_scene = s.id_scene;
```

Cette requête affiche toutes les scènes, même celles **sans concert prévu**.

---

#### 4. `FULL OUTER JOIN` – jointure externe complète  
Elle conserve **toutes les lignes** des deux tables, qu’il y ait ou non correspondance.  
Les valeurs manquantes sont remplacées par `NULL`.

```sql
SELECT
    a.nom AS artiste,
    c.id_concert
FROM artistes AS a
FULL OUTER JOIN participations AS p
    ON a.id_artiste = p.id_artiste
FULL OUTER JOIN concerts AS c
    ON p.id_concert = c.id_concert;
```

Cette requête affiche :
- les artistes avec concert,  
- les artistes sans concert,  
- et les concerts sans artiste associé.

---

#### 5. `CROSS JOIN` – produit cartésien  
Ce type de jointure ne repose sur **aucune clé commune**.  
Il associe **chaque ligne** de la première table avec **chaque ligne** de la seconde.  
À utiliser avec précaution car le nombre de combinaisons peut être très élevé.

```sql
SELECT
    a.nom AS artiste,
    s.nom AS scene
FROM artistes AS a
CROSS JOIN scenes AS s;
```

Chaque artiste est associé à **toutes les scènes** du festival.  
Cela peut servir pour générer des combinaisons possibles ou des tests.

---

## Exercices

- Afficher toutes les colonnes et valeur de la table `festivaliers`
- Affficher uniquement les colonnes **nom** et **prénom** de la table `personnels`
- Afficher uniquement les **noms** et **pays** des `artistes`
- Afficher uniquement les **noms** de scènes et leur **capacité d'accueil**
- Afficher uniquement le **nom** des `artistes` et leur **style musical** et renomme **nom** en **artiste** et **style_musical** en **style**
- Afficher tous les artistes venant strictement des USA
- Afficher tous les artistes ne venant pas strictement des USA
- Afficher tous les artistes dont le style musical est strictement 'Jazz'
- Afficher tous les artistes donc le style musical n'est pas strictement 'Jazz'
- Afficher tous les concerts commençant à 20h00
- Afficher tous les concerts commençant avant 20h00 (non inclus)
- Afficher tous les artistes commençant par la lettre 's'
- Afficher tous les concerts ayant lieu entre le 30/08/2025 (inclus) et le 02/09/2025 (inclus)
- Afficher tous les artistes ne venant pas strictement des USA et ayant strictement le mot 'Jazz' dans leur style musical
- Afficher tous les artistes venant au moins en partie des USA et ayant le mot 'jazz' (peu importe la manière dont il est écrit) dans leur style musical
- Afficher tous les artistes venant de France et commençant par la lettre 'a' ou bien par la lettre 'b'
- Afficher tous les artistes ne venant ni de France ni des USA

---

## Fonctions d’agrégation

Les **fonctions d’agrégation** calculent une valeur à partir d’un ensemble de lignes.  
Elles permettent de résumer les données : compter, additionner, ou calculer une moyenne.

Principales fonctions :
- `COUNT()` → compte le nombre de lignes  
- `SUM()` → fait la somme  
- `AVG()` → calcule la moyenne  
- `MIN()` → renvoie la plus petite valeur  
- `MAX()` → renvoie la plus grande valeur  

---

### Exemple 1 – Compter le nombre d’artistes
```sql
SELECT COUNT(*) AS nb_artistes
FROM artistes;
```
Retourne le nombre total d’artistes.

---

### Exemple 2 – Compter les artistes d’un pays donné
```sql
SELECT COUNT(*) AS nb_artistes_fr
FROM artistes
WHERE pays = 'France';
```

---

### Exemple 3 – Capacité totale du festival
```sql
SELECT SUM(capacite_accueil) AS capacite_totale
FROM scenes;
```

---

### Exemple 4 – Plus grande capacité
```sql
SELECT MAX(capacite_accueil) AS plus_grande_scene
FROM scenes;
```

---

### Exemple 5 – Capacité moyenne
```sql
SELECT AVG(capacite_accueil) AS capacite_moyenne
FROM scenes;
```

---

## Fonctions d’agrégation – avec `GROUP BY`

La clause `GROUP BY` permet de **regrouper les lignes** selon une ou plusieurs colonnes,  
et d’appliquer des fonctions d’agrégation sur chaque groupe.

---

### Exemple 1 – Nombre d’artistes par pays
```sql
SELECT 
    pays,
    COUNT(*) AS nb_artistes
FROM artistes
GROUP BY pays;
```

---

### Exemple 2 – Nombre d’artistes par style musical
```sql
SELECT 
    style_musical,
    COUNT(*) AS nb_artistes
FROM artistes
GROUP BY style_musical;
```

---

### Exemple 3 – Moyenne de capacité d’accueil par type de scène
```sql
SELECT 
    type_scene,
    AVG(capacite_accueil) AS capacite_moyenne
FROM scenes
GROUP BY type_scene;
```

---

### Exemple 4 – Groupement sur plusieurs colonnes
```sql
SELECT 
    pays,
    style_musical,
    COUNT(*) AS nb_artistes
FROM artistes
GROUP BY pays, style_musical;
```

---

## Filtrer les groupes – `HAVING`

`HAVING` s’utilise après `GROUP BY` pour filtrer sur des valeurs agrégées.  
Contrairement à `WHERE`, il agit sur le résultat du regroupement.

---

### Exemple 1 – Pays ayant plus de 5 artistes
```sql
SELECT 
    pays,
    COUNT(*) AS nb_artistes
FROM artistes
GROUP BY pays
HAVING COUNT(*) > 5;
```

---

### Exemple 2 – Styles musicaux joués par plus de 3 artistes
```sql
SELECT 
    style_musical,
    COUNT(*) AS nb_artistes
FROM artistes
GROUP BY style_musical
HAVING COUNT(*) > 3;
```

---

### Exemple 3 – Moyenne de capacité supérieure à 500
```sql
SELECT 
    type_scene,
    AVG(capacite_accueil) AS capacite_moyenne
FROM scenes
GROUP BY type_scene
HAVING AVG(capacite_accueil) > 500;
```

---

### Ordre logique d’exécution
1. `FROM`  
2. `WHERE`  
3. `GROUP BY`  
4. `HAVING`  
5. `SELECT`  
6. `ORDER BY`

---

## Requêtes imbriquées (ou sous-requêtes)

Une **requête imbriquée** est une requête placée à l’intérieur d’une autre.  
Elles permettent d’effectuer des comparaisons ou des calculs plus complexes.

---

### Exemple 1 – Trouver les artistes du pays le plus représenté
```sql
SELECT *
FROM artistes
WHERE pays = (
    SELECT pays
    FROM artistes
    GROUP BY pays
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
```
La sous-requête identifie le pays ayant le plus d’artistes,  
et la requête principale affiche les artistes de ce pays.

---

### Exemple 2 – Trouver les scènes plus grandes que la moyenne
```sql
SELECT nom, capacite_accueil
FROM scenes
WHERE capacite_accueil > (
    SELECT AVG(capacite_accueil)
    FROM scenes
);
```

---

### Exemple 3 – Sous-requête dans le `FROM`
```sql
SELECT 
    pays,
    nb_artistes
FROM (
    SELECT 
        pays,
        COUNT(*) AS nb_artistes
    FROM artistes
    GROUP BY pays
) AS stats
WHERE nb_artistes > 5;
```

---

### Exemple 4 – Sous-requête avec `IN`
```sql
SELECT nom
FROM artistes
WHERE pays IN (
    SELECT pays
    FROM artistes
    WHERE style_musical = 'Jazz'
);
```
Affiche tous les artistes venant d’un pays où il existe au moins un artiste de Jazz.
