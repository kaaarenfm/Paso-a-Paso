-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: rutinas_test
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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
-- Table structure for table `canales_notificacion`
--

DROP TABLE IF EXISTS `canales_notificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canales_notificacion` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) NOT NULL,
  `nombre_visible` varchar(100) NOT NULL,
  `descripcion` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canales_notificacion`
--

LOCK TABLES `canales_notificacion` WRITE;
/*!40000 ALTER TABLE `canales_notificacion` DISABLE KEYS */;
INSERT INTO `canales_notificacion` VALUES (1,'push_habit','Recordatorios','Alertas de hábitos','2026-02-11 03:50:55'),(2,'email_weekly','Resumen Semanal','Reporte de progreso','2026-02-11 03:50:55'),(3,'push_social','Social','Nuevos seguidores y likes','2026-02-11 03:50:55'),(4,'sys_alert','Sistema','Avisos de cuenta','2026-02-11 03:50:55');
/*!40000 ALTER TABLE `canales_notificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias_rutina`
--

DROP TABLE IF EXISTS `categorias_rutina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias_rutina` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `padre_id` bigint unsigned DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `padre_id` (`padre_id`),
  KEY `ix_categorias_rutina_id` (`id`),
  CONSTRAINT `categorias_rutina_ibfk_1` FOREIGN KEY (`padre_id`) REFERENCES `categorias_rutina` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias_rutina`
--

LOCK TABLES `categorias_rutina` WRITE;
/*!40000 ALTER TABLE `categorias_rutina` DISABLE KEYS */;
INSERT INTO `categorias_rutina` VALUES (1,'Salud','Bienestar físico',NULL,NULL),(2,'Productividad','Trabajo y estudio',NULL,NULL),(3,'Mindfulness','Salud mental',NULL,NULL),(4,'Yoga','Flexibilidad',1,NULL),(5,'Gym','Fuerza',1,NULL),(6,'Estudio','Técnicas de estudio',2,NULL),(7,'Sueño','Higiene del sueño',3,NULL);
/*!40000 ALTER TABLE `categorias_rutina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentarios` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `publicacion_id` bigint unsigned DEFAULT NULL,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `contenido` text NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `publicacion_id` (`publicacion_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`publicacion_id`) REFERENCES `publicaciones_comunidad` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (1,1,3,'Felicidades Sofía!','2026-02-11 03:50:56',NULL),(2,1,5,'GG WP','2026-02-11 03:50:56',NULL);
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispositivos_fcm`
--

DROP TABLE IF EXISTS `dispositivos_fcm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dispositivos_fcm` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned NOT NULL,
  `token_fcm` varchar(255) NOT NULL,
  `plataforma` enum('web','android','ios') DEFAULT NULL,
  `idioma` varchar(10) DEFAULT 'es',
  `ultima_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_fcm` (`token_fcm`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `dispositivos_fcm_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispositivos_fcm`
--

LOCK TABLES `dispositivos_fcm` WRITE;
/*!40000 ALTER TABLE `dispositivos_fcm` DISABLE KEYS */;
/*!40000 ALTER TABLE `dispositivos_fcm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habitos`
--

DROP TABLE IF EXISTS `habitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habitos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rutina_id` bigint unsigned DEFAULT NULL,
  `categoria_id` bigint unsigned DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `tiempo_programado` time DEFAULT NULL,
  `tiempo_duracion_min` int DEFAULT NULL,
  `orden` int DEFAULT '0',
  `estado` tinyint(1) DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`categoria_id`),
  KEY `idx_habitos_rutina` (`rutina_id`),
  CONSTRAINT `habitos_ibfk_1` FOREIGN KEY (`rutina_id`) REFERENCES `rutinas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `habitos_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `habitos_categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitos`
--

LOCK TABLES `habitos` WRITE;
/*!40000 ALTER TABLE `habitos` DISABLE KEYS */;
INSERT INTO `habitos` VALUES (1,1,1,'Agua con Limón',NULL,'05:00:00',5,1,1,NULL),(2,1,4,'Lectura',NULL,'05:15:00',20,2,1,NULL),(3,1,1,'Yoga',NULL,'05:40:00',30,3,1,NULL),(4,2,2,'Bloquear Celular',NULL,'14:00:00',1,0,1,NULL),(5,2,2,'Trabajo Profundo',NULL,'14:05:00',90,0,1,NULL),(6,3,2,'Repaso',NULL,'22:00:00',60,0,1,NULL),(7,4,1,'Estirar Muñecas',NULL,'16:00:00',5,0,1,NULL);
/*!40000 ALTER TABLE `habitos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habitos_categoria`
--

DROP TABLE IF EXISTS `habitos_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habitos_categoria` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habitos_categoria`
--

LOCK TABLES `habitos_categoria` WRITE;
/*!40000 ALTER TABLE `habitos_categoria` DISABLE KEYS */;
INSERT INTO `habitos_categoria` VALUES (1,'Físico',NULL,1),(2,'Mental',NULL,1),(3,'Nutricional',NULL,1),(4,'Social',NULL,1);
/*!40000 ALTER TABLE `habitos_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_rutinas`
--

DROP TABLE IF EXISTS `historial_rutinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_rutinas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `rutina_id` bigint unsigned DEFAULT NULL,
  `fecha_completada` timestamp NULL DEFAULT (now()),
  `duracion_total_min` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `rutina_id` (`rutina_id`),
  KEY `ix_historial_rutinas_id` (`id`),
  CONSTRAINT `historial_rutinas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historial_rutinas_ibfk_2` FOREIGN KEY (`rutina_id`) REFERENCES `rutinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_rutinas`
--

LOCK TABLES `historial_rutinas` WRITE;
/*!40000 ALTER TABLE `historial_rutinas` DISABLE KEYS */;
INSERT INTO `historial_rutinas` VALUES (1,2,1,'2026-02-08 03:50:56',55),(2,2,1,'2026-02-09 03:50:56',50),(3,2,1,'2026-02-10 03:50:56',55),(4,2,1,'2026-02-11 03:50:56',52),(5,5,4,'2026-02-06 03:50:56',NULL),(7,4,1,'2026-02-11 03:52:50',0);
/*!40000 ALTER TABLE `historial_rutinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `publicacion_id` bigint unsigned DEFAULT NULL,
  `usuario_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publicacion_id` (`publicacion_id`,`usuario_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`publicacion_id`) REFERENCES `publicaciones_comunidad` (`id`) ON DELETE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,1,3),(2,1,4),(3,1,5),(4,1,6),(5,1,7);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_rutina`
--

DROP TABLE IF EXISTS `likes_rutina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes_rutina` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rutina_id` bigint unsigned DEFAULT NULL,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT (now()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `_rutina_usuario_like_uc` (`rutina_id`,`usuario_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `ix_likes_rutina_id` (`id`),
  CONSTRAINT `likes_rutina_ibfk_1` FOREIGN KEY (`rutina_id`) REFERENCES `rutinas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `likes_rutina_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_rutina`
--

LOCK TABLES `likes_rutina` WRITE;
/*!40000 ALTER TABLE `likes_rutina` DISABLE KEYS */;
INSERT INTO `likes_rutina` VALUES (1,2,2,'2026-02-11 03:50:56'),(2,2,4,'2026-02-11 03:50:56'),(3,2,5,'2026-02-11 03:50:56'),(4,2,10,'2026-02-11 03:50:56'),(5,1,4,'2026-02-11 03:52:20');
/*!40000 ALTER TABLE `likes_rutina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logros`
--

DROP TABLE IF EXISTS `logros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logros` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `icono` varchar(100) DEFAULT NULL,
  `tipo` enum('habitos','rutinas','racha','social') NOT NULL,
  `meta` int NOT NULL,
  `experiencia_otorgada` int DEFAULT '0',
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logros`
--

LOCK TABLES `logros` WRITE;
/*!40000 ALTER TABLE `logros` DISABLE KEYS */;
INSERT INTO `logros` VALUES (1,'Primer Paso','Completa 1 hábito',NULL,'habitos',1,50,1,'2026-02-11 03:50:55'),(2,'Influencer','Ten 5 seguidores',NULL,'social',5,200,1,'2026-02-11 03:50:55'),(3,'Racha de Hierro','7 días seguidos',NULL,'racha',7,500,1,'2026-02-11 03:50:55');
/*!40000 ALTER TABLE `logros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mascota_virtual`
--

DROP TABLE IF EXISTS `mascota_virtual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mascota_virtual` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `nombre` varchar(50) DEFAULT 'Buddy',
  `estado_animo` varchar(50) DEFAULT 'feliz',
  `nivel` int DEFAULT '1',
  `experiencia` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `mascota_virtual_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascota_virtual`
--

LOCK TABLES `mascota_virtual` WRITE;
/*!40000 ALTER TABLE `mascota_virtual` DISABLE KEYS */;
INSERT INTO `mascota_virtual` VALUES (1,2,'Rex','feliz',15,4500),(2,3,'Jarvis','feliz',10,2000),(3,4,'Luna','neutral',3,0),(4,7,'Thor','feliz',5,800),(5,10,'Loki','feliz',1,0);
/*!40000 ALTER TABLE `mascota_virtual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones_historial`
--

DROP TABLE IF EXISTS `notificaciones_historial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones_historial` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `titulo` varchar(150) DEFAULT NULL,
  `mensaje` text,
  `tipo` varchar(50) DEFAULT NULL,
  `leida` tinyint(1) DEFAULT '0',
  `fecha_envio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `notificaciones_historial_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones_historial`
--

LOCK TABLES `notificaciones_historial` WRITE;
/*!40000 ALTER TABLE `notificaciones_historial` DISABLE KEYS */;
INSERT INTO `notificaciones_historial` VALUES (1,2,'Nuevo Seguidor','David te ha comenzado a seguir','social',0,'2026-02-11 03:50:56',NULL),(2,4,'Alerta','No has completado tu rutina hoy','push_habit',0,'2026-02-11 03:50:56',NULL);
/*!40000 ALTER TABLE `notificaciones_historial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil_usuario`
--

DROP TABLE IF EXISTS `perfil_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil_usuario` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned NOT NULL,
  `biografia` text,
  `objetivos` text,
  `progreso` decimal(5,2) DEFAULT '0.00',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `perfil_usuario_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil_usuario`
--

LOCK TABLES `perfil_usuario` WRITE;
/*!40000 ALTER TABLE `perfil_usuario` DISABLE KEYS */;
INSERT INTO `perfil_usuario` VALUES (1,2,'Coach de vida. 5AM Club.','Ayudar a 1M de personas',0.00,NULL),(2,3,'Optimizando cada segundo.','Productividad extrema',0.00,NULL),(3,4,'Derecho y Café.','Sobrevivir a los finales',0.00,NULL);
/*!40000 ALTER TABLE `perfil_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planes`
--

DROP TABLE IF EXISTS `planes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `duracion_trial_dias` int DEFAULT '14',
  `limite_rutinas` int DEFAULT NULL,
  `permite_ia` tinyint(1) DEFAULT '0',
  `permite_mascota` tinyint(1) DEFAULT '0',
  `notificaciones_avanzadas` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planes`
--

LOCK TABLES `planes` WRITE;
/*!40000 ALTER TABLE `planes` DISABLE KEYS */;
INSERT INTO `planes` VALUES (1,'Gratuito',14,3,0,0,0,'2026-02-11 03:50:55'),(2,'Pro Mensual',30,20,1,1,0,'2026-02-11 03:50:55'),(3,'Elite Anual',365,99,1,1,0,'2026-02-11 03:50:55');
/*!40000 ALTER TABLE `planes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicaciones_comunidad`
--

DROP TABLE IF EXISTS `publicaciones_comunidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicaciones_comunidad` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `rutina_id` bigint unsigned DEFAULT NULL,
  `descripcion` text,
  `fecha_publicacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `rutina_id` (`rutina_id`),
  CONSTRAINT `publicaciones_comunidad_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `publicaciones_comunidad_ibfk_2` FOREIGN KEY (`rutina_id`) REFERENCES `rutinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicaciones_comunidad`
--

LOCK TABLES `publicaciones_comunidad` WRITE;
/*!40000 ALTER TABLE `publicaciones_comunidad` DISABLE KEYS */;
INSERT INTO `publicaciones_comunidad` VALUES (1,2,1,'¡Logré mi racha de 30 días! 🚀','2026-02-11 01:50:56',NULL);
/*!40000 ALTER TABLE `publicaciones_comunidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutina_ratings`
--

DROP TABLE IF EXISTS `rutina_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutina_ratings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rutina_id` bigint unsigned DEFAULT NULL,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `puntuacion` int NOT NULL,
  `comentario` text,
  `fecha` timestamp NULL DEFAULT (now()),
  PRIMARY KEY (`id`),
  KEY `rutina_id` (`rutina_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `ix_rutina_ratings_id` (`id`),
  CONSTRAINT `rutina_ratings_ibfk_1` FOREIGN KEY (`rutina_id`) REFERENCES `rutinas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rutina_ratings_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutina_ratings`
--

LOCK TABLES `rutina_ratings` WRITE;
/*!40000 ALTER TABLE `rutina_ratings` DISABLE KEYS */;
INSERT INTO `rutina_ratings` VALUES (1,1,3,5,'Increíble energía.','2026-02-11 03:50:56'),(2,1,4,4,'Muy temprano para mí, pero buena.','2026-02-11 03:50:56'),(3,1,5,5,'La mejor rutina de la app.','2026-02-11 03:50:56'),(4,1,6,3,'Demasiado yoga.','2026-02-11 03:50:56');
/*!40000 ALTER TABLE `rutina_ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutinas`
--

DROP TABLE IF EXISTS `rutinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutinas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `momento_dia` enum('mañana','tarde','noche','personalizado') DEFAULT 'mañana',
  `es_publica` tinyint(1) DEFAULT '0',
  `creada_por_ia` tinyint(1) DEFAULT '0',
  `estado` tinyint(1) DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_rutinas_usuario` (`usuario_id`),
  CONSTRAINT `rutinas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutinas`
--

LOCK TABLES `rutinas` WRITE;
/*!40000 ALTER TABLE `rutinas` DISABLE KEYS */;
INSERT INTO `rutinas` VALUES (1,2,'Rutina Mañanera 5AM','mañana',1,0,1,NULL),(2,3,'Deep Work','tarde',1,0,1,NULL),(3,4,'Noche de Estudio','noche',0,0,1,NULL),(4,5,'Salud Gamer','tarde',0,1,1,NULL),(5,4,'string','mañana',0,0,1,NULL);
/*!40000 ALTER TABLE `rutinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguidores`
--

DROP TABLE IF EXISTS `seguidores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seguidores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `seguidor_id` bigint unsigned DEFAULT NULL,
  `seguido_id` bigint unsigned DEFAULT NULL,
  `fecha_seguimiento` timestamp NULL DEFAULT (now()),
  PRIMARY KEY (`id`),
  UNIQUE KEY `_seguidor_seguido_uc` (`seguidor_id`,`seguido_id`),
  KEY `seguido_id` (`seguido_id`),
  KEY `ix_seguidores_id` (`id`),
  CONSTRAINT `seguidores_ibfk_1` FOREIGN KEY (`seguidor_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `seguidores_ibfk_2` FOREIGN KEY (`seguido_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguidores`
--

LOCK TABLES `seguidores` WRITE;
/*!40000 ALTER TABLE `seguidores` DISABLE KEYS */;
INSERT INTO `seguidores` VALUES (1,3,2,'2026-02-11 03:50:56'),(2,4,2,'2026-02-11 03:50:56'),(3,5,2,'2026-02-11 03:50:56'),(4,6,2,'2026-02-11 03:50:56'),(5,7,2,'2026-02-11 03:50:56'),(6,8,2,'2026-02-11 03:50:56'),(7,9,2,'2026-02-11 03:50:56'),(8,10,2,'2026-02-11 03:50:56'),(9,3,4,'2026-02-11 03:50:56'),(10,4,3,'2026-02-11 03:50:56'),(11,5,3,'2026-02-11 03:50:56'),(12,5,4,'2026-02-11 03:50:56'),(13,5,7,'2026-02-11 03:50:56'),(14,5,9,'2026-02-11 03:50:56'),(15,5,10,'2026-02-11 03:50:56'),(16,4,5,'2026-02-11 03:53:14');
/*!40000 ALTER TABLE `seguidores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seguimiento_habitos`
--

DROP TABLE IF EXISTS `seguimiento_habitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seguimiento_habitos` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `habito_id` bigint unsigned DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '0',
  `nota` text,
  `estado_animo` varchar(50) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `habito_id` (`habito_id`),
  KEY `idx_seguimiento_fecha` (`fecha`),
  CONSTRAINT `seguimiento_habitos_ibfk_1` FOREIGN KEY (`habito_id`) REFERENCES `habitos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seguimiento_habitos`
--

LOCK TABLES `seguimiento_habitos` WRITE;
/*!40000 ALTER TABLE `seguimiento_habitos` DISABLE KEYS */;
INSERT INTO `seguimiento_habitos` VALUES (1,1,'2026-02-07',1,'OK','feliz',NULL),(2,1,'2026-02-08',1,'OK','feliz',NULL),(3,1,'2026-02-09',1,'OK','motivado',NULL),(4,1,'2026-02-10',1,NULL,'motivado',NULL),(5,3,'2026-02-07',1,'Duro','cansado',NULL),(6,3,'2026-02-09',1,'Mejor','flexible',NULL),(7,7,'2026-02-05',1,'Hecho',NULL,NULL),(8,7,'2026-02-09',0,'Olvidé',NULL,NULL);
/*!40000 ALTER TABLE `seguimiento_habitos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_seguimiento_fecha` BEFORE INSERT ON `seguimiento_habitos` FOR EACH ROW BEGIN
    IF NEW.fecha IS NULL THEN
        SET NEW.fecha = CURDATE();
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuario_logros`
--

DROP TABLE IF EXISTS `usuario_logros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_logros` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint unsigned NOT NULL,
  `logro_id` bigint unsigned NOT NULL,
  `progreso` int DEFAULT '0',
  `completado` tinyint(1) DEFAULT '0',
  `fecha_completado` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_id` (`usuario_id`,`logro_id`),
  KEY `logro_id` (`logro_id`),
  CONSTRAINT `usuario_logros_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usuario_logros_ibfk_2` FOREIGN KEY (`logro_id`) REFERENCES `logros` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_logros`
--

LOCK TABLES `usuario_logros` WRITE;
/*!40000 ALTER TABLE `usuario_logros` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_logros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_suscripciones`
--

DROP TABLE IF EXISTS `usuario_suscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_suscripciones` (
  `usuario_id` bigint unsigned NOT NULL,
  `canal_id` bigint unsigned NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`usuario_id`,`canal_id`),
  KEY `canal_id` (`canal_id`),
  CONSTRAINT `usuario_suscripciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usuario_suscripciones_ibfk_2` FOREIGN KEY (`canal_id`) REFERENCES `canales_notificacion` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_suscripciones`
--

LOCK TABLES `usuario_suscripciones` WRITE;
/*!40000 ALTER TABLE `usuario_suscripciones` DISABLE KEYS */;
INSERT INTO `usuario_suscripciones` VALUES (2,1,1),(2,3,1),(5,1,0);
/*!40000 ALTER TABLE `usuario_suscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido_paterno` varchar(100) DEFAULT NULL,
  `apellido_materno` varchar(100) DEFAULT NULL,
  `correo_electronico` varchar(150) NOT NULL,
  `contrasena` text NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_fin_trial` timestamp NULL DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'activo',
  `foto_perfil` text,
  `plan_id` bigint unsigned DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`),
  KEY `plan_id` (`plan_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Admin','Sys',NULL,'admin@habitapp.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2023-01-01 08:00:00','2026-02-25 03:50:55','activo',NULL,3,NULL),(2,'Sofía','Influencer',NULL,'sofia@fit.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2025-11-03 03:50:55','2026-02-25 03:50:55','activo',NULL,3,NULL),(3,'Carlos','CEO',NULL,'carlos@work.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2025-11-13 03:50:55','2026-02-25 03:50:55','activo',NULL,3,NULL),(4,'Ana','Estudiante',NULL,'ana@uni.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2025-12-13 03:50:55','2026-02-25 04:01:41','activo',NULL,1,NULL),(5,'David','Gamer',NULL,'david@play.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-01-12 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(6,'Elena','Gomez',NULL,'elena@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(7,'Fernando','Ruiz',NULL,'fer@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,2,NULL),(8,'Gabriela','Paz',NULL,'gaby@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(9,'Hugo','Boss',NULL,'hugo@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,2,NULL),(10,'Irene','Adler',NULL,'irene@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,3,NULL),(11,'Jorge','1',NULL,'j@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(12,'Kevin','2',NULL,'k@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(13,'Laura','3',NULL,'l@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(14,'Mario','4',NULL,'m@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(15,'Nora','5',NULL,'n@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(16,'Oscar','6',NULL,'o@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','inactivo',NULL,1,NULL),(17,'Pedro','7',NULL,'p@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','suspendido',NULL,1,NULL),(18,'Quico','8',NULL,'q@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(19,'Rosa','9',NULL,'r@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL),(20,'Saul','10',NULL,'s@test.com','$2b$12$aB3832IvocRjZwwN9A5k8.lKRVBFGWfbBvckU393CLCfzgzivUs8G',NULL,'2026-02-11 03:50:55','2026-02-25 03:50:55','activo',NULL,1,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_usuario_trial` BEFORE INSERT ON `usuarios` FOR EACH ROW BEGIN
    IF NEW.fecha_fin_trial IS NULL THEN
        SET NEW.fecha_fin_trial = DATE_ADD(CURRENT_TIMESTAMP, INTERVAL 14 DAY);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-10 21:16:49
