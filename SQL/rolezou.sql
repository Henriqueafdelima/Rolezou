-- MySQL dump 10.13  Distrib 8.0.37, for Win64 (x86_64)
--
-- Host: localhost    Database: rolezou
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `avaliacoes`
--

DROP TABLE IF EXISTS `avaliacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registro_usuario` int DEFAULT NULL,
  `registro_evento` int DEFAULT NULL,
  `nota` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `registro_usuario` (`registro_usuario`,`registro_evento`),
  KEY `registro_evento` (`registro_evento`),
  CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`registro_usuario`) REFERENCES `usuarios` (`registro_usuario`),
  CONSTRAINT `avaliacoes_ibfk_2` FOREIGN KEY (`registro_evento`) REFERENCES `eventos` (`registro_evento`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacoes`
--

LOCK TABLES `avaliacoes` WRITE;
/*!40000 ALTER TABLE `avaliacoes` DISABLE KEYS */;
INSERT INTO `avaliacoes` VALUES (1,4,1,5),(15,4,2,1),(16,4,3,5),(17,4,4,3),(18,2,1,5),(19,2,2,3),(21,2,3,5),(22,2,4,1),(30,5,1,4),(31,5,2,5),(32,5,3,5),(33,5,4,1),(35,11,9,4),(36,11,7,3),(37,11,8,5),(38,11,10,4),(39,11,11,5),(40,10,1,5),(41,10,2,5),(42,10,3,5),(43,10,4,1),(44,10,7,4),(46,10,8,4),(47,10,11,5),(48,10,10,5),(49,8,1,5),(50,8,2,4),(51,8,3,5),(52,8,4,1),(53,8,7,4),(55,8,8,4),(56,8,9,5),(57,8,10,4),(58,8,11,5),(59,9,1,5),(60,9,2,1),(61,9,3,5),(62,9,4,1),(63,9,7,4),(64,9,8,4),(65,9,9,4),(66,9,10,4),(67,9,11,5),(68,7,1,5),(69,7,2,4),(70,7,3,5),(71,7,4,1),(72,7,7,5),(73,7,8,4),(74,7,9,5),(75,7,10,3),(76,7,11,5);
/*!40000 ALTER TABLE `avaliacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventos` (
  `registro_evento` int NOT NULL AUTO_INCREMENT,
  `registro_usuario` int DEFAULT NULL,
  `nome_evento` varchar(255) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) NOT NULL,
  `data_evento` date DEFAULT NULL,
  `horario_evento` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `preco` decimal(10,2) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `criado_por` varchar(255) DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  PRIMARY KEY (`registro_evento`),
  KEY `registro_usuario` (`registro_usuario`),
  CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`registro_usuario`) REFERENCES `usuarios` (`registro_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES (1,4,'Codificadas','Primeiro evento universitário do curso de CDIA da PUCSP','Avenida Francisco Matarazzo, 1705, R. Palestra Itália, 200 - Água Branca, São Paulo - SP','2024-07-31','18:10','2024-06-18 21:10:33',80.00,'Designer.jpeg','05001-200','Hello_Kitty',NULL,NULL),(2,4,'Jogo de Volei FEAPUC','Jogo de vôlei contra a Mackenzie','Av. Miguel Ignácio Curi, 111 - Vila Carmosina, São Paulo - SP','2024-06-26','10:25','2024-06-18 22:16:34',0.00,'Designer_1.jpeg','08295-005','Hello_Kitty',NULL,NULL),(3,5,'AWS Summit São paulo','Aproveite um dia repleto de ação no AWS Summit São Paulo 2024 e confira as inovações em nuvem mais recentes.','Av. Dr. Mário Vilas Boas Rodrigues, 387 - Santo Amaro, São Paulo - SP','2024-08-15','07:00','2024-06-20 20:18:15',0.00,'awssummit.png','04757-020','QueenOfDisaster',NULL,NULL),(4,6,'Mochilão por São paulo','Vamos sair de São Paulo, passar por todos os municípios sem repetir e depois voltar para a capital','Rua Tentente Otavio Gomes 330 - Cambuci - SP','2024-06-26','06:00','2024-06-20 21:22:45',200.00,'caixa.jpeg','01526-010','Caixeiro_Viajante',NULL,NULL),(7,7,'Hengover - Um mundo mágico','Bem-vindos ao Mundo Mágico da hENGover!Junte-se a nós em uma noite onde seus sonhos mais secretos e desejos se tornam realidade.','Rua Barra Funda, 1075, Barra Funda, São Paulo, SP','2024-07-05','23:00','2024-06-24 19:57:50',85.00,'8c1306d61e8885126668b50649e3917c.jpg','01152-000','Dojacat',NULL,NULL),(8,8,'Open Double - OPEN BAR PREMIUM','OPEN DOUBLE 2.0 (OPEN BAR PREMIUM) Nosso tradicional Open de Sábados esta turbinado! Nova estrutura, nova pista de dança, nova iluminação, Open Bar Premium e aquela bagunça de sempre!','Rua Alagoas, 836, Higienópolis, São Paulo, SP','2024-06-29','22:00','2024-06-24 20:00:49',60.00,'9946af2542325edbc468dc471192077b.jpg','01242-001','Supermario',NULL,NULL),(9,9,'Pré Porto Festa do Farol','Proibido para menores de 18 anos\r\n','Rua Fradique Coutinho, Pinheiros, São Paulo, SP','2024-06-29','22:00','2024-06-24 20:05:11',120.00,'d61d63ba3ac4b52d7afc9c73f7a13e91.png','05416-002','Jinx',NULL,NULL),(10,10,'Sunset - OPENBAR','Sábado (15h - 21:00h) - estamos de volta para curtir um final de tarde com bebida à vontade, música boa e gente feliz!','Rua Alagoas, 836, Higienópolis, São Paulo, SP','2024-06-29','15:00','2024-06-24 20:06:49',80.00,'d110478a6e2840a7a3457f5cb860a4d2.jpg','01242-001','Richsk',NULL,NULL),(11,11,'G4: o Retorno',' Há 10 anos, as 4 forças unidas que construíram o maior fenômeno da USP decidiram selar um mal antigo e assim, uma das festas universitárias mais históricas foi encerrada…','R. Norma de Luca, 550, Barra Funda, São Paulo, SP','2024-06-28','23:00','2024-06-24 20:08:47',95.00,'18c0689325a39b2b5c724f7f11d3afad.png','01140-063','Peal',NULL,NULL);
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos_passados`
--

DROP TABLE IF EXISTS `eventos_passados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventos_passados` (
  `registro_evento` int NOT NULL AUTO_INCREMENT,
  `nome_evento` varchar(255) NOT NULL,
  `descricao` text,
  `endereco` varchar(255) DEFAULT NULL,
  `data_evento` date DEFAULT NULL,
  `horario_evento` time DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `criado_por` varchar(255) DEFAULT NULL,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`registro_evento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos_passados`
--

LOCK TABLES `eventos_passados` WRITE;
/*!40000 ALTER TABLE `eventos_passados` DISABLE KEYS */;
INSERT INTO `eventos_passados` VALUES (3,'Pool Party no 5º Andar da PUC','Venha de biquíni pra puc vai ser super revolucionário sim','Puc Perdizes','2024-06-22','17:37:00',0.00,'campus_perdizes.jpg','Hello_Kitty','2024-06-24 02:10:44'),(4,'Set Brat','Chari XCX tocando seu dj set na Zig Club',' R. Álvaro de Carvalho, 190 - Centro Histórico de São Paulo, São Paulo - SP','2024-06-22','00:12:00',600.00,'images.png','Hello_Kitty','2024-06-24 02:12:47');
/*!40000 ALTER TABLE `eventos_passados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `registro_usuario` int NOT NULL AUTO_INCREMENT,
  `nick` varchar(50) NOT NULL,
  `primeiro_nome` varchar(200) NOT NULL,
  `ultimo_nome` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`registro_usuario`),
  UNIQUE KEY `nick` (`nick`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `telefone` (`telefone`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (2,'usuario1','Usuario','1','teste@teste.com','5511999999999','scrypt:32768:8:1$yOdot86VhTR7Qurl$8ca9cfdb6f8bc6b39435f4ddee18be3cf39afa8fc154dda6adaebc2039c8b7f96fa98db794276bd1f9938b5c832e5fabe568cb673639896f824b4a166fd83fb5','2024-06-13 23:00:19'),(4,'Hello_Kitty','Hello','Kitty','hello_kitty@teste.com','5511999999998','scrypt:32768:8:1$dmoSvuUuhR4bvk2k$ed716eaa778f8fbb1f5ef7da05d2def27409fa921470672ddedf7fbb7d3370a8faea8bd0a22104e7904837173a0cd27c6f54f639854581becf24bd015f9e9677','2024-06-14 00:55:02'),(5,'QueenOfDisaster','Lana','Del Rey','qof@teste.com','5511999999997','scrypt:32768:8:1$7pRzOwzNm8Y6irWr$e3fe0e1247117cbaa02f69c001fd193d9c863d8ec6d384aa2f9699c131394f50114a45d35c7aba79245e6326d140c1e8e3d0604ec25a18435461acb94cc87d77','2024-06-20 20:01:41'),(6,'Caixeiro_Viajante','Caixeiro','Viajante','motoboy@teste.com','5511999999996','scrypt:32768:8:1$1Yv3FwhDd69kenZK$ea7df74a071d6e2671323fd9bc7035bad40a3857341257af1fba5c11ee1b6f993167898b42fbd9cd095558979164958d0598883da0995d6a70a3f09e7e7a3e1e','2024-06-20 21:17:35'),(7,'DojaCat','Amala','Khan','dojacat@teste.com','5511999999995','scrypt:32768:8:1$elgPQIRwc6p1vI1c$b9763b62c3cdca1285a6c7c3e0310438e76d21590e633d59bddd427c13a739b53fa124bac6ec42ed7dac8eeb6e2d6f255661f905e5df9e95ce1b085a7cc9bf22','2024-06-24 19:56:22'),(8,'SuperMario','Mario','Henrique','supermario@teste.com','5511999999994','scrypt:32768:8:1$Vv9lSkLx1OlCsRWz$cbf8854dfe81839ebd3c8dc4ed2d64fa0e4347054bed2734686ddadd5f0c7d5fc025cf4c6bd3a2b4bc01fbd6375c12bec7fa65dfac71127ff3c8de5b0cef3f6e','2024-06-24 19:58:50'),(9,'Jinx','Powder','Towver','jinx@teste.com','5511999999993','scrypt:32768:8:1$nSxsGCHx2hQvvG0W$93e9de5e313a6271750e41d5c710a77250c12fb8220da9618aef59a043732cc5aa8a693f89c5c97d05e2097f015a6d1a450fa9f32f5e92f46b3ad7c44f99d080','2024-06-24 20:04:18'),(10,'Richsk','Henrique','Lima','richsk@teste.com','5511999999990','scrypt:32768:8:1$F5kX4Lp7Uf0V1rrd$d7f9771d7e06079ca5b8838418cdb1e5d43cea9726a58dbad36bc9246a9e91132fd9dfa550e5505c2d62289db4706cd006b3bbc2ef6d4c9ce610eceae16b5736','2024-06-24 20:05:44'),(11,'Peal','Breno','Beno','pearl@teste.com.br','5511999999992','scrypt:32768:8:1$h1MirASEDad8GauD$d439a53039ffb7fd78948f10ce6b88102a2175086481e1afc460317412c211b94938f32f5b82db667c34dd26029d7186ceda5140e38c18750e2f397a6dd1f0c2','2024-06-24 20:07:15');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-24 17:28:50
