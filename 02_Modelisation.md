# De la modélisation à la conception d’une base de données

## Introduction
Créer une base de données ne se limite pas à « stocker des informations ». C’est un travail de conception, comparable à la construction d’une maison : avant de poser les briques, il faut dessiner des plans. Ces plans assurent que la maison sera solide, adaptée aux besoins, et évolutive.  

En informatique, ces plans correspondent à la **modélisation**. Ils décrivent les informations à gérer et leurs relations avant d’écrire la moindre ligne de code SQL.  

En France, une méthode a largement structuré cette démarche : la méthodologie **Merise** . Elle sépare données et traitements, et s’appuie sur trois niveaux :  
- **Conceptuel (MCD – modèle conceptuel de données)** : représentation indépendante de la technique.  
- **Logique (MLD – modèle logique des données)** : traduction vers le modèle relationnel.  
- **Physique (MPD – modèle physique des données)** : passage au SQL concret.  

Nous allons suivre tout au long du cours un exemple fil rouge : un **Le Festival Jazz de la Villette**.

---

## Les règles de gestion métier
Avant de se lancer dans la création d’un modèle conceptuel de données (MCD), il faut d’abord comprendre le **besoin métier**.  
Ces besoins sont formalisés sous forme de **règles de gestion**, qui décrivent quelles informations doivent être stockées et comment elles s’articulent entre elles.  

Ces règles peuvent être :  
- fournies par les futurs utilisateurs,  
- ou établies par le concepteur lui-même après des entretiens, des observations et une analyse du domaine.  

En tant que développeur ou concepteur, il est essentiel de savoir poser les bonnes questions :  
- Quelles informations doivent être mémorisées ?  
- Quels objets doivent être reliés entre eux ?  
- Quelles contraintes particulières faut-il respecter ?  


**Exemple du Festival**
- Un **festivalier** peut assister à plusieurs **concerts**, et chaque **concert** peut accueillir plusieurs **festivaliers**.  
- Un **concert** se déroule obligatoirement sur une seule **scène**, et chaque **scène** peut accueillir plusieurs **concerts**.  
- Un **artiste** peut jouer dans plusieurs **concerts**, et chaque **concert** peut accueillir plusieurs **artistes**.  
- Un **membre du personnel** peut travailler sur plusieurs **concerts**, et chaque **concert** mobilise plusieurs **personnels**.  
- Chaque **concert** possède une **date** et une **heure de début** qui doivent être uniques pour ce **concert**.  
- Un **festivalier** est identifié par son **nom**, **prénom** et **adresse e-mail**.  
- Un **artiste** est identifié par son **nom**, son **style musical** et son **pays**.  
- Un **membre du personnel** est identifié par son **nom**, **prénom** et **fonction**.  


---

## Le modèle conceptuel de données (MCD)
Le **MCD** est la première étape de la modélisation. Son but est de représenter le domaine d’étude sous une forme conceptuelle, c’est-à-dire sans se soucier des contraintes techniques. On cherche avant tout à décrire les objets du monde réel que l’on veut gérer et les relations qu’ils entretiennent entre eux.  

Deux notions sont fondamentales dans un MCD : les **entités** et les **associations**.

### Les entités
Une entité est un ensemble homogène d’objets du monde réel. Chaque objet de cet ensemble est appelé une **occurrence** de l’entité.  

Dans notre festival, on identifie les entités suivantes :  
- **Artistes** : chaque musicien ou groupe programmé au festival. Attributs : nom, style musical, pays d’origine.  
- **Scènes** : lieux physiques où se déroulent les concerts. Attributs : nom, capacité d’accueil.  
- **Concerts** : chaque événement programmé (un ou plusieurs artistes sur une scène à un horaire donné). Attributs : date, heure de début.  
- **Festivaliers** : spectateurs assistant au festival. Attributs : nom, prénom, adresse e-mail, numéro de pass.  
- **Personnel** : personnes travaillant pour l’organisation (techniciens, bénévoles, agents de sécurité). Attributs : nom, fonction.  

![Exemple Table](figures/mcd_tables_only.png)

Chaque entité doit être identifiée de manière unique grâce à un **identifiant**. Dans la plupart des cas, on utilise un entier auto-incrémenté, qui sera la clé primaire dans le modèle relationnel.

---

### Les associations
Une **association** établit un lien sémantique entre deux ou plusieurs entités. Elle se nomme généralement avec un verbe, à la forme active (jouer, assister, travailler) ou à la forme passive (être programmé sur).  
Une association peut, si nécessaire, posséder ses propres attributs, qui décrivent spécifiquement la relation.  

Dans notre festival, on peut identifier les associations suivantes :  
- **Programmer (Concerts ↔ Scènes)** : un concert est programmé sur une scène.  
- **Jouer (Artistes ↔ Concerts)** : un artiste joue lors d’un concert. Attributs possibles : ordre de passage, durée prévue.  
- **Assister à (Festivaliers ↔ Concerts)** : un festivalier assiste à un concert. Attributs possibles : type de billet, date d’achat.  
- **Travailler sur (Personnel ↔ Concerts)** : un membre du personnel travaille sur un concert. Attributs possibles : rôle, horaire de prise de poste.  

![Exemple Associations](figures\mcd_associations_only.png)

---

### Les cardinalités
Les **cardinalités** précisent combien de fois une occurrence d’une entité peut participer à une association. Elles se notent sous la forme (min, max).  

Dans le festival :  
- **Programmer** : Un concert est programmé sur une et une seule scène (cardinalité (1,1) côté Concerts) et une scène peut accueillir un ou plusieurs concerts (cardinalité (0,N) côté Scènes).
- **Jouer** : Un artiste peut jouer dans un ou plusieurs concerts (1,N) et un concert accueille un ou plusieurs artistes (1,N)  
- **Assister à** : Un festivalier peut assister à un ou plusieurs concerts (1,N) et un concert peut accueillir zéro, un ou plusieurs festivaliers (0,N).
- **Travailler sur** : Un membre du personnel peut travailler sur zéro, un ou plusieurs concerts (0,N) et un concert mobilise au moins une personne, mais souvent plusieurs (1,N).
 
![Exemple Cardinalités](figures\mcd_cardinalités.png)

Les cardinalités traduisent directement les règles métier. Elles doivent être discutées et validées avec les utilisateurs du système.  

---

### Cas particuliers

#### Association réflexive
Une **association réflexive** relie une entité à elle-même : les occurrences de la même entité entretiennent entre elles un lien spécifique.  
Exemple dans le festival : l’entité **Personnel** reliée à elle-même par l’association **Superviser**.  
- Un membre du personnel peut superviser 0, 1 ou plusieurs autres membres (0,N).  
- Un membre du personnel peut être supervisé par au maximum un seul autre membre (0,1).  

Cela permet de représenter une hiérarchie interne : un chef de sécurité supervise plusieurs agents, mais chaque agent n’a qu’un seul supérieur direct.  

![Exemple asso reflexive](figures\mcd_asso_reflexive_personnels.png)

---

#### Association plurielle
Les **associations plurielles** apparaissent lorsqu’une même paire d’entités est reliée par plusieurs associations distinctes, chacune traduisant un rôle différent.  

Exemple classique : une **agence immobilière**. Les entités **Personnes** et **Logements** sont reliées par trois associations :  
- **Posséder** : une personne peut posséder 0, 1 ou plusieurs logements, tandis qu’un logement appartient toujours à une seule personne.  
- **Résider principalement** : une personne peut avoir au maximum un logement principal, tandis qu’un logement peut être la résidence principale de 0, 1 ou plusieurs personnes.  
- **Résider secondairement** : une personne peut disposer de plusieurs résidences secondaires, et un logement peut être utilisé comme résidence secondaire par plusieurs personnes.  

![Exemple asso plurielle](figures\mcd_asso_plurielles.png)

---

### Exercice – Salle de sport

Les propriétaires d’une salle de sport souhaitent mieux gérer leurs activités quotidiennes : organisation des cours, gestion des coachs, suivi des membres et de leurs présences.
Ils font donc appel à vous, en tant que consultants en modélisation de bases de données, pour concevoir le modèle conceptuel de données (MCD) de leur futur système d’information.

**Règles de gestion métier fournies**
- Une salle de sport propose plusieurs cours collectifs comme le yoga, le pilates, le crossfit ou encore des cours de self défense.  
- Chaque Créneau d’un cours se déroule dans un espace dédié (salle de yoga, salle de musculation, espace extérieur, zone de tatami).  
- Les créneaux d’un cours sont encadrés par des coach sportifs. On souhaite mémoriser leur nom, prénom et leur date d’arrivée dans le club.  
- Les membres assistent aux créneaux d’un cours. Pour chaque membre, on enregistre : numéro d’adhésion, nom, prénom, adresse e-mail, date d’enregistrement et formule choisie (abonnement mensuel, annuel, cours individuels uniquement).  
- Chaque cours est planifié sur un ou plusieurs créneaux horaires (date, heure de début, durée).  
On aimerait pouvoir savoir qui a participé réellement à un créneau (présence effective), ce qui peut différer des inscriptions prévues.

**Règle de gestion supplémentaires**
- Chaque créneau a lieu dans un seul espace, mais un espace peut accueillir plusieurs créneaux.
- Un créneau doit être encadré par au moins un coach, et peut être encadré par plusieurs coachs en même temps.
- Un cours peut être planifié sur plusieurs créneaux, mais chaque créneau correspond à un seul cours.
- Un coach peut encadrer plusieurs créneaux, mais peut aussi exister dans la base sans encadrer de cours (coach nouvellement recruté).
- Un cours peut être planifié sur plusieurs créneaux, mais chaque créneau correspond à un seul cours.
- Un membre peut s’inscrire à plusieurs créneaux, et un créneau peut accueillir plusieurs membres.
- Un créneau peut exister même sans inscriptions


**Consignes de l'exercices**
- Identifiez les **entités** principales, leurs attributs et leurs identifiants
- Identifiez les **associations** nécessaires à la gestion de ce système
- Identifiez les **cardinalités** pour chaque association
- Réalisez le **MCD** complet


---

## Le modèle Logique de données (MLD)
Le **MCD** permet de représenter les informations du monde réel (entités, attributs, associations) sans se soucier des contraintes techniques.  

Mais pour utiliser un système de gestion de base de données relationnelle (PostgreSQL, MySQL, Oracle…), il faut traduire ce MCD en structures compréhensibles par le SGBD.  
C’est le rôle du **MLD (modèle logique des données)**.  

Le MLD a deux grandes missions :  
1. **Transformer** les entités et associations en **tables relationnelles**.  
2. **Préparer** le passage vers le SQL concret (MPD), en réfléchissant déjà aux **types de données** et aux **contraintes**.  

---

### Du MCD au MLD


#### Conversion d'une entité
Chaque **entité** identifiée dans le MCD se traduit en **table**.  
- Les attributs deviennent des **colonnes**.  
- L’identifiant devient la **clé primaire (PK)**.  

Exemple avec l’entité **artistes** :  
- artistes(<u>id_artiste</u>, nom_artiste, style_musical, pays)

- `id_art` est la clé primaire (identifiant unique de l’artiste).  
- `nom_art`, `style`, `pays` sont de simples attributs.  


---

#### Conversion d'associations 0/1,1 - 0/1,N
Lorsqu’une association relie deux entités avec une cardinalité max 1 d'un côté ((0,1) ou (1,1)) et N de l'autre ((0,N) ou (1,N)), au profit d'une **clé étrangère** dans la table côté 0,1 ou 1,1 qui référence la **clé primaire** de l'autre table.
Cette clé étrangère ne peut pas recevoir la valeur vide si la cardinalité est 1,1.

Exemple : association **Programmer (Concerts ↔ Scènes)**  
- Un concert est programmé sur une seule scène (1,1).  
- Une scène peut accueillir plusieurs concerts (0,N).  

On obtient :  
- scenes(<u>id_concert</u>, nom, capacite_accueil)
- concerts(<u>id_concert</u>, date, heure_debut, #id_scene)

---

#### Conversion d'associations 0/1,N
Lorsqu’une association relie deux entités avec des cardinalités (0,N) ou (1,N) de part et d'autre, elle devient une nouvelle **table**.  

- La **clé primaire** de cette table est la concaténation des **clés primaires** respectives des deux entités.  
- Dans le cas d'associations porteuses de données, les données portées deviennent des attributs de la relation correspondante  

Exemple : association **Jouer (Artistes ↔ Concerts)**  
- Un artiste peut jouer dans plusieurs concerts.  
- Un concert accueille plusieurs artistes.

On crée :  
jouer(<u>#id_artiste</u>, <u>#id_concert</u>, ordre_passage, duree_prevue)


- La clé primaire est `(id_artiste, id_concert)`.  
- On ajoute deux attributs propres à l’association : `ordre_passage` et `duree_prevue`.  

---

#### Conversion d'associations 1,1
Lorsqu'une association relie deux entités avec des cardinalités (0/1,1), on peut la traiter de deux façons :
- Soit on la traite comme une associations de relations avec les cardinalités (0/1,1) - (0/1,N) en **remplacant l'association par une clé étrangère**. La clé étrangère se voit cependant imposer une contrainte d'unicité.
- Soit on la traite comme une associations de relations avec les cardinalités (0/1,N) en **créant une table contenant les deux clés primaires**


Exemple : l'association *diriger** ci-dessous

Selon la première option, on obtient :
- services(<u>id_service</u>, nom_service, #numéro employé)
- employes(<u>id_employe</u>, nom)

Selon la seconde option, on obtient :
- services(<u>id_service</u>, nom_service)
- employes(<u>id_employe</u>, nom)
- diriger(<u>#id_service</u>, <u>#id_employe</u>)

### Les types de données et leur importance

#### Pourquoi les types sont-ils essentiels ?
Le choix des types de données pour chaque colonne est une étape **cruciale** de la conception.  

Bien choisir ses types permet de :  
- **Assurer la cohérence** des données (un numéro de pass n’est pas un nombre mais une chaîne de caractères).  
- **Optimiser l’espace mémoire** (inutile de stocker un code postal en `BIGINT`).  
- **Améliorer les performances** (un `DATE` se compare plus vite qu’un texte qui contient une date).  
- **Renforcer la fiabilité** (empêcher l’insertion de valeurs absurdes comme « abc » dans une colonne numérique).  


---

#### Les grandes familles de types

### 1. Numériques
- **INT / INTEGER** : nombres entiers standards.  
- **SMALLINT / BIGINT** : plus petit ou plus grand que `INT`.  
- **DECIMAL(p,s) / NUMERIC(p,s)** : nombres décimaux exacts (utile pour les prix, notes, pourcentages).  
- **FLOAT / REAL / DOUBLE PRECISION** : nombres à virgule flottante (utile pour les mesures scientifiques, moins précis).  

👉 Exemple Festival :  
- `capacite` (SCENE) → `INT`  
- `duree` (JOUER) → `INT` (minutes)  

---

### 2. Textuels
- **CHAR(n)** : texte fixe (utile pour des codes pays comme « FR »).  
- **VARCHAR(n)** : texte variable (noms, prénoms, e-mails).  
- **TEXT** : texte long (descriptions, commentaires).  

👉 Exemple Festival :  
- `nom_scene` (SCENE) → `VARCHAR(100)`  
- `style` (ARTISTE) → `VARCHAR(50)`  

---

### 3. Temporels
- **DATE** : une date (AAAA-MM-JJ).  
- **TIME** : une heure (HH:MM:SS).  
- **TIMESTAMP** : date + heure combinées.  
- **INTERVAL** : durée.  

👉 Exemple Festival :  
- `date_conc` (CONCERT) → `DATE`  
- `heure_debut` (CONCERT) → `TIME`  

---

### 4. Booléens
- **BOOLEAN** : vrai ou faux.  

👉 Exemple Festival :  
- `gratuit` (CONCERT) → `BOOLEAN`  

---

### 5. Types spécialisés (selon les SGBD)
- **UUID** : identifiant unique universel.  
- **JSON / JSONB** (PostgreSQL) : données semi-structurées.  
- **GEOMETRY / GEOGRAPHY** (PostGIS) : données spatiales.  
- **ARRAY** : tableau de valeurs.  

Ces types sont plus avancés et souvent utilisés dans des contextes modernes (applications web, géospatial, big data).

---

## Contraintes associées aux types
Au-delà du type, on peut ajouter des **contraintes** :  
- **NOT NULL** : valeur obligatoire.  
- **DEFAULT** : valeur par défaut si rien n’est saisi.  
- **CHECK** : règle de validation (ex. `capacite > 0`).  
- **UNIQUE** : empêche les doublons.  

👉 Exemple Festival :  
- `email` (FESTIVALIER) doit être **UNIQUE**.  
- `capacite` (SCENE) doit être **CHECK (capacite > 0)**.  

---

## Exemple enrichi – MLD du Festival avec types

- **ARTISTE(id_art INT, nom_art VARCHAR(100), style VARCHAR(50), pays VARCHAR(50))**  
- **SCENE(id_scene INT, nom_scene VARCHAR(100), capacite INT CHECK (capacite > 0))**  
- **CONCERT(id_conc INT, date_conc DATE, heure_debut TIME, id_scene INT)**  
- **FESTIVALIER(id_fest INT, nom_fest VARCHAR(100), prenom_fest VARCHAR(100), email VARCHAR(150) UNIQUE, num_pass VARCHAR(50))**  
- **JOUER(id_art INT, id_conc INT, ordre_passage INT, duree INT)**  

---

## Récapitulatif
- Le **MLD** transforme le MCD en tables relationnelles (entités → tables, associations 1–N → clés étrangères, associations N–N → tables de jointure).  
- Les **types de données** garantissent la qualité, la performance et la robustesse de la base.  
- Les **contraintes** complètent les types pour assurer l’intégrité.  

Cette étape prépare le passage vers le **MPD (modèle physique des données)** et la création effective des tables en SQL.



