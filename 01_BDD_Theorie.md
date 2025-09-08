# Introduction aux bases de données et aux SGBD
## Les tableurs

Beaucoup d’organisations commencent avec un tableur parce qu’il est immédiat : on saisit, on calcule, on filtre, on partage. Mais au-delà des premiers usages, les limites apparaissent vite. 

| Nom client    | Adresse client                | N° commande | Date commande | Produit           | Quantité | Prix unitaire (€) | Mode de paiement | Statut livraison | Commercial référent |
| ------------- | ----------------------------- | ----------- | ------------- | ----------------- | -------- | ----------------- | ---------------- | ---------------- | ------------------- |
| Dupont Jean   | 12 rue de Paris, Lyon         | CMD001      | 2025-09-01    | Pomme Golden      | 10       | 1,20              | CB               | Livré            | Alice Martin        |
| Dupont Jean   | 12 rue de Paris, Lyon         | CMD001      | 2025-09-01    | Poire Conférence  | 5        | 1,50              | CB               | Livré            | Alice Martin        |
| Dupont Jean   | 12 rue de Paris, Lyon         | CMD001      | 2025-09-01    | Jus de pomme (1L) | 2        | 3,80              | CB               | Livré            | Alice Martin        |
| Martin Sophie | 4 place Bellecour, Lyon       | CMD002      | 2025-09-01    | Poire Conférence  | 20       | 1,50              | Virement         | En préparation   | Alice Martin        |
| Martin Sophie | 4 place Bellecour, Lyon       | CMD002      | 2025-09-01    | Banane (kg)       | 3        | 2,40              | Virement         | En préparation   | Alice Martin        |
| Nguyen Paul   | 85 av. Jean Jaurès, Marseille | CMD003      | 2025-09-02    | Pomme Golden      | 15       | 1,20              | CB               | Livré            | Karim Bensalem      |
| Dupuis Clara  | 14 rue Victor Hugo, Bordeaux  | CMD004      | 2025-09-02    | Pêche (kg)        | 4        | 2,90              | Espèces          | Annulé           | Karim Bensalem      |
| Dupuis Clara  | 14 rue Victor Hugo, Bordeaux  | CMD005      | 2025-09-03    | Pêche (kg)        | 2        | 2,90              | Espèces          | Livré            | Karim Bensalem      |
| Durand Louis  | 2 impasse des Lilas, Nantes   | CMD006      | 2025-09-04    | Jus de pomme (1L) | 10       | 3,80              | CB               | Livré            | Alice Martin        |
| Durand Louis  | 2 impasse des Lilas, Nantes   | CMD006      | 2025-09-04    | Pomme Golden      | 5        | 1,20              | CB               | Livré            | Alice Martin        |
| Petit Anne    | 11 rue Centrale, Toulouse     | CMD007      | 2025-09-04    | Poire Conférence  | 10       | 1,50              | CB               | En préparation   | Karim Bensalem      |
| Petit Anne    | 11 rue Centrale, Toulouse     | CMD007      | 2025-09-04    | Banane (kg)       | 2        | 2,40              | CB               | En préparation   | Karim Bensalem      |
| Petit Anne    | 11 rue Centrale, Toulouse     | CMD008      | 2025-09-05    | Poire Conférence  | 8        | 1,50              | CB               | Livré            | Karim Bensalem      |
| Garcia Maria  | 30 rue Nationale, Lille       | CMD009      | 2025-09-05    | Pomme Golden      | 12       | 1,20              | CB               | Livré            | Alice Martin        |
| Garcia Maria  | 30 rue Nationale, Lille       | CMD009      | 2025-09-05    | Jus de pomme (1L) | 6        | 3,80              | CB               | Livré            | Alice Martin        |
| Bernard Alain | 7 chemin Vert, Rennes         | CMD010      | 2025-09-05    | Pêche (kg)        | 5        | 2,90              | Espèces          | En préparation   | Karim Bensalem      |
| Bernard Alain | 7 chemin Vert, Rennes         | CMD010      | 2025-09-05    | Poire Conférence  | 5        | 1,50              | Espèces          | En préparation   | Karim Bensalem      |
| Laurent Julie | 50 av. République, Lyon       | CMD011      | 2025-09-06    | Banane (kg)       | 1        | 2,40              | Virement         | Livré            | Alice Martin        |
| Laurent Julie | 50 av. République, Lyon       | CMD011      | 2025-09-06    | Pomme Golden      | 3        | 1,20              | Virement         | Livré            | Alice Martin        |
| Laurent Julie | 50 av. République, Lyon       | CMD012      | 2025-09-07    | Jus de pomme (1L) | 12       | 3,80              | Virement         | En préparation   | Alice Martin        |


Redondance : l’adresse client, le nom du commercial, le mode de paiement sont répétés pour chaque ligne → source d’erreur.

Difficulté de mise à jour : si le client change d’adresse, il faut modifier toutes les lignes correspondantes.

Incohérences possibles : un même client peut avoir une commande notée "Annulé" et une autre "Livré" → pas de gestion de contrainte d’intégrité.

Produits mélangés dans la même table : pas de séparation entre "commandes" et "lignes de commande".

Pas de clés primaires/étrangères : impossible de relier proprement les entités clients, commandes, produits.

👉 Dans une base relationnelle, on aurait au moins 3 tables normalisées :

- Clients(id, nom, adresse, commercial_id)
- Commandes(id, client_id, date, paiement, statut)
- LignesCommande(id, commande_id, produit_id, quantite, prix)


- ne gère pas bien les accès simultanés
- ne fournit pas de vraie gouvernance (contrôles, droits fins, sauvegardes éprouvées).


Quelques vérités utiles à retenir :
- Excel est pertinent pour **explorer rapidement** et **présenter** des résultats.
- Excel devient risqué dès qu’il sert de **source de vérité partagée**, avec des **données liées** et **évolutives**.
- Les incohérences, la duplication et l’absence de contrôles finissent par coûter cher.

C’est précisément pour répondre à ces limites qu’existent les bases de données et les SGBD.

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



