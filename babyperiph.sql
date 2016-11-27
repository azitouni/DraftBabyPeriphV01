-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 20, 2016 at 01:33 PM
-- Server version: 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `babyperiph`
--

-- --------------------------------------------------------

--
-- Table structure for table `annonce`
--

CREATE TABLE `annonce` (
  `id` int(11) NOT NULL,
  `annonceName` varchar(30) NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  `prix` decimal(10,0) DEFAULT NULL,
  `isLocation` bit(1) NOT NULL DEFAULT b'0',
  `isVente` bit(1) NOT NULL DEFAULT b'0',
  `isService` bit(1) NOT NULL DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `isExpired` bit(1) NOT NULL DEFAULT b'0',
  `dateCreation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateModification` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table de toutes les annonces';

--
-- Triggers `annonce`
--
DELIMITER $$
CREATE TRIGGER `trg_annonce_dateCreation` BEFORE INSERT ON `annonce` FOR EACH ROW SET NEW.dateCreation = NOW()
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_annonce_dateModif` BEFORE UPDATE ON `annonce` FOR EACH ROW SET NEW.dateModification = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `idAnnonce` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  `categorieName` varchar(40) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'0',
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateModification` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `categorie`
--
DELIMITER $$
CREATE TRIGGER `trg_categorie_dateCreation` BEFORE INSERT ON `categorie` FOR EACH ROW SET NEW.dateCreation = NOW()
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_categorie_dateModif` BEFORE UPDATE ON `categorie` FOR EACH ROW SET NEW.dateModification = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `idAnnonce` int(11) NOT NULL,
  `imageName` varchar(40) NOT NULL,
  `imagePath` varchar(60) NOT NULL,
  `dateCreation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateModification` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table des images des annonces';

--
-- Triggers `image`
--
DELIMITER $$
CREATE TRIGGER `trg_image_dateCreation` BEFORE INSERT ON `image` FOR EACH ROW SET NEW.dateCreation = NOW()
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_image_dateModif` BEFORE UPDATE ON `image` FOR EACH ROW SET NEW.dateModification = NOW()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `panier`
--

CREATE TABLE `panier` (
  `id` int(11) NOT NULL,
  `idAnnonce` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  `isValidated` bit(1) NOT NULL DEFAULT b'0',
  `isExpired` bit(1) NOT NULL DEFAULT b'0',
  `dateCreation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateModification` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `firstName` varchar(40) NOT NULL,
  `address` varchar(40) NOT NULL,
  `postalCode` varchar(5) NOT NULL,
  `city` varchar(60) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `email` varchar(80) NOT NULL,
  `score` int(11) DEFAULT NULL,
  `isAdmin` bit(1) NOT NULL DEFAULT b'0',
  `isPremium` bit(1) NOT NULL DEFAULT b'0',
  `isProfessional` bit(1) NOT NULL DEFAULT b'0',
  `userName` varchar(40) NOT NULL,
  `isDeleted` bit(1) NOT NULL DEFAULT b'0',
  `dateCreation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateModification` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Liste des utilisateurs';

--
-- Triggers `utilisateur`
--
DELIMITER $$
CREATE TRIGGER `trg_utilisateur_dateModif` BEFORE UPDATE ON `utilisateur` FOR EACH ROW SET NEW.dateModification = NOW()
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_utilisateur_datecreation` BEFORE INSERT ON `utilisateur` FOR EACH ROW SET NEW.dateCreation = NOW()
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `annonce`
--
ALTER TABLE `annonce`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_utilisateur_id` (`idUtilisateur`);

--
-- Indexes for table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_categorieAnnonce_id` (`idAnnonce`),
  ADD KEY `fk_categorieUtilisateur_id` (`idUtilisateur`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_image_id` (`idAnnonce`);

--
-- Indexes for table `panier`
--
ALTER TABLE `panier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_panier_id` (`idAnnonce`),
  ADD KEY `fk_panierUtilisateur_id` (`idUtilisateur`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `annonce`
--
ALTER TABLE `annonce`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `panier`
--
ALTER TABLE `panier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `annonce`
--
ALTER TABLE `annonce`
  ADD CONSTRAINT `fk_utilisateur_id` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`id`);

--
-- Constraints for table `categorie`
--
ALTER TABLE `categorie`
  ADD CONSTRAINT `fk_categorieAnnonce_id` FOREIGN KEY (`idAnnonce`) REFERENCES `annonce` (`id`),
  ADD CONSTRAINT `fk_categorieUtilisateur_id` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`id`);

--
-- Constraints for table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `fk_image_id` FOREIGN KEY (`idAnnonce`) REFERENCES `annonce` (`id`);

--
-- Constraints for table `panier`
--
ALTER TABLE `panier`
  ADD CONSTRAINT `fk_panierUtilisateur_id` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `fk_panier_id` FOREIGN KEY (`idAnnonce`) REFERENCES `annonce` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
