### Installation de la base dvdrental sur PostgreSQL avec DBeaver

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
2. Dans Input selectionner le fichier `dvdrental.tar`
3. Cliquez sur **Suivant**
4. Cliquez sur **Démarrage**  
   → Les tables, vues et données seront automatiquement créées.