# Devoir maison
## Objectif du devoir
Vous devez réaliser, à partir d’un **exemple concret** (tiré de votre travail, de votre alternance, de votre stage, ou d’un autre contexte professionnel ou personnel de votre choix), une démarche complète de **modélisation et mise en œuvre d’une base de données**.  

Ce devoir a pour but de vérifier votre capacité à :  
- recueillir les règles de gestion d’un métier,  
- les traduire dans un **modèle conceptuel de données (MCD)**,  
- transformer ce modèle en **modèle logique de données (MLD)**,  
- produire le **modèle physique de données (MPD)**,  
- et enfin écrire les requêtes **SQL de création des tables**.  

À chaque étape, vous devez **justifier vos choix** de manière claire et argumentée.  

---

## Étapes attendues

### 1. Règles de gestion du métier
- Identifiez et énumérez les **règles de gestion** propres au contexte choisi.  
- Formulez-les de manière claire et précise (ex. *« Un client peut passer plusieurs commandes »*).  
- Ces règles serviront de base à la modélisation.  

**Livrable attendu :** une liste des règles de gestion.  

---

### 2. Modèle Conceptuel de Données (MCD)
- Construisez le schéma entités-associations correspondant aux règles.  
- Indiquez les **entités**, leurs **attributs** principaux et les **associations**.  
- Définissez les **cardinalités** (min et max) pour chaque association.  
- Expliquez vos choix de cardinalités.  

**Livrable attendu :** le schéma du MCD accompagné d’un texte justifiant vos choix.  

---

### 3. Modèle Logique de Données (MLD)
- Transformez votre MCD en MLD relationnel.  
- Indiquez les **tables** créées, les **attributs** retenus, et les **clés primaires** et **clés étrangères**.  
- Justifiez vos choix lors de la transformation (par exemple : *« L’association X a été transformée en table car… »* ou *« L’association Y est représentée par une clé étrangère car… »*).  

**Livrable attendu :** le schéma du MLD et une explication des choix de transformation.  

---

### 4. Modèle Physique de Données (MPD)
- Déclinez le MLD dans un modèle physique adapté à PostgreSQL.  
- Indiquez le **type des colonnes**, les **contraintes**, et la **gestion des clés primaires/étrangères**.  
- Justifiez le choix des types et contraintes.  

**Livrable attendu :** Schéma du MPD et description du MPD (table par table, colonnes et contraintes) + justification.  

---

### 5. Requêtes SQL – Création des tables
- Écrivez les requêtes SQL `CREATE TABLE` correspondant au MPD.  
- Les tables doivent inclure :  
  - les **clés primaires** et **étrangères**,  
  - les **contraintes** de type (NOT NULL, CHECK, UNIQUE, DEFAULT…).  

**Livrable attendu :** script SQL complet de création des tables.  

---

## Format attendu du devoir
- Document clair, structuré, avec titres et sous-titres correspondant aux étapes ci-dessus.  
- Les schémas (MCD, MLD, MPD) peuvent être réalisés avec un logiciel (draw.io, Lucidchart, etc.) ou dessinés à la main puis scannés.  
- Chaque étape doit contenir à la fois la **production attendue** (liste, schéma, script) et une **explication de vos choix**.  

---

## Critères d’évaluation
A définir  

---

## Informations pratiques
- **Date limite de remise :** Lundi 13 Octobre
- **Format :** PDF (texte et schémas intégrés) + fichier SQL à envoyer à fabien.pageot@gmail.com. Les noms de fichier doivent contenir votre nom et prénom.
- **Exemple de rendu** : 
  - [devoir_maison_exemple_fabien_pageot.pdf]({{ '/documents/devoir_maison_exemple_fabien_pageot.pdf' | relative_url }}) 
  - [devoir_maison_exemple_fabien_pageot.sql]({{ '/documents/devoir_maison_exemple_fabien_pageot.sql' | relative_url }}) 