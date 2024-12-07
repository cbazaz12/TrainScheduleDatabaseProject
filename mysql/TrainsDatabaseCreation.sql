CREATE DATABASE  IF NOT EXISTS `trains` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `trains`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: trains
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `ssn` varchar(11) DEFAULT NULL,
  `role` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('admin1','pp','Jack','Black','111-11-1111','admin'),('rep1','ppap','Johnny','Bravo','222-22-2222','rep');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna`
--

DROP TABLE IF EXISTS `qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qna` (
  `username` varchar(50) NOT NULL,
  `question` varchar(5000) DEFAULT NULL,
  `answer` varchar(5000) DEFAULT NULL,
  KEY `username` (`username`),
  CONSTRAINT `qna_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna`
--

LOCK TABLES `qna` WRITE;
/*!40000 ALTER TABLE `qna` DISABLE KEYS */;
INSERT INTO `qna` VALUES ('user1','Are there refunds?','No.'),('user2','Is the sky blue?','Sometimes, it could be black (night time).');
/*!40000 ALTER TABLE `qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservationreserveshas`
--

DROP TABLE IF EXISTS `reservationreserveshas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservationreserveshas` (
  `reservation_number` int NOT NULL,
  `date` date DEFAULT NULL,
  `total_fare` float DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `tid` int NOT NULL,
  `origin_datetime` datetime NOT NULL,
  PRIMARY KEY (`reservation_number`),
  KEY `tid` (`tid`,`origin_datetime`),
  KEY `username` (`username`),
  CONSTRAINT `reservationreserveshas_ibfk_1` FOREIGN KEY (`tid`, `origin_datetime`) REFERENCES `schedule` (`tid`, `origin_datetime`) ON DELETE CASCADE,
  CONSTRAINT `reservationreserveshas_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservationreserveshas`
--

LOCK TABLES `reservationreserveshas` WRITE;
/*!40000 ALTER TABLE `reservationreserveshas` DISABLE KEYS */;
INSERT INTO `reservationreserveshas` VALUES (52,'2023-12-04',15,'user1',1,'2023-12-04 08:30:00');
/*!40000 ALTER TABLE `reservationreserveshas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `tid` int NOT NULL,
  `origin_datetime` datetime NOT NULL,
  `fare` float DEFAULT NULL,
  `travel_time` time DEFAULT NULL,
  `transit_line` varchar(50) DEFAULT NULL,
  `dest_datetime` datetime DEFAULT NULL,
  `origin_station` varchar(50) DEFAULT NULL,
  `dest_station` varchar(50) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tid`,`origin_datetime`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `train` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES (1,'2023-12-04 08:30:00',15,'01:30:00','Blue Line','2023-12-04 10:00:00','Penn Station','William Gray Station','one-way'),(1,'2024-12-31 08:30:00',15,'01:30:00','Blue Line','2024-12-31 10:00:00','Penn Station','William Gray Station','one-way'),(1,'2024-12-31 14:15:00',20,'02:15:00','Red Line','2024-12-31 16:30:00','William Gray Station','Chicago Union Station','one-way'),(2,'2024-12-31 17:45:00',18,'02:30:00','Green Line','2024-12-31 20:30:00','Penn Station','Chicago Union Station','one-way');
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `sid` int NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `state` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'New York City','Penn Station','New York'),(2,'Philadelphia','William Gray Station','Pennsylvania'),(3,'Chicago','Chicago Union Station','Illinois');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stops`
--

DROP TABLE IF EXISTS `stops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stops` (
  `sid` int NOT NULL,
  `tid` int NOT NULL,
  `origin_datetime` datetime NOT NULL,
  `arrival_time` time DEFAULT NULL,
  `depart_time` time DEFAULT NULL,
  PRIMARY KEY (`sid`,`tid`,`origin_datetime`),
  KEY `tid` (`tid`,`origin_datetime`),
  CONSTRAINT `stops_ibfk_1` FOREIGN KEY (`tid`, `origin_datetime`) REFERENCES `schedule` (`tid`, `origin_datetime`) ON DELETE CASCADE,
  CONSTRAINT `stops_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `station` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stops`
--

LOCK TABLES `stops` WRITE;
/*!40000 ALTER TABLE `stops` DISABLE KEYS */;
INSERT INTO `stops` VALUES (1,1,'2023-12-04 08:30:00','08:30:00','08:30:00'),(1,1,'2024-12-31 08:30:00','08:30:00','08:30:00'),(1,2,'2024-12-31 17:45:00','17:45:00','17:45:00'),(2,1,'2023-12-04 08:30:00','10:00:00','10:00:00'),(2,1,'2024-12-31 08:30:00','10:00:00','10:00:00'),(2,1,'2024-12-31 14:15:00','14:15:00','14:15:00'),(3,1,'2024-12-31 14:15:00','16:30:00','16:30:00'),(3,2,'2024-12-31 17:45:00','20:30:00','20:30:00');
/*!40000 ALTER TABLE `stops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `tid` int NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (1),(2);
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('user1','pass','Bob','Johnson','bobjohnson@gmail.com'),('user2','password','Billy','Joe','billyjoe@gmail.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-07 13:58:05
