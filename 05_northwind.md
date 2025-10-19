# Base de données Northwind

## Présentation générale

La base de données **Northwind** est une base d’exemple créée par Microsoft pour illustrer le fonctionnement des bases relationnelles et du langage **SQL**.  
Elle représente une entreprise fictive, **Northwind Traders**, spécialisée dans l’import et l’export de produits alimentaires à travers le monde.

---

## Structure de la base de données

### customers
Contient les informations sur les **clients** de Northwind Traders.  
Champs principaux :  
`customer_id`, `company_name`, `contact_name`, `contact_title`, `address`, `city`, `region`, `postal_code`, `country`, `phone`, `fax`.

---

### suppliers
Regroupe les informations sur les **fournisseurs** qui approvisionnent Northwind.  
Champs principaux :  
`supplier_id`, `company_name`, `contact_name`, `contact_title`, `address`, `city`, `region`, `postal_code`, `country`, `phone`, `fax`, `homepage`.

---

### products
Liste tous les **produits** vendus par Northwind.  
Champs principaux :  
`product_id`, `product_name`, `supplier_id`, `category_id`, `quantity_per_unit`, `unit_price`, `units_in_stock`, `units_on_order`, `reorder_level`, `discontinued`.

Relations :  
- Chaque produit appartient à une **catégorie** (`category_id`).  
- Chaque produit provient d’un **fournisseur** (`supplier_id`).

---

### categories
Classe les produits par **type** (boissons, produits laitiers, viandes, etc.).  
Champs principaux :  
`category_id`, `category_name`, `description`, `picture`.

---

### orders
Représente les **commandes** effectuées par les clients.  
Champs principaux :  
`order_id`, `customer_id`, `employee_id`, `order_date`, `required_date`, `shipped_date`, `ship_via`, `freight`, `ship_name`, `ship_address`, `ship_city`, `ship_region`, `ship_postal_code`, `ship_country`.

Relations :  
- Une commande est passée par un **client** (`customer_id`).  
- Elle est prise en charge par un **employé** (`employee_id`).  
- Elle est livrée par un **transporteur** (`ship_via`).

---

### order_details
Contient le **détail** de chaque commande, c’est-à-dire les produits commandés et leurs quantités.  
Champs principaux :  
`order_id`, `product_id`, `unit_price`, `quantity`, `discount`.

Relation : table d’association entre `orders` et `products`.

---

### employees
Liste les **employés** de Northwind et leurs informations professionnelles.  
Champs principaux :  
`employee_id`, `last_name`, `first_name`, `title`, `title_of_courtesy`, `birth_date`, `hire_date`, `address`, `city`, `region`, `postal_code`, `country`, `home_phone`, `extension`, `photo`, `notes`, `reports_to`, `photo_path`.

Relations :  
- Un employé peut superviser d’autres employés via `reports_to`.  
- Un employé peut gérer plusieurs commandes.

---

### shippers
Liste les **transporteurs** chargés des livraisons.  
Champs principaux :  
`shipper_id`, `company_name`, `phone`.

---

### territories et region
Permettent de regrouper les employés par **zone géographique**.  
- Table `territories` : `territory_id`, `territory_description`, `region_id`.  
- Table `region` : `region_id`, `region_description`.

---

### employee_territories
Table d’association entre `employees` et `territories`.  
Champs principaux :  
`employee_id`, `territory_id`.

---

### customer_customer_demo et customer_demographics
Permettent de classifier les clients selon leur profil ou type.  
- Table `customer_customer_demo` : `customer_id`, `customer_type_id`.  
- Table `customer_demographics` : `customer_type_id`, `customer_desc`.

---

### us_states
Liste des **états américains** (utile pour certaines adresses).  
Champs principaux :  
`state_id`, `state_name`, `state_abbr`, `state_region`.

---

## 3. Relations principales

- Un **customer** peut avoir plusieurs **orders**.  
- Une **order** contient plusieurs **products** (via `order_details`).  
- Un **product** appartient à une seule **category** et provient d’un seul **supplier**.  
- Un **employee** peut gérer plusieurs **orders** et dépend d’un supérieur (`reports_to`).  
- Un **shipper** livre plusieurs **orders**.  
- Les **employees** peuvent être associés à plusieurs **territories** (table `employee_territories`).

---

## 4. Installation sur DBeaver (PostgreSQL)

### Étape 1 – Télécharger le script SQL
Récupère le fichier `northwind.sql` (version PostgreSQL) depuis un dépôt GitHub fiable ou une source éducative.  
Ce fichier contient toutes les instructions nécessaires pour créer les tables et insérer les données.

---

### Étape 2 – Créer la base de données
1. Ouvre **DBeaver** et connecte-toi à ton serveur PostgreSQL local.  
2. Clic droit sur ta connexion → *Create → Database*.  
3. Donne le nom : `northwind`.  
4. Clique sur **OK**.

---

### Étape 3 – Charger le script
1. Clic droit sur la base `northwind` → *SQL Editor → Open SQL Script*.  
2. Ouvre ou colle le contenu du fichier `northwind.sql`.

---

### Étape 4 – Exécuter le script
Clique sur le bouton ▶️ *Execute Script*.  
Le script va :
- créer toutes les tables,
- insérer les données (clients, produits, commandes…).

---

## Exercices SQL sur la base Northwind

Les questions ci-dessous te permettront de progresser pas à pas dans l’apprentissage du SQL à partir de la base **Northwind**.  
Chaque série de questions introduit une nouvelle notion — du plus simple au plus avancé.

---

### Sélections simples

- Afficher toutes les colonnes de la table `customers`.  
- Afficher uniquement les colonnes `product_name` et `unit_price` de la table `products`.  
- Afficher uniquement les `company_name` et `country` de la table `suppliers`.  
- Lister tous les `category_name` de la table `categories`.  
- Afficher toutes les commandes de la table `orders`.

---

### Filtres et conditions (`WHERE`, `LIKE`, `BETWEEN`, `IN`, `IS NULL`)

- Afficher tous les produits dont le `unit_price` est supérieur à 30.  
- Afficher tous les clients dont le `country` est 'France'.  
- Trouver les employés dont le `city` est 'London'.  
- Lister les produits dont le `product_name` commence par la lettre 'C'.  
- Trouver les produits dont le `unit_price` est compris entre 10 et 20.  
- Afficher les commandes dont la `order_date` est postérieure à '1997-01-01'.  
- Trouver les produits qui sont **discontinued**.  
- Afficher les clients dont le `region` est vide (`NULL`).  
- Trouver les produits qui appartiennent aux catégories 1, 3 ou 5.  
- Trouver les commandes dont la `ship_country` n’est pas 'USA'.

---

### Tri et alias (`ORDER BY`, `AS`)

- Afficher tous les produits triés par `unit_price` du plus cher au moins cher.  
- Afficher les clients triés par `company_name` en ordre alphabétique.  
- Afficher les employés triés par date d’embauche (`hire_date`) du plus ancien au plus récent.  
- Afficher les 10 produits les plus chers.  
- Afficher les 5 produits les moins chers et renommer les colonnes en `product` et `price`.  

---

### Fonctions d’agrégation (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)

- Compter le nombre total de clients.  
- Compter le nombre total de produits.  
- Calculer le prix moyen (`AVG`) des produits.  
- Trouver le produit le plus cher et le moins cher.  
- Calculer la somme totale des `freight` (frais de port) pour toutes les commandes.  
- Calculer le nombre de commandes passées en 1997.  
- Trouver la quantité totale de produits commandés dans `order_details`.

---

### Regroupements (`GROUP BY`, `HAVING`)

- Compter le nombre de clients par `country`.  
- Calculer le prix moyen des produits par `category_id`.  
- Compter le nombre de produits par `supplier_id`.  
- Afficher le nombre total de commandes par `customer_id`.  
- Calculer la somme du `freight` par pays (`ship_country`).  
- Afficher uniquement les pays ayant plus de 10 commandes (`HAVING`).  
- Afficher la valeur totale des ventes (`unit_price * quantity`) par `product_id`.  

---

### Jointures (`JOIN`)

- Afficher les commandes avec le nom du client (`customers`) et du transporteur (`shippers`).  
- Afficher les produits avec leur catégorie (`categories`).  
- Afficher les produits avec le nom de leur fournisseur (`suppliers`).  
- Afficher les lignes de commande (`order_details`) avec le `product_name` associé.  
- Afficher les commandes avec le nom de l’employé (`employees`) qui les a gérées.  
- Afficher toutes les commandes avec le nom du client, le nom de l’employé et le pays d’expédition.  
- Lister les employés et le nom de leur supérieur hiérarchique (`reports_to`).  
- Afficher les territoires (`territories`) associés à chaque employé (`employees`).

---

### Sous-requêtes

- Trouver les produits plus chers que le prix moyen de tous les produits.  
- Trouver les clients qui n’ont passé aucune commande.  
- Trouver les employés qui ont traité des commandes expédiées en France.  
- Trouver les produits appartenant à des catégories dont le nom contient “Beverages”.  
- Trouver les fournisseurs dont les produits sont tous à plus de 20 euros.  
- Trouver les employés qui ne supervisent personne.  
- Trouver les clients ayant passé plus de 5 commandes.

---

### Requêtes avancées et analytiques

- Trouver les 5 meilleurs clients selon le montant total des ventes.  
- Trouver les 5 produits les plus vendus (en quantité).  
- Calculer le chiffre d’affaires total par année (`order_date`).  
- Calculer le chiffre d’affaires total par employé.  
- Calculer le délai moyen entre `order_date` et `shipped_date`.  
- Identifier les catégories les plus rentables (somme des ventes).  
- Afficher le nombre moyen de commandes par client.  
- Identifier les 3 pays ayant généré le plus de revenus. 