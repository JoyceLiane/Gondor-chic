-- =====================================================
-- PROJET MAGIC VENTES STOCK
-- MYSQL VERSION
-- MODELE + SCRIPTS + DONNEES DE TEST
-- =====================================================

-- =====================================================
-- SAFETY: RESET DATABASE
-- =====================================================

DROP DATABASE IF EXISTS MagicVentesStock;

CREATE DATABASE MagicVentesStock;
USE MagicVentesStock;

-- =====================================================
-- CLIENTS
-- =====================================================

CREATE TABLE Client
(
    IdClient INT AUTO_INCREMENT PRIMARY KEY,
    Prenom VARCHAR(50) NOT NULL,
    Nom VARCHAR(50) NOT NULL,
    Pseudo VARCHAR(50) NOT NULL UNIQUE,
    MotDePasse VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NULL
);

-- =====================================================
-- PRODUITS
-- =====================================================

CREATE TABLE Produit
(
    ReferenceProduit VARCHAR(20) PRIMARY KEY,
    Libelle VARCHAR(100) NOT NULL,
    Prix DECIMAL(10,2) NOT NULL,
    QuantiteStock INT NOT NULL,
    EstDuJour BOOLEAN NOT NULL DEFAULT FALSE,
    ImageUrl VARCHAR(255) NULL
);

-- =====================================================
-- FOURNISSEURS
-- =====================================================

CREATE TABLE Fournisseur
(
    IdFournisseur INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(100) NOT NULL,
    Automatique BOOLEAN NOT NULL
);

-- =====================================================
-- COMMANDES
-- =====================================================

CREATE TABLE Commande
(
    IdCommande INT AUTO_INCREMENT PRIMARY KEY,
    IdClient INT NOT NULL,
    DateCommande DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Statut VARCHAR(30) NOT NULL,
    ModePaiement VARCHAR(20) NOT NULL,
    MontantTotal DECIMAL(12,2) NOT NULL DEFAULT 0,

    FOREIGN KEY (IdClient)
        REFERENCES Client(IdClient)
);

-- =====================================================
-- LIGNES COMMANDE
-- =====================================================

CREATE TABLE LigneCommande
(
    IdLigne INT AUTO_INCREMENT PRIMARY KEY,
    IdCommande INT NOT NULL,
    ReferenceProduit VARCHAR(20) NOT NULL,
    Quantite INT NOT NULL,
    PrixUnitaire DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (IdCommande)
        REFERENCES Commande(IdCommande),

    FOREIGN KEY (ReferenceProduit)
        REFERENCES Produit(ReferenceProduit)
);

-- =====================================================
-- PAIEMENTS
-- =====================================================

CREATE TABLE Paiement
(
    IdPaiement INT AUTO_INCREMENT PRIMARY KEY,
    IdCommande INT NOT NULL,
    DatePaiement DATETIME NULL,
    Montant DECIMAL(12,2) NOT NULL,
    TypePaiement VARCHAR(20) NOT NULL,
    Statut VARCHAR(30) NOT NULL,

    FOREIGN KEY (IdCommande)
        REFERENCES Commande(IdCommande)
);

-- =====================================================
-- LIVRAISONS
-- =====================================================

CREATE TABLE Livraison
(
    IdLivraison INT AUTO_INCREMENT PRIMARY KEY,
    IdCommande INT NOT NULL,
    DateExpedition DATETIME NULL,
    Statut VARCHAR(30) NOT NULL,

    FOREIGN KEY (IdCommande)
        REFERENCES Commande(IdCommande)
);

-- =====================================================
-- COMMANDES FOURNISSEURS
-- =====================================================

CREATE TABLE CommandeFournisseur
(
    IdCommandeFournisseur INT AUTO_INCREMENT PRIMARY KEY,
    IdFournisseur INT NOT NULL,
    DateCommande DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Statut VARCHAR(30) NOT NULL,

    FOREIGN KEY (IdFournisseur)
        REFERENCES Fournisseur(IdFournisseur)
);

-- =====================================================
-- LIGNES COMMANDES FOURNISSEURS
-- =====================================================

CREATE TABLE LigneCommandeFournisseur
(
    IdLigneCF INT AUTO_INCREMENT PRIMARY KEY,
    IdCommandeFournisseur INT NOT NULL,
    ReferenceProduit VARCHAR(20) NOT NULL,
    Quantite INT NOT NULL,

    FOREIGN KEY (IdCommandeFournisseur)
        REFERENCES CommandeFournisseur(IdCommandeFournisseur),

    FOREIGN KEY (ReferenceProduit)
        REFERENCES Produit(ReferenceProduit)
);

-- =====================================================
-- DONNEES DE TEST
-- =====================================================

-- CLIENTS
INSERT INTO Client (Prenom, Nom, Pseudo, MotDePasse, Email)
VALUES
('Frodon','Sacquet','Leporteur','!totoXXS','frodon@gondor.com'),
('Sam','Gamegie','Lebrave','titiXXL','sam@gondor.com'),
('Pippin','Touque','Lefestif','!nainXXL','pippin@gondor.com');

-- PRODUITS
INSERT INTO Produit (ReferenceProduit, Libelle, Prix, QuantiteStock, EstDuJour, ImageUrl)
VALUES
('P001','Chaudron magique',250,678,0,'chaudron.jpg'),
('P002','Cape magique',180,120,0,'cape.jpg'),
('P003','Coffret de bijoux de Fondcombe',60,15,1,'fondcombe.jpg');

-- FOURNISSEURS
INSERT INTO Fournisseur (Nom, Automatique)
VALUES
('Forge de Fondcombe',1),
('Atelier des Elfes',0);

-- COMMANDES
INSERT INTO Commande (IdClient, Statut, ModePaiement, MontantTotal)
VALUES
(1,'CONFIRMEE','CB',310),
(2,'EN_ATTENTE','CHEQUE',180);

-- LIGNES COMMANDE
INSERT INTO LigneCommande (IdCommande, ReferenceProduit, Quantite, PrixUnitaire)
VALUES
(1,'P001',1,250),
(1,'P003',1,60),
(2,'P002',1,180);

-- PAIEMENTS
INSERT INTO Paiement (IdCommande, DatePaiement, Montant, TypePaiement, Statut)
VALUES
(1,NOW(),310,'CB','VALIDE'),
(2,NULL,180,'CHEQUE','EN_ATTENTE');

-- LIVRAISON
INSERT INTO Livraison (IdCommande, DateExpedition, Statut)
VALUES
(1,NOW(),'EXPEDIEE');

-- COMMANDES FOURNISSEURS
INSERT INTO CommandeFournisseur (IdFournisseur, Statut)
VALUES
(1,'ENVOYEE');

-- LIGNES COMMANDES FOURNISSEURS
INSERT INTO LigneCommandeFournisseur (IdCommandeFournisseur, ReferenceProduit, Quantite)
VALUES
(1,'P003',50);

-- =====================================================
-- CONTROLE
-- =====================================================

SELECT * FROM Client;
SELECT * FROM Produit;
SELECT * FROM Fournisseur;
SELECT * FROM Commande;
SELECT * FROM LigneCommande;
SELECT * FROM Paiement;
SELECT * FROM Livraison;
SELECT * FROM CommandeFournisseur;
SELECT * FROM LigneCommandeFournisseur;