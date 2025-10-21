# Cours SQL

---

## Objectif de cette section

Dans cette section, nous allons apprendre les bases du langage SQL en travaillant sur la base de données **Northwind**, un jeu de données classique qui simule la gestion d’une petite entreprise de commerce international de produits alimentaires.

Nous verrons :
- comment explorer les tables avec des requêtes simples (`SELECT`, `WHERE`, `ORDER BY`, etc.)
- comment relier les tables entre elles (`JOIN`)
- comment agréger les données (`COUNT`, `SUM`, `GROUP BY`, `HAVING`)
- et comment utiliser des **sous-requêtes** pour des analyses plus avancées.

---

## Base de données Northwind

### Contexte

La base **Northwind** représente une société fictive qui vend des produits alimentaires à travers le monde.  
Elle contient les informations sur :
- les **clients** (Customers),
- les **commandes** (Orders),
- les **produits** (Products),
- les **catégories de produits** (Categories),
- les **fournisseurs** (Suppliers),
- les **employés** (Employees),
- et les **transporteurs** (Shippers).


---

### Tables principales

`customers`

Contient les informations sur les clients de l’entreprise.

- **customer_id** : identifiant unique du client (clé primaire).  
- **company_name** : nom de l’entreprise cliente.  
- **contact_name** : nom du contact principal.  
- **contact_title** : fonction du contact.  
- **address** : adresse complète du client.  
- **city** : ville où se situe le client.  
- **region** : région ou état, selon le pays.  
- **postal_code** : code postal du client.  
- **country** : pays du client.  
- **phone** : numéro de téléphone principal.  
- **fax** : numéro de fax.

---

`orders`

Contient les commandes passées par les clients et suivies par un employé.

- **order_id** : identifiant unique de la commande (clé primaire).  
- **customer_id** : référence au client ayant passé la commande (`customers.customer_id`).  
- **employee_id** : référence à l’employé responsable (`employees.employee_id`).  
- **order_date** : date de création de la commande.  
- **required_date** : date à laquelle la livraison est demandée.  
- **shipped_date** : date d’expédition réelle.  
- **ship_via** : identifiant du transporteur (`shippers.shipper_id`).  
- **freight** : coût du transport.  
- **ship_name** : nom du destinataire (souvent le client ou un entrepôt).  
- **ship_address** : adresse de livraison.  
- **ship_city** : ville de livraison.  
- **ship_region** : région ou état de livraison.  
- **ship_postal_code** : code postal de livraison.  
- **ship_country** : pays de livraison.

---

`products`

Répertorie les produits vendus par Northwind.

- **product_id** : identifiant unique du produit (clé primaire).  
- **product_name** : nom du produit.  
- **supplier_id** : identifiant du fournisseur (`suppliers.supplier_id`).  
- **category_id** : identifiant de la catégorie (`categories.category_id`).  
- **quantity_per_unit** : conditionnement du produit (ex. "24 - 12 oz bottles").  
- **unit_price** : prix unitaire du produit.  
- **units_in_stock** : quantité actuelle en stock.  
- **units_on_order** : quantité actuellement en commande.  
- **reorder_level** : seuil de réapprovisionnement.  
- **discontinued** : indique si le produit est arrêté (booléen).

---

`order_details`

Détaille les produits inclus dans chaque commande.

- **order_id** : identifiant de la commande (`orders.order_id`).  
- **product_id** : identifiant du produit (`products.product_id`).  
- **unit_price** : prix unitaire du produit au moment de la commande.  
- **quantity** : nombre d’unités commandées.  
- **discount** : remise appliquée sur cette ligne (valeur entre 0 et 1).

Chaque ligne représente un **produit spécifique** dans une commande donnée.

---

`categories`

Regroupe les produits par type.

- **category_id** : identifiant unique de la catégorie (clé primaire).  
- **category_name** : nom de la catégorie (ex. Beverages, Seafood).  
- **description** : description textuelle de la catégorie.  
- **picture** : image de la catégorie (binaire).

---

`suppliers`

Liste les fournisseurs des produits.

- **supplier_id** : identifiant unique du fournisseur (clé primaire).  
- **company_name** : nom de l’entreprise fournisseur.  
- **contact_name** : nom du contact principal.  
- **contact_title** : fonction du contact.  
- **address** : adresse complète du fournisseur.  
- **city** : ville du fournisseur.  
- **region** : région ou état.  
- **postal_code** : code postal.  
- **country** : pays du fournisseur.  
- **phone** : numéro de téléphone.  
- **fax** : numéro de fax.  
- **homepage** : site web ou page de présentation.

---

`employees`

Contient les informations sur les employés.

- **employee_id** : identifiant unique de l’employé (clé primaire).  
- **last_name** : nom de famille de l’employé.  
- **first_name** : prénom de l’employé.  
- **title** : intitulé du poste (ex. Sales Representative).  
- **title_of_courtesy** : civilité (Mr., Mrs., Dr., etc.).  
- **birth_date** : date de naissance.  
- **hire_date** : date d’embauche.  
- **address** : adresse personnelle.  
- **city** : ville de résidence.  
- **region** : région ou état.  
- **postal_code** : code postal.  
- **country** : pays.  
- **home_phone** : numéro de téléphone personnel.  
- **extension** : extension téléphonique interne.  
- **photo** : photo de l’employé (binaire).  
- **notes** : remarques ou informations complémentaires.  
- **reports_to** : identifiant du supérieur hiérarchique (`employees.employee_id`).  
- **photo_path** : chemin vers la photo.

---

`shippers`

Contient les transporteurs utilisés pour la livraison.

- **shipper_id** : identifiant unique du transporteur (clé primaire).  
- **company_name** : nom de la société de transport.  
- **phone** : numéro de téléphone du transporteur.

---

`territories`

Zones géographiques couvertes par les employés.

- **territory_id** : identifiant unique du territoire (clé primaire).  
- **territory_description** : description du territoire.  
- **region_id** : référence vers la région correspondante (`region.region_id`).

---

`region`

Regroupe plusieurs territoires.

- **region_id** : identifiant unique de la région (clé primaire).  
- **region_description** : description textuelle (ex. "Eastern", "Western").

---

`employee_territories`

Table de jonction entre employés et territoires.

- **employee_id** : identifiant de l’employé (`employees.employee_id`).  
- **territory_id** : identifiant du territoire (`territories.territory_id`).

Chaque ligne indique qu’un employé est responsable d’un territoire donné.

---

`us_states`

Référentiel des États américains.

- **state_id** : identifiant unique de l’État (clé primaire).  
- **state_name** : nom complet de l’État.  
- **state_abbr** : abréviation (ex. CA pour California).  
- **state_region** : région géographique (ex. West, Midwest).

---

### Schéma simplifié des relations

![Schema Northwind](figures\ER_northwind.png)

### Installation de la base Northwind sur PostgreSQL avec DBeaver

**1. Télécharger le script SQL**

Télécharger script sql d’installation de Northwind ici :  [northwind.sql]({{ '/datasets/northwind.sql' | relative_url }})

**2. Ouvrir DBeaver et créer une nouvelle base**

1. Lancez **DBeaver**  
2. Cliquez sur **Nouvelle connexion** → **postgresqlL**
3. Connectez-vous à votre serveur local
4. Une fois connecté, faites clic droit sur Bases de données → **Créer Base de données**
5. Nommez-la : `northwind`

**3. Exécuter le script**

1. Faites clic droit sur la base `northwind` → **Outils → Execute script**
2. Dans Input selectionner le fichier `northwind.sql`
3. Cliquez sur **Suivant**
4. Cliquez sur **Démarrage**  
   → Les tables, vues et données seront automatiquement créées.

## Requêtes SQL
### Afficher toutes les colonnes d'une table (SELECT, FROM)

Le mot-clé **SELECT** permet de choisir quelles colonnes afficher, tandis que **FROM** indique la table à interroger.

Afficher tous les clients enregistrés :

```sql
SELECT *
FROM customers;
```

`*` signifie « toutes les colonnes ».

---

### Afficher certaines colonnes

Afficher uniquement le nom de l'entreprise et le pays :

```sql
SELECT
    company_name,
    country
FROM customers;
```

---

### Supprimer les doublons (DISTINCT)

Le mot-clé **DISTINCT** permet d'afficher uniquement les valeurs uniques d'une colonne.

Lister les pays uniques où vivent les clients :

```sql
SELECT DISTINCT country
FROM customers;
```

---

### Filtrer les données avec WHERE

#### Condition d'égalité (=)

Afficher les clients dont le pays est exactement « USA » :

```sql
SELECT *
FROM customers
WHERE country = 'USA';
```

`=` vérifie l'égalité.

---

#### Différence (<> ou !=)

Afficher les clients qui ne sont **pas** en France :

```sql
SELECT *
FROM customers
WHERE country <> 'France';
```

`<>` est la syntaxe standard SQL pour « différent de ».\
`!=` fonctionne aussi en PostgreSQL.

---

#### Combiner des conditions (AND / OR)

- **AND** : les deux conditions doivent être vraies.
- **OR** : au moins une des conditions doit être vraie.

Lister les produits dont le prix est supérieur à 20 et toujours en vente :

```sql
SELECT *
FROM products
WHERE unit_price > 20
  AND discontinued = 0;
```

Lister les clients situés aux USA ou en France :

```sql
SELECT *
FROM customers
WHERE country = 'USA'
   OR country = 'France';
```

---

#### Appartenir à une liste (IN)

Le mot-clé **IN** permet de vérifier si une valeur fait partie d'une liste.

Lister les fournisseurs américains, français ou allemands :

```sql
SELECT *
FROM suppliers
WHERE country IN ('USA', 'France', 'Germany');
```

---

#### Recherches textuelles (LIKE / ILIKE)

- **LIKE** cherche un motif exact, sensible à la casse.
- **ILIKE** fait la même recherche, mais sans tenir compte des majuscules/minuscules.

Le symbole `%` remplace une suite de caractères quelconques.

Lister les clients dont le nom commence par la lettre A :

```sql
SELECT *
FROM customers
WHERE company_name LIKE 'A%';
```

Lister les produits contenant le mot "choco" (insensible à la casse) :

```sql
SELECT *
FROM products
WHERE product_name ILIKE '%choco%';
```

Exclure les produits contenant le mot "sauce" :

```sql
SELECT *
FROM products
WHERE product_name NOT ILIKE '%sauce%';
```

---

#### Intervalle de valeurs (BETWEEN)

Le mot-clé **BETWEEN** s'utilise pour filtrer une valeur comprise entre deux bornes inclusives.

Afficher les produits dont le prix est compris entre 10 et 20 :

```sql
SELECT *
FROM products
WHERE unit_price BETWEEN 10 AND 20;
```

---

### Limiter le nombre de résultats (LIMIT)

**LIMIT** permet de restreindre le nombre de lignes retournées.

Afficher les 5 premiers produits :

```sql
SELECT *
FROM products
LIMIT 5;
```

---

### Trier les résultats (ORDER BY)

**ORDER BY** trie les résultats selon une ou plusieurs colonnes.\
Par défaut le tri est croissant (`ASC`), mais on peut aussi utiliser `DESC` pour décroissant.

Trier les produits par prix unitaire décroissant :

```sql
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC;
```

---

### Renommer les colonnes et tables avec un alias (AS)

Le mot-clé **AS** sert à renommer temporairement une table ou une colonne pour améliorer la lisibilité.

Afficher les clients français avec alias :

```sql
SELECT
    c.company_name AS client,
    c.country AS pays
FROM customers AS c
WHERE c.country = 'France';
```

---

### Jointures entre tables (JOIN)

Les jointures permettent de combiner plusieurs tables selon une relation logique (généralement une clé étrangère).

#### INNER JOIN

**INNER JOIN** retourne uniquement les lignes qui ont une correspondance dans les deux tables.

Lister les commandes avec le nom du client :

```sql
SELECT
    o.order_id,
    c.company_name AS client
FROM orders AS o
INNER JOIN customers AS c
    ON o.customer_id = c.customer_id;
```

---

#### LEFT JOIN

**LEFT JOIN** garde toutes les lignes de la table de gauche, et ajoute les données correspondantes de la table de droite s'il y en a. Sinon, les valeurs à droite sont `NULL`.

Lister tous les clients, même ceux sans commande :

```sql
SELECT
    c.company_name AS client,
    o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

---

#### RIGHT JOIN et FULL OUTER JOIN

- **RIGHT JOIN** fait l'inverse du `LEFT JOIN` : garde toutes les lignes de la table de droite.
- **FULL OUTER JOIN** combine toutes les lignes des deux tables, qu'il y ait correspondance ou non.

Exemple :

```sql
SELECT
    c.company_name,
    o.order_id
FROM customers AS c
FULL OUTER JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

---

### Fonctions d'agrégation et regroupements

#### Fonctions principales

Les fonctions d'agrégation résument un ensemble de lignes :

- **COUNT()** compte le nombre de lignes,
- **SUM()** fait la somme,
- **AVG()** calcule la moyenne,
- **MIN() / MAX()** trouvent les valeurs extrêmes.

Exemples :

```sql
SELECT COUNT(*) AS nb_customers FROM customers;
SELECT AVG(unit_price) AS avg_price FROM products;
SELECT SUM(unit_price * quantity) AS total_sales FROM order_details;
```

---

#### Regrouper les résultats (GROUP BY)

**GROUP BY** regroupe les lignes ayant une même valeur pour une colonne.

Nombre de clients par pays :

```sql
SELECT
    country,
    COUNT(*) AS nb_customers
FROM customers
GROUP BY country;
```

---

#### Filtrer les groupes (HAVING)

**HAVING** filtre les résultats d'un `GROUP BY` selon une condition sur les agrégats.

Afficher les pays avec plus de 5 clients :

```sql
SELECT
    country,
    COUNT(*) AS nb_customers
FROM customers
GROUP BY country
HAVING COUNT(*) > 5;
```

---

### Sous-requêtes

Une **sous-requête** est une requête imbriquée à l'intérieur d'une autre. Elle permet d'utiliser un résultat calculé ou filtré pour enchaîner une analyse plus complexe.

#### Sous-requête simple dans une condition (WHERE)

Lister les produits plus chers que la moyenne :

```sql
SELECT
    product_name,
    unit_price
FROM products
WHERE unit_price > (
    SELECT AVG(unit_price)
    FROM products
);
```

Ici, la sous-requête retourne le prix moyen des produits, utilisé dans la condition `WHERE`.

---

#### Sous-requête dans la clause FROM (vue temporaire)

Créer une sous-requête servant de table temporaire, souvent appelée **table dérivée** :

```sql
SELECT category_name, AVG_price
FROM (
    SELECT
        c.category_name,
        AVG(p.unit_price) AS AVG_price
    FROM products AS p
    INNER JOIN categories AS c
        ON p.category_id = c.category_id
    GROUP BY c.category_name
) AS subquery
WHERE AVG_price > 30;
```

Ici, la sous-requête calcule le prix moyen par catégorie avant de filtrer celles dont le prix moyen dépasse 30.

---

#### Sous-requête corrélée

Une **sous-requête corrélée** dépend d'une valeur de la requête principale. Elle est exécutée pour chaque ligne.

Afficher les produits dont le prix est supérieur à la moyenne de leur propre catégorie :

```sql
SELECT
    p.product_name,
    p.unit_price,
    c.category_name
FROM products AS p
INNER JOIN categories AS c
    ON p.category_id = c.category_id
WHERE p.unit_price > (
    SELECT AVG(p2.unit_price)
    FROM products AS p2
    WHERE p2.category_id = p.category_id
);
```

Ici, la sous-requête est recalculée pour chaque catégorie (corrélation via `category_id`).

---

#### Sous-requête avec IN

Afficher les clients ayant passé au moins une commande :

```sql
SELECT company_name
FROM customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM orders
);
```

La sous-requête retourne la liste des clients ayant des commandes, utilisée par `IN` pour filtrer la table principale.

---

#### Sous-requête avec EXISTS

Le mot-clé **EXISTS** vérifie si la sous-requête renvoie au moins une ligne.

Afficher les clients qui ont passé au moins une commande (même résultat que ci-dessus) :

```sql
SELECT company_name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
```

`EXISTS` est souvent plus performant que `IN` lorsque la sous-requête dépend d'une clé étrangère.

---

#### Sous-requête dans la clause SELECT

Une sous-requête peut aussi calculer une valeur dérivée dans une colonne :

```sql
SELECT
    c.company_name,
    (
        SELECT COUNT(*)
        FROM orders AS o
        WHERE o.customer_id = c.customer_id
    ) AS nb_orders
FROM customers AS c
ORDER BY nb_orders DESC;
```

Cela permet d’ajouter dynamiquement une information agrégée sans passer par une jointure ou un `GROUP BY`.

---

### Ordre logique d'exécution SQL

1. **FROM** – sélection des tables
2. **WHERE** – filtrage des lignes
3. **GROUP BY** – regroupement
4. **HAVING** – filtrage des groupes
5. **SELECT** – sélection des colonnes
6. **ORDER BY** – tri final
7. **LIMIT** – restriction du nombre de lignes

### Exercices

Télécharger le script sql contenant la liste d'exercice :  [northwind_queries.sql]({{ 'northwind_queries.sql' | relative_url }})