CREATE TABLE artistes (
    id_artiste SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    style_musical VARCHAR(50),
    pays VARCHAR(50)
);

CREATE TABLE scenes (
    id_scene SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    capacite_accueil INTEGER CHECK (capacite_accueil > 0)
);

CREATE TABLE concerts (
    id_concert SERIAL PRIMARY KEY,
    date_concert DATE NOT NULL,
    heure_debut TIME NOT NULL,
    id_scene INT NOT NULL REFERENCES scenes(id_scene)
);

CREATE TABLE festivaliers (
    id_festivalier SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    adresse_email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE personnels (
    id_personnel SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    fonction VARCHAR(50),
    id_superviseur INT REFERENCES personnels(id_personnel)
);

CREATE TABLE participations (
    id_artiste INT REFERENCES artistes(id_artiste),
    id_concert INT REFERENCES concerts(id_concert),
    ordre_passage INT,
    duree_prevue INTERVAL,
    PRIMARY KEY (id_artiste, id_concert)
);

CREATE TABLE inscriptions (
    id_festivalier INT REFERENCES festivaliers(id_festivalier),
    id_concert INT REFERENCES concerts(id_concert),
    type_billet VARCHAR(50),
    date_achat DATE,
    PRIMARY KEY (id_festivalier, id_concert)
);

CREATE TABLE assignations (
    id_concert INT REFERENCES concerts(id_concert),
    id_personnel INT REFERENCES personnels(id_personnel),
    horaire TIME,
    role VARCHAR(50),
    PRIMARY KEY (id_concert, id_personnel)
);