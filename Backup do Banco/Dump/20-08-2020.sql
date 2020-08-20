-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: estoque_informatica
-- ------------------------------------------------------
-- Server version	5.7.28

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
-- Table structure for table `despacho_manutencao`
--

DROP TABLE IF EXISTS `despacho_manutencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despacho_manutencao` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DEFEITO` text NOT NULL,
  `DATA_SAIDA` date DEFAULT NULL,
  `ULTIMA_MANUTENCAO` varchar(20) DEFAULT NULL,
  `ID_EQUIPAMENTO` int(11) NOT NULL,
  `ID_ORDEM_SERVICO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_EQUIPAMENTO` (`ID_EQUIPAMENTO`),
  KEY `ID_ORDEM_SERVICO` (`ID_ORDEM_SERVICO`),
  CONSTRAINT `despacho_manutencao_ibfk_1` FOREIGN KEY (`ID_EQUIPAMENTO`) REFERENCES `equipamento` (`ID`),
  CONSTRAINT `despacho_manutencao_ibfk_2` FOREIGN KEY (`ID_ORDEM_SERVICO`) REFERENCES `ordem_servico` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `despacho_manutencao`
--

LOCK TABLES `despacho_manutencao` WRITE;
/*!40000 ALTER TABLE `despacho_manutencao` DISABLE KEYS */;
INSERT INTO `despacho_manutencao` VALUES (5,'TESTE3','2020-01-01','NUNCA',1,1),(7,'TESTE4','2020-01-01','NUNCA',1,1),(8,'TESTE5','2020-01-05','UM DIA',1,1),(9,'AAAAA','2020-01-01','NUNCA',3,NULL);
/*!40000 ALTER TABLE `despacho_manutencao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipamento`
--

DROP TABLE IF EXISTS `equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipamento` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SERIAL` varchar(50) NOT NULL,
  `DESCRICAO` varchar(50) DEFAULT NULL,
  `AQUISICAO` varchar(20) DEFAULT NULL,
  `FL_DISPONIVEL` varchar(1) DEFAULT 'N',
  `ID_TIPO_EQUIPAMENTO` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_TIPO_EQUIPAMENTO` (`ID_TIPO_EQUIPAMENTO`),
  CONSTRAINT `equipamento_ibfk_1` FOREIGN KEY (`ID_TIPO_EQUIPAMENTO`) REFERENCES `tipo_equipamento` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipamento`
--

LOCK TABLES `equipamento` WRITE;
/*!40000 ALTER TABLE `equipamento` DISABLE KEYS */;
INSERT INTO `equipamento` VALUES (1,'1564','TESTE','ABRIL DE 2019','N',1),(2,'123456','PC DELL','MAIO 2020','S',1),(3,'AAAA','AAAAA','ABRIL DE 2019','S',2);
/*!40000 ALTER TABLE `equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordem_servico`
--

DROP TABLE IF EXISTS `ordem_servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordem_servico` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORDEM_SERVICO` varchar(10) NOT NULL,
  `DATA_ENTRADA` date NOT NULL,
  `DATA_DEVOLUCAO` date DEFAULT NULL,
  `ID_EQUIPAMENTO` int(11) NOT NULL,
  `NUM_NF_ENVIO` varchar(5) DEFAULT NULL,
  `OBSERVACOES` text,
  `SERVICOS` text,
  `VALOR` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ORDEM_SERVICO` (`ORDEM_SERVICO`),
  KEY `ID_EQUIPAMENTO` (`ID_EQUIPAMENTO`),
  CONSTRAINT `ordem_servico_ibfk_1` FOREIGN KEY (`ID_EQUIPAMENTO`) REFERENCES `equipamento` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordem_servico`
--

LOCK TABLES `ordem_servico` WRITE;
/*!40000 ALTER TABLE `ordem_servico` DISABLE KEYS */;
INSERT INTO `ordem_servico` VALUES (1,'556','2020-01-01','2020-04-04',1,'123','alguns','varios',1500.00);
/*!40000 ALTER TABLE `ordem_servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retorno_manutencao`
--

DROP TABLE IF EXISTS `retorno_manutencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retorno_manutencao` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LAUDO_RETORNO` text NOT NULL,
  `DATA_RETORNO` date DEFAULT NULL,
  `ID_EQUIPAMENTO` int(11) NOT NULL,
  `ID_ORDEM_SERVICO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_EQUIPAMENTO` (`ID_EQUIPAMENTO`),
  KEY `ID_ORDEM_SERVICO` (`ID_ORDEM_SERVICO`),
  CONSTRAINT `retorno_manutencao_ibfk_1` FOREIGN KEY (`ID_EQUIPAMENTO`) REFERENCES `equipamento` (`ID`),
  CONSTRAINT `retorno_manutencao_ibfk_2` FOREIGN KEY (`ID_ORDEM_SERVICO`) REFERENCES `ordem_servico` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retorno_manutencao`
--

LOCK TABLES `retorno_manutencao` WRITE;
/*!40000 ALTER TABLE `retorno_manutencao` DISABLE KEYS */;
INSERT INTO `retorno_manutencao` VALUES (1,'testes ok','2020-07-07',1,1);
/*!40000 ALTER TABLE `retorno_manutencao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_equipamento`
--

DROP TABLE IF EXISTS `tipo_equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_equipamento` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOME` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_equipamento`
--

LOCK TABLES `tipo_equipamento` WRITE;
/*!40000 ALTER TABLE `tipo_equipamento` DISABLE KEYS */;
INSERT INTO `tipo_equipamento` VALUES (1,'COMPUTADOR'),(2,'AAAA');
/*!40000 ALTER TABLE `tipo_equipamento` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-20 17:08:46
