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

## Présentation de la base de données Northwind

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

**Customers**  
Contient les informations sur les clients.
- `CustomerID` → identifiant unique du client  
- `CompanyName` → nom de l’entreprise  
- `ContactName` → nom du contact principal  
- `ContactTitle` → fonction du contact  
- `Address`, `City`, `Region`, `PostalCode`, `Country`  
- `Phone`, `Fax`

---

**Orders**  
Contient les commandes passées par les clients.
- `OrderID` → identifiant unique de la commande  
- `CustomerID` → identifiant du client (`Customers.CustomerID`)  
- `EmployeeID` → identifiant de l’employé responsable  
- `OrderDate`, `RequiredDate`, `ShippedDate`  
- `ShipVia` → identifiant du transporteur (`Shippers.ShipperID`)  
- `Freight` → coût du transport  
- `ShipName`, `ShipAddress`, `ShipCity`, `ShipCountry`

---

**OrderDetails** (ou `Order_Details`)  
Détaille les produits contenus dans chaque commande.
- `OrderID` → clé étrangère vers `Orders`  
- `ProductID` → clé étrangère vers `Products`  
- `UnitPrice` → prix unitaire  
- `Quantity` → quantité commandée  
- `Discount` → remise appliquée

---

**Products**  
Liste les produits vendus.
- `ProductID` → identifiant du produit  
- `ProductName` → nom du produit  
- `SupplierID` → clé étrangère vers `Suppliers`  
- `CategoryID` → clé étrangère vers `Categories`  
- `QuantityPerUnit` → conditionnement  
- `UnitPrice` → prix unitaire  
- `UnitsInStock`, `UnitsOnOrder`  
- `Discontinued` → indique si le produit est encore vendu

---

**Categories**  
Regroupe les produits par type.
- `CategoryID` → identifiant unique  
- `CategoryName` → nom de la catégorie (ex : Beverages, Seafood)  
- `Description`

---

**Suppliers**  
Liste les fournisseurs.
- `SupplierID` → identifiant unique  
- `CompanyName`, `ContactName`, `ContactTitle`  
- `Address`, `City`, `Country`, `Phone`

---

**Employees**  
Contient les informations sur les employés de Northwind.
- `EmployeeID` → identifiant unique  
- `LastName`, `FirstName`, `Title`  
- `ReportsTo` → identifiant du supérieur hiérarchique  
- `HireDate`, `BirthDate`, `Country`, `City`

---

**Shippers**  
Contient les transporteurs utilisés pour les livraisons.
- `ShipperID` → identifiant unique  
- `CompanyName`  
- `Phone`

---

## Schéma simplifié des relations

## Installation de la base Northwind sur PostgreSQL avec DBeaver

### 1. Télécharger le script SQL

Télécharger script sql d’installation de Northwind ici :  [northwind.sql]({{ '/datasets/northwind.sql' | relative_url }})

### 2. Ouvrir DBeaver et créer une nouvelle base

1. Lancez **DBeaver**  
2. Cliquez sur **Nouvelle connexion** → **postgresqlL**
3. Connectez-vous à votre serveur local
4. Une fois connecté, faites clic droit sur Bases de données → **Créer Base de données**
5. Nommez-la : `northwind`

### 3. Exécuter le script

1. Faites clic droit sur la base `northwind` → **Outils → Execute script**
2. Dans Input selectionner le fichier `northwind.sql`
3. Cliquez sur **Suivant**
4. Cliquez sur **Démarrage**  
   → Les tables, vues et données seront automatiquement créées.

## Sélection simple – SELECT et FROM

**SELECT** permet de choisir quelles colonnes afficher dans le résultat. C’est la commande de base pour interroger une table.\
**FROM** indique la table dans laquelle chercher les données.

**Afficher toutes les colonnes**

```sql
SELECT *
FROM Customers;
```


→ `*` signifie “toutes les colonnes”.

---

**Afficher certaines colonnes**

```sql
SELECT
    CompanyName,
    Country
FROM Customers;
```

→ Ici, seules les colonnes **CompanyName** et **Country** sont affichées.

---

**Supprimer les doublons**

```sql
SELECT DISTINCT
    Country
FROM Customers;
```

→ `DISTINCT` supprime les valeurs répétées.

---

## Filtrer les données – WHERE

Le mot-clé **WHERE** permet de limiter les résultats selon une ou plusieurs conditions.

**Égalité**

```sql
SELECT *
FROM Customers
WHERE Country = 'USA';
```

→ `=` vérifie que la valeur d’une colonne correspond exactement à la valeur indiquée.

---

**Différent de**

```sql
SELECT *
FROM Customers
WHERE Country <> 'France';
```

→ `<>` est la forme standard SQL pour “différent de”.\
→ `!=` fonctionne aussi, mais `<>` est plus conventionnel.

---

Plusieurs conditions avec **AND** et **OR** :

```sql
SELECT *
FROM Products
WHERE UnitPrice > 20
  AND Discontinued = 0;
```

→ `AND` signifie que les deux conditions doivent être vraies.

```sql
SELECT *
FROM Customers
WHERE Country = 'USA'
   OR Country = 'France';
```

→ `OR` signifie qu’une seule des conditions suffit.

---

Utiliser **IN** pour simplifier plusieurs OR :

```sql
SELECT *
FROM Suppliers
WHERE Country IN ('USA', 'France', 'Germany');
```

→ `IN` vérifie si une valeur appartient à une liste.

---

## Recherches textuelles – LIKE et ILIKE

**LIKE** et **ILIKE** servent à filtrer les résultats sur du texte.

Commence par :

```sql
SELECT *
FROM Customers
WHERE CompanyName LIKE 'A%';
```

→ `%` remplace n’importe quelle suite de caractères. Ici, les noms commençant par A.

---

Contient un mot :

```sql
SELECT *
FROM Products
WHERE ProductName LIKE '%Choco%';
```

→ Recherche les produits contenant “Choco” dans leur nom.

---

Insensible à la casse (**ILIKE**) :

```sql
SELECT *
FROM Customers
WHERE CompanyName ILIKE '%market%';
```

→ ILIKE ignore la différence entre majuscules et minuscules.

---

Exclure un mot :

```sql
SELECT *
FROM Products
WHERE ProductName NOT ILIKE '%sauce%';
```

→ `NOT` inverse la condition.

---

## Trier les résultats – ORDER BY

**ORDER BY** classe les lignes selon un ou plusieurs critères.

Tri par prix décroissant :

```sql
SELECT
    ProductName,
    UnitPrice
FROM Products
ORDER BY UnitPrice DESC;
```

→ `DESC` signifie décroissant.

---

Tri croissant (par défaut) :

```sql
SELECT
    ProductName,
    UnitPrice
FROM Products
ORDER BY UnitPrice ASC;
```

→ `ASC` signifie croissant.

---

## Renommer des colonnes et tables – AS

Les alias rendent les requêtes plus lisibles, surtout lorsqu’on travaille avec plusieurs tables
**AS** permet d’attribuer un alias à une colonne ou une table.

```sql
SELECT
    c.CompanyName AS customer,
    c.Country
FROM Customers AS c
WHERE c.Country = 'France';
```

→ `AS` renomme temporairement la colonne ou la table dans la requête.

---

## Jointures – Relier plusieurs tables avec JOIN

Une jointure relie plusieurs tables entre elles à partir d’une clé commune, souvent une clé primaire et une clé étrangère.
C’est ce qui permet de combiner plusieurs sources d’informations.

**Jointure interne `INNER JOIN`**
C’est le type de jointure le plus courant.
Elle ne garde que les lignes qui existent dans les deux tables.
Autrement dit : seules les correspondances sont affichées.

```sql
SELECT
    o.OrderID,
    c.CompanyName AS customer
FROM Orders AS o
INNER JOIN Customers AS c
    ON o.CustomerID = c.CustomerID;
```

→ Retourne uniquement les lignes qui existent dans les deux tables.

---

**Jointure externe gauche (`LEFT JOIN`)**
Elle garde toutes les lignes de la table de gauche (celle indiquée avant JOIN),
et ajoute les données correspondantes de la table de droite lorsqu’elles existent.
S’il n’y a pas de correspondance, les valeurs de la table de droite sont remplacées par NULL.

```sql
SELECT
    c.CompanyName AS customer,
    o.OrderID
FROM Customers AS c
LEFT JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;
```

→ Garde tous les clients, même ceux sans commande (les colonnes d’Orders vaudront NULL).

---

## Fonctions d’agrégation

Les **fonctions d’agrégation** calculent une valeur à partir d’un ensemble de lignes.
Elles permettent de résumer les données : compter, additionner, ou calculer une moyenne.

Principales fonctions :

    `COUNT()` → compte le nombre de lignes
    `SUM()` → fait la somme
    `AVG()` → calcule la moyenne
    `MIN()` → renvoie la plus petite valeur
    `MAX()` → renvoie la plus grande valeur


---

Compter :

```sql
SELECT COUNT(*) AS nb_customers
FROM Customers;
```

→ `COUNT()` compte le nombre de lignes.

---

Moyenne :

```sql
SELECT AVG(UnitPrice) AS avg_price
FROM Products;
```

→ `AVG()` calcule la moyenne.

---

Somme :

```sql
SELECT SUM(UnitPrice * Quantity) AS total_sales
FROM OrderDetails;
```

→ `SUM()` additionne les valeurs.

---

## Regrouper les résultats – GROUP BY

**GROUP BY** regroupe les lignes par valeur de colonne.

Nombre de clients par pays :

```sql
SELECT
    Country,
    COUNT(*) AS nb_customers
FROM Customers
GROUP BY Country;
```

→ Chaque pays devient un groupe, et COUNT compte les clients de ce groupe.

---

## Filtrer les groupes – HAVING

`HAVING` s’utilise après `GROUP BY` pour filtrer sur des valeurs agrégées.
Contrairement à `WHERE`, il agit sur le résultat du regroupement.

```sql
SELECT
    Country,
    COUNT(*) AS nb_customers
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 5;
```

→ Affiche uniquement les pays ayant plus de 5 clients.

---

## Sous-requêtes – Requêtes imbriquées

Une **sous-requête** est une requête placée à l’intérieur d’une autre.

Produits plus chers que la moyenne :

```sql
SELECT
    ProductName,
    UnitPrice
FROM Products
WHERE UnitPrice > (
    SELECT AVG(UnitPrice)
    FROM Products
);
```

→ La sous-requête calcule le prix moyen, la requête principale affiche les produits supérieurs à cette moyenne.

---

## 11. Ordre logique d’exécution

L’ordre dans lequel SQL exécute les clauses :

1. **FROM** – choisit la table ou la jointure.
2. **WHERE** – filtre les lignes.
3. **GROUP BY** – regroupe les lignes.
4. **HAVING** – filtre les groupes.
5. **SELECT** – affiche les colonnes demandées.
6. **ORDER BY** – trie le résultat final.

---

## 12. Exercices pratiques

1. Lister les 10 produits les plus chers.
2. Trouver les clients américains.
3. Compter le nombre de commandes par client.
4. Calculer la valeur totale de chaque commande.
5. Lister les produits vendus par chaque fournisseur.
6. Trouver les catégories contenant plus de 5 produits.
7. Identifier les clients ayant passé plus de 3 commandes.
8. Calculer le prix moyen des produits par catégorie.
9. Lister les employés ayant traité plus de 50 commandes.
10. Trouver les pays où le nombre de clients dépasse la moyenne.