# Introduction aux bases de données et aux SGBD
## Les tableurs

Beaucoup d’organisations commencent avec un tableur. C’est intuitif : on saisit des données, on fait des calculs, on trie, on filtre, on partage un fichier. Pour de petites tâches ou des analyses ponctuelles, c'est très efficace.

Mais dès que les données deviennent nombreuses, partagées ou évolutives, les limites apparaissent vite.

![Exemple de tableur avec erreurs](figures/exemple_excel.png)


#### Limites d’un tableur

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

Une base de données est une **organisation logique et durable** d’informations. 
Son objectif est de permettre de **stocker**, **retrouver**, **mettre à jour**, **partager** et **protéger** ces informations à mesure que l’activité grandit. 
Contrairement à un simple fichier, une base de données impose un **schéma** (quelles colonnes, quels types de données, quelles règles) et fait respecter des **contraintes** (unicité, non-nullité, domaines de valeurs). 
Elle supporte l’accès **concurrent** de plusieurs utilisateurs, gère des **volumes croissants** et garantit la **persistance**.


---

## Bases de données relationnelles (SQL)

Les bases de données relationnelles sont parmi les plus utilisées. 
Le modèle relationnel représente les données sous forme de **tables** (relations). 

Chaque **ligne** (enregistrement) est une instance.

Chaque **colonne** (attribut) est une propriété. 

Chaque table a une **clé primaire** qui identifie de façon unique ses lignes. 

Les **clés étrangères** expriment les **relations** entre tables.

---

## Qu’est-ce qu’un SGBD ?

Une base de données ne “tourne” pas seule. Il faut un moteur qui la crée, la maintienne, exécute les requêtes, gère la sécurité, l’optimisation, les journaux et la concurrence. Ce moteur est le **Système de Gestion de Base de Données** (**SGBD**). Il sert d’interface entre les données et leurs utilisateurs (humains ou applications).


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


## Le Langage SQL
Le SQL (Structured Query Language) est un langage déclaratif et standardisé qui permet de décrire la structure d’une base relationnelle, de manipuler les données, de les interroger, de gérer les transactions et de contrôler les accès. 

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



