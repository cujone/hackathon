-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_genere
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gruppo_laureati`
--

DROP TABLE IF EXISTS `gruppo_laureati`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gruppo_laureati` (
  `id_Laureati` int NOT NULL AUTO_INCREMENT,
  `Laurea_Nome` text,
  `Laurea_Tipo` text,
  `Genere` varchar(5) DEFAULT NULL,
  `Num_Laureati` int DEFAULT NULL,
  `Cod_Corso_Laureati` int DEFAULT NULL,
  `Settore_Laureati` int DEFAULT NULL,
  PRIMARY KEY (`id_Laureati`),
  KEY `fk_Cod_Corso_Laureati` (`Cod_Corso_Laureati`),
  KEY `fk_Settore_Laureati` (`Settore_Laureati`),
  CONSTRAINT `fk_Cod_Corso_Laureati` FOREIGN KEY (`Cod_Corso_Laureati`) REFERENCES `corso` (`id_Corso`) ON UPDATE CASCADE,
  CONSTRAINT `fk_Settore_Laureati` FOREIGN KEY (`Settore_Laureati`) REFERENCES `settore` (`id_Settore`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruppo_laureati`
--

LOCK TABLES `gruppo_laureati` WRITE;
/*!40000 ALTER TABLE `gruppo_laureati` DISABLE KEYS */;
INSERT INTO `gruppo_laureati` VALUES (1,'Agriculture, forestry, fisheries and veterinary','Laurea','F',1184,1,7),(2,'Agriculture, forestry, fisheries and veterinary','Laurea','M',1373,1,7),(3,'Agriculture, forestry, fisheries and veterinary','Laurea Magistrale','F',659,1,7),(4,'Agriculture, forestry, fisheries and veterinary','Laurea Magistrale','M',808,1,7),(5,'Agriculture, forestry, fisheries and veterinary','Laurea Magistrale Ciclo Unico','F',391,1,7),(6,'Agriculture, forestry, fisheries and veterinary','Laurea Magistrale Ciclo Unico','M',131,1,7),(7,'Arts and humanities','Laurea','F',3426,2,NULL),(8,'Arts and humanities','Laurea','M',1133,2,NULL),(9,'Arts and humanities','Laurea Magistrale','F',3446,2,NULL),(10,'Arts and humanities','Laurea Magistrale','M',1060,2,NULL),(11,'Arts and humanities','Laurea Magistrale Ciclo Unico','F',133,2,NULL),(12,'Arts and humanities','Laurea Magistrale Ciclo Unico','M',34,2,NULL),(13,'Business, administration and law','Laurea','F',3894,3,4),(14,'Business, administration and law','Laurea','M',5459,3,4),(15,'Business, administration and law','Laurea Magistrale','F',3740,3,4),(16,'Business, administration and law','Laurea Magistrale','M',4578,3,4),(17,'Business, administration and law','Laurea Magistrale Ciclo Unico','F',2991,3,4),(18,'Business, administration and law','Laurea Magistrale Ciclo Unico','M',1478,3,4),(19,'Education','Laurea','F',2469,4,NULL),(20,'Education','Laurea','M',165,4,NULL),(21,'Education','Laurea Magistrale','F',2911,4,NULL),(22,'Education','Laurea Magistrale','M',315,4,NULL),(23,'Education','Laurea Magistrale Ciclo Unico','F',2707,4,NULL),(24,'Education','Laurea Magistrale Ciclo Unico','M',178,4,NULL),(25,'Engineering, manufacturing and construction','Laurea','F',1475,5,11),(26,'Engineering, manufacturing and construction','Laurea','M',4976,5,11),(27,'Engineering, manufacturing and construction','Laurea Magistrale','F',1512,5,11),(28,'Engineering, manufacturing and construction','Laurea Magistrale','M',3249,5,11),(29,'Engineering, manufacturing and construction','Laurea Magistrale Ciclo Unico','F',786,5,11),(30,'Engineering, manufacturing and construction','Laurea Magistrale Ciclo Unico','M',463,5,11),(31,'Health and welfare','Laurea','F',6239,6,NULL),(32,'Health and welfare','Laurea','M',1989,6,NULL),(33,'Health and welfare','Laurea Magistrale','F',818,6,NULL),(34,'Health and welfare','Laurea Magistrale','M',472,6,NULL),(35,'Health and welfare','Laurea Magistrale Ciclo Unico','F',4001,6,NULL),(36,'Health and welfare','Laurea Magistrale Ciclo Unico','M',2603,6,NULL),(37,'Information and Communication Technologies (ICTs)','Laurea','F',183,7,13),(38,'Information and Communication Technologies (ICTs)','Laurea','M',1238,7,13),(39,'Information and Communication Technologies (ICTs)','Laurea Magistrale','F',241,7,13),(40,'Information and Communication Technologies (ICTs)','Laurea Magistrale','M',1066,7,13),(41,'Natural sciences, mathematics and statistics','Laurea','F',2865,8,1),(42,'Natural sciences, mathematics and statistics','Laurea','M',2147,8,1),(43,'Natural sciences, mathematics and statistics','Laurea Magistrale','F',3028,8,1),(44,'Natural sciences, mathematics and statistics','Laurea Magistrale','M',2379,8,1),(45,'Social sciences, journalism and information','Laurea','F',4668,10,NULL),(46,'Social sciences, journalism and information','Laurea','M',2886,10,NULL),(47,'Social sciences, journalism and information','Laurea Magistrale','F',3698,10,NULL),(48,'Social sciences, journalism and information','Laurea Magistrale','M',2568,10,NULL);
/*!40000 ALTER TABLE `gruppo_laureati` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-10 17:57:55
