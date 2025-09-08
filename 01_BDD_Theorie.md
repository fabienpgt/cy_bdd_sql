# Introduction aux bases de données et aux SGBD
## Les tableurs

Beaucoup d’organisations commencent avec un tableur. C’est intuitif : on saisit des données, on fait des calculs, on trie, on filtre, on partage un fichier. Pour de petites tâches ou des analyses ponctuelles, c'est très efficace.

Mais dès que les données deviennent nombreuses, partagées ou évolutives, les limites apparaissent vite.

**Exemple**

| Nom client     | Adresse client                  | N° commande | Date commande | Produit | Quantité | Prix unitaire (€) | Mode de paiement | Statut livraison |
| -------------- | ------------------------------- | ----------- | ------------- | ------- | -------- | ----------------- | ---------------- | ---------------- |
| Dupont Jean    | 12 rue de Paris, Lyon           | CMD001      | 2025-09-01    | Pomme   | 10       | 1,20              | CB               | Livré            |
| Dupon J.       | 12 rue Paris, Lyon              | CMD001      | 2025-09-01    | Poire   | 5        | 1,50              | CB               | Livré            |
| Martin Sophie  | 4 pl. Bellecour, Lyon           | CMD002      | 2025-09-01    | Banane  | 3        | 2,40              | Virement         | En préparation   |
| Martine Sophie | 4 place Bellecour, Lion         | CMD002      | 2025-09-01    | Pomme   | 20       | 1,20              | Virement         | En préparation   |
| Nguyen Paul    | 85 av Jean Jaures, Marseille    | CMD003      | 2025-09-02    | Poire   | 15       | 1,50              | CB               | Livré            |
| Dupuis Clara   | 14 rue Victor Hugeaux, Bordeaux | CMD004      | 2025-09-02    | Pêche   | 4        | 2,90              | Espèces          | Annulé           |
| Durand Louis   | 2 impasse des Lillas, Nantes    | CMD005      | 2025-09-03    | Jus     | 10       | 3,80              | CB               | Livré            |
| Petit Anne     | 11 rue Centrale, Toulouse       | CMD006      | 2025-09-04    | Banane  | 2        | 2,40              | CB               | En préparation   |
| Garcia Maria   | 30 rue Natioanle, Lille         | CMD007      | 2025-09-05    | Pomme   | 12       | 1,20              | CB               | Livré            |
| Bernard Allain | 7 chemin Vert, Rénnes           | CMD008      | 2025-09-05    | Poire   | 5        | 1,50              | Espèces          | En préparation   |


**Limites d’un tableur**

- **Redondance** : l’adresse client, le mode de paiement, etc. sont répétés à chaque ligne → sources d’erreurs.
- **Difficulté de mise à jour** : si l’adresse de Dupont change, il faut corriger toutes les lignes.
- **Incohérences** : le même client peut apparaître avec des noms différents (Dupont Jean / Dupon J.), des adresses mal orthographiées (Lyon / Lion), ou des données contradictoires.
- **Pas de structure claire** : commandes et produits sont mélangés dans la même table.
- **Pas de clés primaires/étrangères** : impossible d’assurer l’unicité et la cohérence des relations entre clients, commandes et produits.
- **Pas de gestion fine des accès** : si deux personnes modifient le fichier en même temps, les versions peuvent entrer en conflit.
- **Pas de vraie gouvernance** : peu de contrôle sur les droits, les validations, les sauvegardes.


C’est précisément pour dépasser ces limites que l’on utilise des bases de données relationnelles et des Systèmes de Gestion de Bases de Données (SGBD).
---

## Qu’est-ce qu’une base de données ?

Une base de données est une **organisation logique et durable** d’informations. Son objectif est de permettre de **stocker**, **retrouver**, **mettre à jour**, **partager** et **protéger** ces informations à mesure que l’activité grandit. Contrairement à un simple fichier, une base de données impose un **schéma** (quelles colonnes, quels types, quelles règles) et fait respecter des **contraintes** (unicité, non-nullité, domaines de valeurs). Elle supporte l’accès **concurrent** de plusieurs utilisateurs, gère des **volumes croissants** et garantit la **persistance**.

Exemple concret : sur un site e-commerce, l’inscription d’un client enregistre son nom, son e-mail et un mot de passe. Une commande consigne les produits, les quantités, les prix et la date. Lorsqu’il revient, son **historique** est intact. Une base de données relie et sécurise ces informations : une commande ne peut exister sans client valide ; une quantité doit être strictement positive ; un produit supprimé ne peut pas être référencé par une nouvelle ligne.

Repères utiles :
- **Organisation structurée** : colonnes typées plutôt que cellules libres.
- **Règles explicites** : contraintes d’intégrité au plus près des données.
- **Accès concurrent** : lectures/écritures simultanées sans corruption.
- **Scalabilité** : montée en charge sans casser la structure.
- **Durabilité** : les changements validés survivent aux pannes.

---

## Qu’est-ce qu’un SGBD ?

Une base de données ne “tourne” pas seule. Il faut un moteur qui la crée, la maintienne, exécute les requêtes, gère la sécurité, l’optimisation, les journaux et la concurrence. Ce moteur est le **Système de Gestion de Base de Données** (**SGBD**). Il sert d’interface entre les données et leurs utilisateurs (humains ou applications).

Un SGBD sérieux propose :
- **Gestion du stockage** : fichiers, mémoire, caches, journaux de transactions.
- **Sécurité** : authentification, rôles, droits granulaires, chiffrement en transit/au repos.
- **Transactions (ACID)** : « tout ou rien », cohérence et durabilité garanties.
- **Langage d’accès** : en relationnel, **SQL** est le standard.
- **Sauvegardes et restauration** : planifiées et testées.
- **Optimisation** : index, statistiques, plans d’exécution, parallélisme.
- **Disponibilité** : réplication, bascule (failover), supervision.

Exemples : MySQL, PostgreSQL, SQL Server et Oracle pour le relationnel ; MongoDB (documents), Redis (clé-valeur), Neo4j (graphes) côté NoSQL.

---

## Différence entre un SGBD et un SGBDR

**SGBD** est le terme générique pour désigner le moteur. **SGBDR** (Système de Gestion de Base de Données **Relationnelles**) désigne un SGBD qui implémente le **modèle relationnel** : données en tables, clés primaires et étrangères, contraintes, transactions ACID, et **SQL** comme langue commune.

- Un **SGBDR** organise les entités en **tables** reliées par des **clés**, impose des **contraintes** d’intégrité et expose **SQL**.
- Un **SGBD non relationnel** peut stocker des **documents** JSON (flexibles), des **paires clé-valeur** (caches ultra-rapides), des **graphes** (relations profondes), etc. Cela offre de la souplesse, mais confie souvent à l’application la responsabilité de la cohérence.

Conclusion :
- Tous les **SGBDR** sont des **SGBD**, mais tous les **SGBD** ne sont pas relationnels.
- Pour une application métier transactionnelle (ventes, facturation, RH, inventaire, réservations), le **relationnel** reste le **choix par défaut**.

---

## Le modèle relationnel

Le modèle relationnel représente les données sous forme de **tables** (relations). 

Chaque **ligne** (enregistrement) est une instance.

Chaque **colonne** (attribut) est une propriété. 
Chaque table a une **clé primaire** qui identifie de façon unique ses lignes. 
Les **clés étrangères** expriment les **relations** entre tables.


## Le Langage SQL
Le SQL (Structured Query Language) est un langage déclaratif et standardisé qui permet de décrire la structure d’une base relationnelle, de manipuler les données, de les interroger, de gérer les transactions et de contrôler les accès. On distingue cinq volets complémentaires.

### Définir la structure (DDL)
Le **Data Definition Language** sert à créer/faire évoluer tables, contraintes, index, vues et schémas.

```sql
CREATE TABLE client (
  client_id     SERIAL PRIMARY KEY,
  nom           VARCHAR(100) NOT NULL,
  email         VARCHAR(255) UNIQUE NOT NULL,
  pays          VARCHAR(50),
  date_creation TIMESTAMP NOT NULL DEFAULT now()
);
```

### Manipuler les données (DML)
Le **Data Manipulation Language** couvre l’insertion, la mise à jour et la suppression.
```sql
INSERT INTO client (nom, email, pays)
VALUES ('Alice Dupont', 'alice@example.com', 'FR');

UPDATE client
SET pays = 'BE'
WHERE email = 'alice@example.com';

DELETE FROM client
WHERE client_id = 999;
```

### Interroger l’information (DQL)
Le **Data Query Language** s’articule autour de SELECT. On filtre, on joint, on agrège, on ordonne, on regroupe. Exemple : top des produits du mois courant.
```sql
SELECT p.produit_id, p.libelle, SUM(lc.qte) AS qte_vendue
FROM ligne_commande lc
JOIN commande c ON c.commande_id = lc.commande_id
JOIN produit  p ON p.produit_id  = lc.produit_id
WHERE date_trunc('month', c.date_cmd) = date_trunc('month', CURRENT_DATE)
GROUP BY p.produit_id, p.libelle
ORDER BY qte_vendue DESC
LIMIT 5;
```



