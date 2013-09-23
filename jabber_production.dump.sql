-- MySQL dump 10.13  Distrib 5.5.22, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: jabber_production
-- ------------------------------------------------------
-- Server version	5.5.22-0ubuntu1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agents`
--

DROP TABLE IF EXISTS `agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `authentication_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_agents_on_email` (`email`),
  UNIQUE KEY `index_agents_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
INSERT INTO `agents` VALUES (1,'ruslan@helperchat.com','$2a$10$Wc130sPnIfiS1yBN8M0gU.dcAYaOGFNgvzHfdoz81mrX9omgIzjdO',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,'2013-09-13 10:35:52','2013-09-13 10:35:52','',NULL),(2,'admin@helperchat.com','$2a$10$/fU6GtR5AYJh4r8VI.6Na.RBo3f8vWjHzT5Rk2YB6z5KSdUTtm3u2',NULL,NULL,NULL,3,'2013-09-19 11:48:39','2013-09-16 13:55:46','85.238.106.70','195.138.66.218',NULL,'2013-09-13 10:35:52','2013-09-20 06:33:32','Волошин Руслан','VoloshinRuslan_150.jpg'),(3,'wax_duzer@mail.ru','$2a$10$qdNExh4qBTbr4TZqz7ZojuKw8I6IiKYe1daZH6a/bNhVHwDtSwEwO',NULL,NULL,NULL,2,'2013-09-21 16:41:49','2013-09-21 15:38:17','85.238.114.132','85.238.114.132',NULL,'2013-09-21 15:38:17','2013-09-21 17:17:50','Иванов Иван','______.JPG');
/*!40000 ALTER TABLE `agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archive_collections`
--

DROP TABLE IF EXISTS `archive_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive_collections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prev_id` int(11) DEFAULT NULL,
  `next_id` int(11) DEFAULT NULL,
  `us` varchar(2047) NOT NULL,
  `with_user` varchar(1023) NOT NULL,
  `with_server` varchar(1023) NOT NULL,
  `with_resource` varchar(1023) NOT NULL,
  `utc` datetime NOT NULL,
  `change_by` varchar(3071) DEFAULT NULL,
  `change_utc` datetime DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  `subject` varchar(1023) DEFAULT NULL,
  `thread` varchar(1023) DEFAULT NULL,
  `crypt` tinyint(4) DEFAULT NULL,
  `extra` mediumtext,
  PRIMARY KEY (`id`),
  KEY `IDX_archive_colls_with` (`us`(16),`with_user`(8),`with_server`(8),`utc`),
  KEY `IDX_archive_colls_prev_id` (`prev_id`),
  KEY `IDX_archive_colls_next_id` (`next_id`),
  KEY `IDX_archive_colls_utc` (`us`(16),`utc`),
  KEY `IDX_archive_colls_change` (`deleted`,`change_utc`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive_collections`
--

LOCK TABLES `archive_collections` WRITE;
/*!40000 ALTER TABLE `archive_collections` DISABLE KEYS */;
INSERT INTO `archive_collections` VALUES (1,NULL,NULL,'guest_970@public.helperchat.com','admin','helperchat.com','rvoloshin-2','2013-09-22 15:31:44','guest_970@public.helperchat.com/42140244281379863896243027','2013-09-22 15:42:17',0,'','',NULL,NULL),(2,NULL,NULL,'admin@helperchat.com','guest_970','public.helperchat.com','42140244281379863896243027','2013-09-22 15:31:44','admin@helperchat.com/rvoloshin-2','2013-09-22 15:42:17',0,'','',NULL,NULL),(3,NULL,NULL,'wax_duzer@helperchat.com','guest_9933','public.helperchat.com','','2013-09-22 15:41:18','wax_duzer@helperchat.com/QIP','2013-09-22 15:41:18',0,'','',NULL,NULL),(4,NULL,NULL,'guest_970@public.helperchat.com','admin','helperchat.com','','2013-09-22 16:33:35','guest_970@public.helperchat.com/1578010951379867612321185','2013-09-22 16:33:47',0,'','',NULL,NULL),(5,NULL,NULL,'admin@helperchat.com','guest_970','public.helperchat.com','1578010951379867612321185','2013-09-22 16:33:35','admin@helperchat.com','2013-09-22 16:33:47',0,'','',NULL,NULL),(6,NULL,NULL,'guest_970@public.helperchat.com','admin','helperchat.com','rvoloshin-2','2013-09-23 05:54:07','guest_970@public.helperchat.com/19233016941379915313280568','2013-09-23 05:54:07',0,'','',NULL,NULL),(7,NULL,NULL,'admin@helperchat.com','guest_970','public.helperchat.com','19233016941379915313280568','2013-09-23 05:54:07','admin@helperchat.com/rvoloshin-2','2013-09-23 05:54:07',0,'','',NULL,NULL);
/*!40000 ALTER TABLE `archive_collections` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`deploy`@`localhost`*/ /*!50003 TRIGGER archive_collections_update BEFORE UPDATE ON archive_collections
FOR EACH ROW
BEGIN
  IF NEW.deleted = 1 THEN
    DELETE FROM archive_messages WHERE coll_id = NEW.id;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`deploy`@`localhost`*/ /*!50003 TRIGGER archive_collections_delete BEFORE DELETE ON archive_collections
FOR EACH ROW
BEGIN
  DELETE FROM archive_messages WHERE coll_id = OLD.id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `archive_global_prefs`
--

DROP TABLE IF EXISTS `archive_global_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive_global_prefs` (
  `us` varchar(2047) NOT NULL,
  `save` tinyint(4) DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `otr` tinyint(4) DEFAULT NULL,
  `method_auto` tinyint(4) DEFAULT NULL,
  `method_local` tinyint(4) DEFAULT NULL,
  `method_manual` tinyint(4) DEFAULT NULL,
  `auto_save` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`us`(16))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive_global_prefs`
--

LOCK TABLES `archive_global_prefs` WRITE;
/*!40000 ALTER TABLE `archive_global_prefs` DISABLE KEYS */;
INSERT INTO `archive_global_prefs` VALUES ('admin@helperchat.com',1,NULL,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `archive_global_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archive_jid_prefs`
--

DROP TABLE IF EXISTS `archive_jid_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive_jid_prefs` (
  `us` varchar(2047) NOT NULL,
  `with_user` varchar(1023) NOT NULL,
  `with_server` varchar(1023) NOT NULL,
  `with_resource` varchar(1023) NOT NULL,
  `save` tinyint(4) DEFAULT NULL,
  `expire` int(11) DEFAULT NULL,
  `otr` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`us`(16),`with_user`(8),`with_server`(8),`with_resource`(8))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive_jid_prefs`
--

LOCK TABLES `archive_jid_prefs` WRITE;
/*!40000 ALTER TABLE `archive_jid_prefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `archive_jid_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archive_messages`
--

DROP TABLE IF EXISTS `archive_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archive_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coll_id` int(11) NOT NULL,
  `utc` datetime NOT NULL,
  `dir` tinyint(4) DEFAULT NULL,
  `body` mediumtext,
  `name` varchar(1023) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_archive_msgs_coll_id` (`coll_id`,`utc`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archive_messages`
--

LOCK TABLES `archive_messages` WRITE;
/*!40000 ALTER TABLE `archive_messages` DISABLE KEYS */;
INSERT INTO `archive_messages` VALUES (1,1,'2013-09-22 15:31:44',1,'asdasd\n',''),(2,2,'2013-09-22 15:31:44',0,'asdasd\n',''),(3,1,'2013-09-22 15:31:45',1,'asd\n',''),(4,2,'2013-09-22 15:31:45',0,'asd\n',''),(5,1,'2013-09-22 15:31:46',1,'asd\n',''),(6,2,'2013-09-22 15:31:46',0,'asd\n',''),(7,1,'2013-09-22 15:31:46',1,'asd\n',''),(8,2,'2013-09-22 15:31:46',0,'asd\n',''),(9,1,'2013-09-22 15:31:47',1,'asd\n',''),(10,2,'2013-09-22 15:31:47',0,'asd\n',''),(11,1,'2013-09-22 15:31:55',1,'test mesage from client \n',''),(12,2,'2013-09-22 15:31:55',0,'test mesage from client \n',''),(13,1,'2013-09-22 15:35:46',1,'test message\n',''),(14,2,'2013-09-22 15:35:46',0,'test message\n',''),(15,1,'2013-09-22 15:36:07',1,'new test message\n',''),(16,2,'2013-09-22 15:36:07',0,'new test message\n',''),(17,3,'2013-09-22 15:41:18',1,'?',''),(18,1,'2013-09-22 15:42:09',0,'sadasd',''),(19,2,'2013-09-22 15:42:09',1,'sadasd',''),(20,2,'2013-09-22 15:42:11',1,'ghbdtn ',''),(21,1,'2013-09-22 15:42:11',0,'ghbdtn ',''),(22,2,'2013-09-22 15:42:15',1,'[jntk cghjcnm ',''),(23,1,'2013-09-22 15:42:15',0,'[jntk cghjcnm ',''),(24,2,'2013-09-22 15:42:17',1,'зотел ',''),(25,1,'2013-09-22 15:42:17',0,'зотел ',''),(26,4,'2013-09-22 16:33:35',1,'asd\n',''),(27,5,'2013-09-22 16:33:35',0,'asd\n',''),(28,4,'2013-09-22 16:33:37',1,'asd\n',''),(29,5,'2013-09-22 16:33:37',0,'asd\n',''),(30,4,'2013-09-22 16:33:38',1,'asd\n',''),(31,5,'2013-09-22 16:33:38',0,'asd\n',''),(32,4,'2013-09-22 16:33:39',1,'asd\n',''),(33,5,'2013-09-22 16:33:39',0,'asd\n',''),(34,4,'2013-09-22 16:33:39',1,'asd\n',''),(35,5,'2013-09-22 16:33:39',0,'asd\n',''),(36,4,'2013-09-22 16:33:40',1,'asd\n',''),(37,5,'2013-09-22 16:33:40',0,'asd\n',''),(38,4,'2013-09-22 16:33:40',1,'asd\n',''),(39,5,'2013-09-22 16:33:40',0,'asd\n',''),(40,4,'2013-09-22 16:33:40',1,'asd\n',''),(41,5,'2013-09-22 16:33:40',0,'asd\n',''),(42,4,'2013-09-22 16:33:41',1,'asd\n',''),(43,5,'2013-09-22 16:33:41',0,'asd\n',''),(44,4,'2013-09-22 16:33:41',1,'asd\n',''),(45,5,'2013-09-22 16:33:41',0,'asd\n',''),(46,4,'2013-09-22 16:33:43',1,'ghbdtn \n',''),(47,5,'2013-09-22 16:33:43',0,'ghbdtn \n',''),(48,4,'2013-09-22 16:33:47',1,'yjdjt cjj,otyb\n',''),(49,5,'2013-09-22 16:33:47',0,'yjdjt cjj,otyb\n',''),(50,6,'2013-09-23 05:54:07',0,'asd',''),(51,7,'2013-09-23 05:54:07',1,'asd','');
/*!40000 ALTER TABLE `archive_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caps_features`
--

DROP TABLE IF EXISTS `caps_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caps_features` (
  `node` varchar(250) NOT NULL,
  `subnode` varchar(250) NOT NULL,
  `feature` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `i_caps_features_node_subnode` (`node`(75),`subnode`(75))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caps_features`
--

LOCK TABLES `caps_features` WRITE;
/*!40000 ALTER TABLE `caps_features` DISABLE KEYS */;
/*!40000 ALTER TABLE `caps_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `irc_custom`
--

DROP TABLE IF EXISTS `irc_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `irc_custom` (
  `jid` text NOT NULL,
  `host` text NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `i_irc_custom_jid_host` (`jid`(75),`host`(75)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `irc_custom`
--

LOCK TABLES `irc_custom` WRITE;
/*!40000 ALTER TABLE `irc_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `irc_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `last`
--

DROP TABLE IF EXISTS `last`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `last` (
  `username` varchar(250) NOT NULL,
  `seconds` text NOT NULL,
  `state` text NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `last`
--

LOCK TABLES `last` WRITE;
/*!40000 ALTER TABLE `last` DISABLE KEYS */;
INSERT INTO `last` VALUES ('admin','1379869334',''),('guest_1768','1379856332',''),('guest_2198','1379840024',''),('guest_330','1379857450',''),('guest_4908','1379781084',''),('guest_6414','1379781249',''),('guest_9189','1379841106',''),('guest_970','1379919338',''),('guest_9933','1379864229',''),('helperchat','1379869335',''),('wax_duzer','1379887775','');
/*!40000 ALTER TABLE `last` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motd`
--

DROP TABLE IF EXISTS `motd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `motd` (
  `username` varchar(250) NOT NULL,
  `xml` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motd`
--

LOCK TABLES `motd` WRITE;
/*!40000 ALTER TABLE `motd` DISABLE KEYS */;
/*!40000 ALTER TABLE `motd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `muc_registered`
--

DROP TABLE IF EXISTS `muc_registered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `muc_registered` (
  `jid` text NOT NULL,
  `host` text NOT NULL,
  `nick` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `i_muc_registered_jid_host` (`jid`(75),`host`(75)) USING BTREE,
  KEY `i_muc_registered_nick` (`nick`(75)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `muc_registered`
--

LOCK TABLES `muc_registered` WRITE;
/*!40000 ALTER TABLE `muc_registered` DISABLE KEYS */;
/*!40000 ALTER TABLE `muc_registered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `muc_room`
--

DROP TABLE IF EXISTS `muc_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `muc_room` (
  `name` text NOT NULL,
  `host` text NOT NULL,
  `opts` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `i_muc_room_name_host` (`name`(75),`host`(75)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `muc_room`
--

LOCK TABLES `muc_room` WRITE;
/*!40000 ALTER TABLE `muc_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `muc_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacy_default_list`
--

DROP TABLE IF EXISTS `privacy_default_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privacy_default_list` (
  `username` varchar(250) NOT NULL,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacy_default_list`
--

LOCK TABLES `privacy_default_list` WRITE;
/*!40000 ALTER TABLE `privacy_default_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `privacy_default_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacy_list`
--

DROP TABLE IF EXISTS `privacy_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privacy_list` (
  `username` varchar(250) NOT NULL,
  `name` varchar(250) NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `i_privacy_list_username_name` (`username`(75),`name`(75)) USING BTREE,
  KEY `i_privacy_list_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacy_list`
--

LOCK TABLES `privacy_list` WRITE;
/*!40000 ALTER TABLE `privacy_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `privacy_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacy_list_data`
--

DROP TABLE IF EXISTS `privacy_list_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privacy_list_data` (
  `id` bigint(20) DEFAULT NULL,
  `t` char(1) NOT NULL,
  `value` text NOT NULL,
  `action` char(1) NOT NULL,
  `ord` decimal(10,0) NOT NULL,
  `match_all` tinyint(1) NOT NULL,
  `match_iq` tinyint(1) NOT NULL,
  `match_message` tinyint(1) NOT NULL,
  `match_presence_in` tinyint(1) NOT NULL,
  `match_presence_out` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacy_list_data`
--

LOCK TABLES `privacy_list_data` WRITE;
/*!40000 ALTER TABLE `privacy_list_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `privacy_list_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_storage`
--

DROP TABLE IF EXISTS `private_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `private_storage` (
  `username` varchar(250) NOT NULL,
  `namespace` varchar(250) NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `i_private_storage_username_namespace` (`username`(75),`namespace`(75)) USING BTREE,
  KEY `i_private_storage_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_storage`
--

LOCK TABLES `private_storage` WRITE;
/*!40000 ALTER TABLE `private_storage` DISABLE KEYS */;
/*!40000 ALTER TABLE `private_storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pubsub_item`
--

DROP TABLE IF EXISTS `pubsub_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubsub_item` (
  `nodeid` bigint(20) DEFAULT NULL,
  `itemid` text,
  `publisher` text,
  `creation` text,
  `modification` text,
  `payload` text,
  UNIQUE KEY `i_pubsub_item_tuple` (`nodeid`,`itemid`(36)),
  KEY `i_pubsub_item_itemid` (`itemid`(36)),
  CONSTRAINT `pubsub_item_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pubsub_item`
--

LOCK TABLES `pubsub_item` WRITE;
/*!40000 ALTER TABLE `pubsub_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `pubsub_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pubsub_node`
--

DROP TABLE IF EXISTS `pubsub_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubsub_node` (
  `host` text,
  `node` text,
  `parent` text,
  `type` text,
  `nodeid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nodeid`),
  UNIQUE KEY `i_pubsub_node_tuple` (`host`(20),`node`(120)),
  KEY `i_pubsub_node_parent` (`parent`(120))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pubsub_node`
--

LOCK TABLES `pubsub_node` WRITE;
/*!40000 ALTER TABLE `pubsub_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `pubsub_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pubsub_node_option`
--

DROP TABLE IF EXISTS `pubsub_node_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubsub_node_option` (
  `nodeid` bigint(20) DEFAULT NULL,
  `name` text,
  `val` text,
  KEY `i_pubsub_node_option_nodeid` (`nodeid`),
  CONSTRAINT `pubsub_node_option_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pubsub_node_option`
--

LOCK TABLES `pubsub_node_option` WRITE;
/*!40000 ALTER TABLE `pubsub_node_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `pubsub_node_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pubsub_node_owner`
--

DROP TABLE IF EXISTS `pubsub_node_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubsub_node_owner` (
  `nodeid` bigint(20) DEFAULT NULL,
  `owner` text,
  KEY `i_pubsub_node_owner_nodeid` (`nodeid`),
  CONSTRAINT `pubsub_node_owner_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pubsub_node_owner`
--

LOCK TABLES `pubsub_node_owner` WRITE;
/*!40000 ALTER TABLE `pubsub_node_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `pubsub_node_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pubsub_state`
--

DROP TABLE IF EXISTS `pubsub_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubsub_state` (
  `nodeid` bigint(20) DEFAULT NULL,
  `jid` text,
  `affiliation` char(1) DEFAULT NULL,
  `subscriptions` text,
  `stateid` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`stateid`),
  UNIQUE KEY `i_pubsub_state_tuple` (`nodeid`,`jid`(60)),
  KEY `i_pubsub_state_jid` (`jid`(60)),
  CONSTRAINT `pubsub_state_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pubsub_state`
--

LOCK TABLES `pubsub_state` WRITE;
/*!40000 ALTER TABLE `pubsub_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `pubsub_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pubsub_subscription_opt`
--

DROP TABLE IF EXISTS `pubsub_subscription_opt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubsub_subscription_opt` (
  `subid` text COLLATE utf8_unicode_ci,
  `opt_name` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opt_value` text COLLATE utf8_unicode_ci,
  UNIQUE KEY `i_pubsub_subscription_opt` (`subid`(32),`opt_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pubsub_subscription_opt`
--

LOCK TABLES `pubsub_subscription_opt` WRITE;
/*!40000 ALTER TABLE `pubsub_subscription_opt` DISABLE KEYS */;
/*!40000 ALTER TABLE `pubsub_subscription_opt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roster_version`
--

DROP TABLE IF EXISTS `roster_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roster_version` (
  `username` varchar(250) NOT NULL,
  `version` text NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roster_version`
--

LOCK TABLES `roster_version` WRITE;
/*!40000 ALTER TABLE `roster_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `roster_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rostergroups`
--

DROP TABLE IF EXISTS `rostergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rostergroups` (
  `username` varchar(250) NOT NULL,
  `jid` varchar(250) NOT NULL,
  `grp` text NOT NULL,
  KEY `pk_rosterg_user_jid` (`username`(75),`jid`(75))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rostergroups`
--

LOCK TABLES `rostergroups` WRITE;
/*!40000 ALTER TABLE `rostergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `rostergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rosterusers`
--

DROP TABLE IF EXISTS `rosterusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rosterusers` (
  `username` varchar(250) NOT NULL,
  `jid` varchar(250) NOT NULL,
  `nick` text NOT NULL,
  `subscription` char(1) NOT NULL,
  `ask` char(1) NOT NULL,
  `askmessage` text NOT NULL,
  `server` char(1) NOT NULL,
  `subscribe` text NOT NULL,
  `type` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `i_rosteru_user_jid` (`username`(75),`jid`(75)),
  KEY `i_rosteru_username` (`username`),
  KEY `i_rosteru_jid` (`jid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rosterusers`
--

LOCK TABLES `rosterusers` WRITE;
/*!40000 ALTER TABLE `rosterusers` DISABLE KEYS */;
/*!40000 ALTER TABLE `rosterusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20130911071435'),('20130911085505'),('20130911090059'),('20130911122746'),('20130911161833'),('20130913072554'),('20130915185959'),('20130919075429'),('20130919115406');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_categories`
--

DROP TABLE IF EXISTS `site_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_categories`
--

LOCK TABLES `site_categories` WRITE;
/*!40000 ALTER TABLE `site_categories` DISABLE KEYS */;
INSERT INTO `site_categories` VALUES (1,'Интернет-магазин','2013-09-13 10:35:52','2013-09-13 10:35:52'),(2,'информационный сайт','2013-09-13 10:35:52','2013-09-13 10:35:52'),(3,'Игровой портал','2013-09-13 10:35:52','2013-09-13 10:35:52'),(4,'Блог','2013-09-13 10:35:52','2013-09-13 10:35:52'),(5,'Социальная сеть','2013-09-13 10:35:52','2013-09-13 10:35:52'),(6,'Путешествие','2013-09-13 10:35:52','2013-09-13 10:35:52'),(7,'Товары для дома','2013-09-13 10:35:52','2013-09-13 10:35:52'),(8,'Интернет провайдер','2013-09-13 10:35:52','2013-09-13 10:35:52'),(9,'Развлечения','2013-09-13 10:35:52','2013-09-13 10:35:52'),(10,'Азартные игры','2013-09-13 10:35:52','2013-09-13 10:35:52'),(11,'Коммунальные услуги','2013-09-13 10:35:52','2013-09-13 10:35:52'),(12,'Туристические услуги','2013-09-13 10:35:52','2013-09-13 10:35:52'),(13,'Гостинница','2013-09-13 10:35:52','2013-09-13 10:35:52'),(14,'Интернет услуги','2013-09-13 10:35:52','2013-09-13 10:35:52'),(15,'Новостной портал','2013-09-13 10:35:52','2013-09-13 10:35:52');
/*!40000 ALTER TABLE `site_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `domain` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `site_category_id` int(11) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  `color` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `side` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title_online` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title_offline` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `collect_stats` tinyint(1) DEFAULT '0',
  `show_online` tinyint(1) DEFAULT '1',
  `show_offline` tinyint(1) DEFAULT '0',
  `auto_open` tinyint(1) DEFAULT '0',
  `enabled` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sites_on_site_category_id` (`site_category_id`),
  KEY `index_sites_on_agent_id` (`agent_id`),
  KEY `index_sites_on_uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,'RubyClub','site1.com:3000',2,2,'#3b3b3b','bottom','right','','',0,1,0,0,1,'2013-09-19 11:48:57','2013-09-20 06:48:49','64221a20034f0131af59040106cf7601'),(2,'Test','skylogic.ua',1,3,'#3b3b3b','bottom','right','Помощь специалиста','Отправить запрос',0,1,0,0,1,'2013-09-21 15:40:19','2013-09-21 15:51:23','0af385d0050201315d1a040106cf7601'),(3,'megatorg.in.ua','admin.megatorg.in.ua',1,3,'#3b3b3b','bottom','right',NULL,NULL,0,1,0,0,1,'2013-09-21 15:43:15','2013-09-21 15:43:15','73f10c90050201315d1b040106cf7601');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spool`
--

DROP TABLE IF EXISTS `spool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spool` (
  `username` varchar(250) NOT NULL,
  `xml` text NOT NULL,
  `seq` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `seq` (`seq`),
  KEY `i_despool` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spool`
--

LOCK TABLES `spool` WRITE;
/*!40000 ALTER TABLE `spool` DISABLE KEYS */;
/*!40000 ALTER TABLE `spool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sr_group`
--

DROP TABLE IF EXISTS `sr_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sr_group` (
  `name` varchar(250) NOT NULL,
  `opts` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sr_group`
--

LOCK TABLES `sr_group` WRITE;
/*!40000 ALTER TABLE `sr_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `sr_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sr_user`
--

DROP TABLE IF EXISTS `sr_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sr_user` (
  `jid` varchar(250) NOT NULL,
  `grp` varchar(250) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `i_sr_user_jid_group` (`jid`(75),`grp`(75)),
  KEY `i_sr_user_jid` (`jid`),
  KEY `i_sr_user_grp` (`grp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sr_user`
--

LOCK TABLES `sr_user` WRITE;
/*!40000 ALTER TABLE `sr_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `sr_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(250) NOT NULL,
  `password` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `agent_id` int(11) NOT NULL,
  PRIMARY KEY (`username`),
  KEY `index_users_on_agent_id` (`agent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin',',fhfrelf','2013-09-20 12:13:08',0),('helperchat','helperchat_password','2013-09-20 08:25:29',2),('wax_duzer','789456123','2013-09-21 15:44:05',3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vcard`
--

DROP TABLE IF EXISTS `vcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcard` (
  `username` varchar(250) NOT NULL,
  `vcard` mediumtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vcard`
--

LOCK TABLES `vcard` WRITE;
/*!40000 ALTER TABLE `vcard` DISABLE KEYS */;
INSERT INTO `vcard` VALUES ('admin','<vCard xmlns=\'vcard-temp\' prodid=\'-//HandGen//NONSGML vGen v1.0//EN\' version=\'2.0\'><PHOTO><TYPE>image/png</TYPE><BINVAL>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</BINVAL></PHOTO></vCard>','2013-09-20 18:42:46'),('helperchat','<vCard xmlns=\'vcard-temp\' prodid=\'-//HandGen//NONSGML vGen v1.0//EN\' version=\'2.0\'><PHOTO><TYPE>image/png</TYPE><BINVAL>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</BINVAL></PHOTO></vCard>','2013-09-20 18:41:13'),('wax_duzer','<vCard xmlns=\'vcard-temp\' prodid=\'-//HandGen//NONSGML vGen v1.0//EN\' version=\'2.0\'><PHOTO><TYPE>image/png</TYPE><BINVAL>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</BINVAL></PHOTO></vCard>','2013-09-21 16:05:21');
/*!40000 ALTER TABLE `vcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vcard_search`
--

DROP TABLE IF EXISTS `vcard_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcard_search` (
  `username` varchar(250) NOT NULL,
  `lusername` varchar(250) NOT NULL,
  `fn` text NOT NULL,
  `lfn` varchar(250) NOT NULL,
  `family` text NOT NULL,
  `lfamily` varchar(250) NOT NULL,
  `given` text NOT NULL,
  `lgiven` varchar(250) NOT NULL,
  `middle` text NOT NULL,
  `lmiddle` varchar(250) NOT NULL,
  `nickname` text NOT NULL,
  `lnickname` varchar(250) NOT NULL,
  `bday` text NOT NULL,
  `lbday` varchar(250) NOT NULL,
  `ctry` text NOT NULL,
  `lctry` varchar(250) NOT NULL,
  `locality` text NOT NULL,
  `llocality` varchar(250) NOT NULL,
  `email` text NOT NULL,
  `lemail` varchar(250) NOT NULL,
  `orgname` text NOT NULL,
  `lorgname` varchar(250) NOT NULL,
  `orgunit` text NOT NULL,
  `lorgunit` varchar(250) NOT NULL,
  PRIMARY KEY (`lusername`),
  KEY `i_vcard_search_lfn` (`lfn`),
  KEY `i_vcard_search_lfamily` (`lfamily`),
  KEY `i_vcard_search_lgiven` (`lgiven`),
  KEY `i_vcard_search_lmiddle` (`lmiddle`),
  KEY `i_vcard_search_lnickname` (`lnickname`),
  KEY `i_vcard_search_lbday` (`lbday`),
  KEY `i_vcard_search_lctry` (`lctry`),
  KEY `i_vcard_search_llocality` (`llocality`),
  KEY `i_vcard_search_lemail` (`lemail`),
  KEY `i_vcard_search_lorgname` (`lorgname`),
  KEY `i_vcard_search_lorgunit` (`lorgunit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vcard_search`
--

LOCK TABLES `vcard_search` WRITE;
/*!40000 ALTER TABLE `vcard_search` DISABLE KEYS */;
INSERT INTO `vcard_search` VALUES ('admin','admin','','','','','','','','','','','','','','','','','','','','','',''),('helperchat','helperchat','','','','','','','','','','','','','','','','','','','','','',''),('wax_duzer','wax_duzer','','','','','','','','','','','','','','','','','','','','','','');
/*!40000 ALTER TABLE `vcard_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vcard_xupdate`
--

DROP TABLE IF EXISTS `vcard_xupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcard_xupdate` (
  `username` varchar(250) NOT NULL,
  `hash` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vcard_xupdate`
--

LOCK TABLES `vcard_xupdate` WRITE;
/*!40000 ALTER TABLE `vcard_xupdate` DISABLE KEYS */;
/*!40000 ALTER TABLE `vcard_xupdate` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-23  6:57:33
