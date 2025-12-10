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
-- Table structure for table `azienda`
--

DROP TABLE IF EXISTS `azienda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `azienda` (
  `id_Azienda` int NOT NULL AUTO_INCREMENT,
  `Cod_ATECO` varchar(6) DEFAULT NULL,
  `Nome` text,
  `Regione` varchar(30) DEFAULT NULL,
  `Settore_Azienda` int DEFAULT NULL,
  PRIMARY KEY (`id_Azienda`),
  KEY `fk_Settore_Azienda` (`Settore_Azienda`),
  CONSTRAINT `fk_Settore_Azienda` FOREIGN KEY (`Settore_Azienda`) REFERENCES `settore` (`id_Settore`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `azienda`
--

LOCK TABLES `azienda` WRITE;
/*!40000 ALTER TABLE `azienda` DISABLE KEYS */;
INSERT INTO `azienda` VALUES (1,'360000','ACEA','Lazio',1),(2,'701000','ASCOPIAVE','Veneto',2),(3,'701000','ASSICURAZIONI GENERALI','Lazio',3),(4,'641910','BANCA DI CIVIDALE SCPA - CIVIBANK','Friuli-Venezia Giulia',4),(5,'641910','BANCA DI CREDITO POPOLARE','Campania',4),(6,'641910','BANCA GENERALI SPA','Friuli-Venezia Giulia',4),(7,'641910','BANCA SELLA','Piemonte',4),(8,'641910','BANCO BPM','Lombardia',4),(9,'143900','BRUNELLO CUCINELLI','Umbria',5),(10,'281510','CARRARO','Veneto',6),(11,'641910','CASSA CENTRALE BANCA CREDITO COOPERATIVO ITALIANO S.P.A.','Trentino-Alto Adige',4),(12,'701000','ERG','Liguria',1),(13,'471120','ESSELUNGA','Lombardia',7),(14,'701000','FERROVIE DELLO STATO ITALIANE','Lazio',8),(15,'152010','GEOX','Veneto',9),(16,'620100','GPI SPA','Trentino-Alto Adige',2),(17,'641910','IBL BANCA','Lazio',4),(18,'641910','ILLIMITY BANK SPA','Lombardia',4),(19,'352200','ITALGAS','Lombardia',1),(20,'293209','LANDI RENZO','Emilia Romagna',10),(21,'711210','MAIRE TECNIMONT','Lazio',6),(22,'641910','MEDIOBANCA','Lombardia',4),(23,'782000','OPENJOBMETIS','Lombardia',2),(24,'221110','PIRELLI','Lombardia',9),(25,'611000','RETELIT SPA','Lombardia',11),(26,'192010','SARAS','Sardegna',12),(27,'610000','TIM','Lombardia',13);
/*!40000 ALTER TABLE `azienda` ENABLE KEYS */;
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
