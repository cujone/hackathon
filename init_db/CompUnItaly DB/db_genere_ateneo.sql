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
-- Table structure for table `ateneo`
--

DROP TABLE IF EXISTS `ateneo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ateneo` (
  `id_Ateneo` int NOT NULL,
  `Nome` text,
  `Regione` varchar(30) DEFAULT NULL,
  `Natura_Giuridica` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`id_Ateneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ateneo`
--

LOCK TABLES `ateneo` WRITE;
/*!40000 ALTER TABLE `ateneo` DISABLE KEYS */;
INSERT INTO `ateneo` VALUES (101,'Torino','Piemonte','Statale'),(102,'Torino Politecnico','Piemonte','Statale'),(201,'Piemonte Orientale','Piemonte','Statale'),(401,'Bra - Scienze Gastronomiche','Piemonte','Non statale'),(701,'Aosta','Valle d\'Aosta','Non statale'),(1001,'Genova','Liguria','Statale'),(1201,'Castellanza LIUC','Lombardia','Non statale'),(1202,'Insubria','Lombardia','Statale'),(1301,'Novedrate e-Campus','Lombardia','Non statale'),(1501,'Milano','Lombardia','Statale'),(1502,'Milano Politecnico','Lombardia','Statale'),(1503,'Milano Bocconi','Lombardia','Non statale'),(1504,'Milano Cattolica','Lombardia','Non statale'),(1505,'Milano IULM','Lombardia','Non statale'),(1508,'Milano San Raffaele','Lombardia','Non statale'),(1509,'Milano Bicocca','Lombardia','Statale'),(1510,'Rozzano (MI) Humanitas University','Lombardia','Non statale'),(1601,'Bergamo','Lombardia','Statale'),(1701,'Brescia','Lombardia','Statale'),(1801,'Pavia','Lombardia','Statale'),(1802,'Pavia IUSS','Lombardia','Statale'),(2101,'Bolzano','Trentino-Alto Adige','Non statale'),(2201,'Trento','Trentino-Alto Adige','Statale'),(2301,'Verona','Veneto','Statale'),(2701,'Venezia Cà Foscari','Veneto','Statale'),(2702,'Venezia Iuav','Veneto','Statale'),(2801,'Padova','Veneto','Statale'),(3001,'Udine','Friuli-Venezia Giulia','Statale'),(3201,'Trieste','Friuli-Venezia Giulia','Statale'),(3202,'Trieste SISSA','Friuli-Venezia Giulia','Statale'),(3401,'Parma','Emilia-Romagna','Statale'),(3601,'Modena e Reggio Emilia','Emilia-Romagna','Statale'),(3701,'Bologna','Emilia-Romagna','Statale'),(3801,'Ferrara','Emilia-Romagna','Statale'),(4101,'Urbino Carlo Bo','Marche','Statale'),(4201,'Marche','Marche','Statale'),(4301,'Macerata','Marche','Statale'),(4302,'Camerino','Marche','Statale'),(4601,'Lucca - IMT','Toscana','Statale'),(4801,'Firenze','Toscana','Statale'),(4803,'Firenze - Istituto Italiano di Scienze Umane','Toscana','Statale'),(4804,'Firenze IUL','Toscana','Non statale'),(5001,'Pisa','Toscana','Statale'),(5002,'Pisa Normale','Toscana','Statale'),(5003,'Pisa S.Anna','Toscana','Statale'),(5201,'Siena','Toscana','Statale'),(5202,'Siena Stranieri','Toscana','Statale'),(5401,'Perugia','Umbria','Statale'),(5403,'Perugia Stranieri','Umbria','Statale'),(5601,'Tuscia','Lazio','Statale'),(5801,'Roma La Sapienza','Lazio','Statale'),(5802,'Roma Tor Vergata','Lazio','Statale'),(5803,'Roma LUMSA','Lazio','Non statale'),(5805,'Roma LUISS','Lazio','Non statale'),(5806,'Roma Foro Italico','Lazio','Statale'),(5807,'Roma Tre','Lazio','Statale'),(5808,'Roma Biomedico','Lazio','Non statale'),(5809,'Roma UNINT','Lazio','Non statale'),(5810,'Roma Marconi','Lazio','Non statale'),(5811,'Roma UNITELMA','Lazio','Non statale'),(5812,'Roma Europea','Lazio','Non statale'),(5813,'Roma UNINETTUNO','Lazio','Non statale'),(5814,'Roma Mercatorum','Lazio','Non statale'),(5815,'Roma UNICUSANO','Lazio','Non statale'),(5816,'Roma San Raffaele','Lazio','Non statale'),(5817,'Roma - Link Campus','Lazio','Non statale'),(5818,'Roma - Saint Camillus','Lazio','Non statale'),(5819,'Roma - CASD - Centro Alti Studi per la Difesa','Lazio','Statale'),(6001,'Cassino','Lazio','Statale'),(6201,'Sannio','Campania','Statale'),(6202,'Benevento - Giustino Fortunato','Non statale','Non statale'),(6301,'Napoli Federico II','Campania','Statale'),(6302,'Napoli Parthenope','Campania','Statale'),(6303,'Napoli L\'Orientale','Campania','Statale'),(6304,'Napoli Benincasa','Campania','Non statale'),(6306,'Napoli Vanvitelli','Campania','Statale'),(6307,'Napoli Pegaso','Campania','Non statale'),(6308,'Napoli SS Meridionale','Campania','Statale'),(6501,'Salerno','Campania','Statale'),(6601,'L\'Aquila','Abruzzo','Statale'),(6603,'L\'Aquila - GSSI','Abruzzo','Statale'),(6701,'Teramo','Abruzzo','Statale'),(6901,'Chieti e Pescara','Abruzzo','Statale'),(6902,'Torrevecchia Teatina - Leonardo da Vinci','Abruzzo','Non statale'),(7001,'Molise','Molise','Statale'),(7101,'Foggia','Puglia','Statale'),(7201,'Bari','Puglia','Statale'),(7202,'Bari Politecnico','Puglia','Statale'),(7203,'Casamassima - G.Degennaro','Puglia','Non statale'),(7501,'Salento','Puglia','Statale'),(7601,'Basilicata','Basilicata','Statale'),(7801,'Calabria','Calabria','Statale'),(7901,'Catanzaro','Calabria','Statale'),(8001,'Reggio Calabria','Calabria','Statale'),(8003,'Reggio Calabria - Dante Alighieri','Calabria','Non statale'),(8201,'Palermo','Sicilia','Statale'),(8301,'Messina','Sicilia','Statale'),(8601,'Enna - KORE','Sicilia','Non statale'),(8701,'Catania','Sicilia','Statale'),(9001,'Sassari','Sardegna','Statale'),(9201,'Cagliari','Sardegna','Statale');
/*!40000 ALTER TABLE `ateneo` ENABLE KEYS */;
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
