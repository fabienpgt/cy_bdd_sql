# Examen Final

## 1. Contexte général

La base DVD Rental modélise l’activité complète d’un magasin de location de DVD.

Elle permet de gérer :
- les films et leurs caractéristiques,
- les acteurs et les catégories,
- les clients,
- les magasins et les employés,
- les exemplaires disponibles (inventory),
- les locations et les paiements,
- les informations de localisation (address → city → country).

---

## 2. Films et contenu

### Table `film`

Champs essentiels :
- film_id (PK)
- title
- description
- release_year
- language_id (FK → language)
- rental_duration
- rental_rate
- length
- replacement_cost
- rating (enum MPAA)
- special_features
- fulltext (tsvector)
- last_update

### Table `actor`
- actor_id (PK)
- first_name
- last_name
- last_update

### Table `film_actor`
Relation n-n entre film et actor :
- actor_id (PK, FK)
- film_id (PK, FK)
- last_update

### Table `category`
- category_id (PK)
- name
- last_update

### Table `film_category`
Relation n-n entre film et category :
- film_id (PK, FK)
- category_id (PK, FK)
- last_update

### Table `language`
- language_id (PK)
- name
- last_update

---

## 3. Magasins, inventaire et employés

### Table `store`
- store_id (PK)
- manager_staff_id (FK → staff)
- address_id (FK → address)
- last_update


### Table `staff`
- staff_id (PK)
- first_name
- last_name
- address_id (FK)
- email
- store_id (FK)
- active
- username
- password
- picture
- last_update

### Table `inventory`
- inventory_id (PK)
- film_id (FK)
- store_id (FK)
- last_update

---

## 4. Clients, adresses et localisation

### Table `address`
- address_id (PK)
- address
- address2
- district
- city_id (FK)
- postal_code
- phone
- last_update

### Table `city`
- city_id (PK)
- city
- country_id (FK)
- last_update

### Table `country`
- country_id (PK)
- country
- last_update

### Table `customer`
- customer_id (PK)
- store_id (FK)
- first_name
- last_name
- email
- address_id (FK)
- activebool (bool)
- create_date
- last_update
- active (int)

---

## 5. Locations et paiements

### Table `rental`
- rental_id (PK)
- rental_date
- inventory_id (FK)
- customer_id (FK)
- return_date
- staff_id (FK)
- last_update

### Table `payment`
- payment_id (PK)
- customer_id (FK)
- staff_id (FK)
- rental_id (FK)
- amount
- payment_date

---

## 6. Relations essentielles du modèle

### Clients / Magasins / Employés
- Un client appartient à un seul magasin.
- Un employé appartient à un magasin.
- Un magasin a un manager (manager_staff_id).

### Clients / Locations / Paiements
- Un client peut avoir plusieurs locations.
- Une location concerne un exemplaire précis (inventory_id).
- Chaque paiement correspond obligatoirement à une location.

### Inventaire / Film / Magasin
- Un film peut être présent dans plusieurs magasins.
- Chaque exemplaire est identifié dans inventory.

### Films / Acteurs / Catégories
- film_actor : relation n-n film ↔ acteur.
- film_category : relation n-n film ↔ catégorie.

### Localisation
- address → city → country
- customer, staff et store s’appuient tous sur address.


## Installation de la base dvdrental sur PostgreSQL avec DBeaver

**1. Télécharger le script SQL**

Télécharger le fichier backup de la base de données dvdrentals :  [dvdrental.tar]({{ '/datasets/dvdrental.tar' | relative_url }})

**2. Ouvrir DBeaver et créer une nouvelle base**

1. Lancez **DBeaver**  
2. Cliquez sur **Nouvelle connexion** → **postgresqlL**
3. Connectez-vous à votre serveur local
4. Une fois connecté, faites clic droit sur Bases de données → **Créer Base de données**
5. Nommez-la : `dvdrental`

**3. Exécuter le script**

1. Faites clic droit sur la base `northwind` → **Outils → Restore**
2. Choisir le Format 'Tar'
3. Assurer que les 3 élements en dessous sont décochés
4. Dans Input selectionner le fichier `dvdrental.tar` (si le fichier ne s'affiche pas choisissez "*" à la place de "*backup" dans le navigateur de fichiers)
5. Cliquez sur **Démarrage**  
   → Les tables, vues et données seront automatiquement créées.