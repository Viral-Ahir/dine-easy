CREATE DATABASE  IF NOT EXISTS `dine_easy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dine_easy`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: dine_easy
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `contact_number` (`contact_number`),
  UNIQUE KEY `user_name` (`user_name`),
  CONSTRAINT `fk_customer_user_name` FOREIGN KEY (`user_name`) REFERENCES `user_login` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Michael','Ross','1234567890','Michael Ross'),(5,'Kartik','Ahir','6543210987','Kartik Ahir'),(6,'Tanay','Pandya','5432109876','Tanay Pandya'),(7,'Ross',NULL,'4321098765','Ross'),(8,'Joey',NULL,'3210987654','Joey'),(9,'Chandler',NULL,'2109876543','Chandler'),(10,'Monica',NULL,'1098765432','Monica');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dining_area`
--

DROP TABLE IF EXISTS `dining_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dining_area` (
  `table_id` int NOT NULL,
  `seating_capacity` int DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  PRIMARY KEY (`table_id`),
  KEY `fk_dining_area_restaurant` (`restaurant_id`),
  KEY `fk_dining_area_staff` (`staff_id`),
  CONSTRAINT `fk_dining_area_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_dining_area_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff_member` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dining_area`
--

LOCK TABLES `dining_area` WRITE;
/*!40000 ALTER TABLE `dining_area` DISABLE KEYS */;
INSERT INTO `dining_area` VALUES (1201,4,10012,101),(1202,8,10012,101),(1203,12,10012,103),(1701,6,10017,102),(1702,6,10017,102),(1801,5,10018,105),(1802,5,10018,105),(1803,4,10018,106),(1804,8,10018,107);
/*!40000 ALTER TABLE `dining_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_items`
--

DROP TABLE IF EXISTS `food_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_items` (
  `item_id` int NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `item_description` varchar(255) NOT NULL,
  `cost_of_item` float NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_items`
--

LOCK TABLES `food_items` WRITE;
/*!40000 ALTER TABLE `food_items` DISABLE KEYS */;
INSERT INTO `food_items` VALUES (1,'Veggie Combo','Assorted Veggie rolls with fresh veggies and rice',18.75),(2,'Butter Chicken','Creamy Indian curry with tender chicken pieces',14.5),(3,'Margherita Pizza','Classic Italian pizza with tomato, mozzarella, and basil',12.5),(4,'Chole Bhature','North Indian dish with spiced chickpeas and fried bread',11.99),(5,'Lasagna','Classic Italian layered pasta dish with meat and cheese',16.99),(6,'Chicken Biryani','Spiced Indian rice dish with chicken and aromatic herbs',14.75),(7,'Fettuccine Alfredo','Creamy Italian pasta with parmesan cheese',13.99),(8,'Paneer Tikka','Indian appetizer with marinated and grilled cottage cheese',12.5),(9,'Risotto','Creamy Italian rice dish with broth and ingredients',15.25),(10,'Chana Masala','North Indian dish with spiced chickpeas',11.99);
/*!40000 ALTER TABLE `food_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_items_order`
--

DROP TABLE IF EXISTS `food_items_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_items_order` (
  `item_id` int DEFAULT NULL,
  `quantity_ordered` int NOT NULL,
  `order_id` int DEFAULT NULL,
  KEY `fk_food_items_order_placed` (`order_id`),
  KEY `fk_food_items_food_item` (`item_id`),
  CONSTRAINT `fk_food_items_food_item` FOREIGN KEY (`item_id`) REFERENCES `food_items` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_food_items_order_placed` FOREIGN KEY (`order_id`) REFERENCES `order_placed` (`order_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_items_order`
--

LOCK TABLES `food_items_order` WRITE;
/*!40000 ALTER TABLE `food_items_order` DISABLE KEYS */;
INSERT INTO `food_items_order` VALUES (1,2,1),(4,1,1),(1,3,2),(4,2,2),(7,3,3),(8,2,4),(4,2,5),(6,1,6),(8,2,6),(10,2,6),(2,1,6),(3,2,7),(9,1,7),(5,1,8),(7,1,8),(5,4,9),(3,3,9);
/*!40000 ALTER TABLE `food_items_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_items_restaurant`
--

DROP TABLE IF EXISTS `food_items_restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_items_restaurant` (
  `item_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `quantity_of_food_item` int DEFAULT NULL,
  PRIMARY KEY (`item_id`,`restaurant_id`),
  KEY `fk_restaurant_food_items` (`restaurant_id`),
  CONSTRAINT `fk_food_items_restaurant` FOREIGN KEY (`item_id`) REFERENCES `food_items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_restaurant_food_items` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_items_restaurant`
--

LOCK TABLES `food_items_restaurant` WRITE;
/*!40000 ALTER TABLE `food_items_restaurant` DISABLE KEYS */;
INSERT INTO `food_items_restaurant` VALUES (1,10017,27),(2,10018,18),(3,10012,10),(4,10017,20),(5,10012,5),(6,10018,7),(7,10012,9),(8,10018,15),(9,10012,7),(10,10018,8);
/*!40000 ALTER TABLE `food_items_restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_placed`
--

DROP TABLE IF EXISTS `order_placed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_placed` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_date` date NOT NULL,
  `total_amount` float DEFAULT NULL,
  `customer_id` int NOT NULL,
  `card_number` varchar(255) DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_order_placed_customer` (`customer_id`),
  KEY `fk_order_placed_restaurant` (`restaurant_id`),
  KEY `fk_order_placed_payment_card` (`card_number`),
  CONSTRAINT `fk_order_placed_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_placed_payment_card` FOREIGN KEY (`card_number`) REFERENCES `payment_card` (`card_number`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_order_placed_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_placed`
--

LOCK TABLES `order_placed` WRITE;
/*!40000 ALTER TABLE `order_placed` DISABLE KEYS */;
INSERT INTO `order_placed` VALUES (1,'2023-12-01',37.5,1,'1234567890123456',10017),(2,'2023-11-02',23.98,5,'9876543210987654',10017),(3,'2023-11-02',41.97,5,'9876543210987654',10012),(4,'2023-12-02',25,5,'9876543210987654',10018),(5,'2023-10-05',23.98,6,'1111222233334444',10017),(6,'2023-11-03',14.75,6,'1111222233334444',10018),(7,'2023-12-07',40.25,7,'5555666677778888',10012),(8,'2023-12-07',30.98,5,'9876543210987654',10012),(9,'2023-12-07',105.46,7,'5555666677778888',10012);
/*!40000 ALTER TABLE `order_placed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_card`
--

DROP TABLE IF EXISTS `payment_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_card` (
  `card_number` varchar(255) NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `card_type` enum('VISA','AMEX','MASTERCARD') DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`card_number`),
  KEY `fk_payment_card_customer` (`customer_id`),
  CONSTRAINT `fk_payment_card_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_card`
--

LOCK TABLES `payment_card` WRITE;
/*!40000 ALTER TABLE `payment_card` DISABLE KEYS */;
INSERT INTO `payment_card` VALUES ('1111222233334444','2023-08-01','AMEX',6),('1234567890123456','2023-12-01','VISA',1),('4444333322221111','2024-09-01','VISA',9),('5555666677778888','2024-10-01','VISA',7),('8888777766665555','2024-07-01','MASTERCARD',10),('9876543210987654','2024-05-01','MASTERCARD',5),('9999888877776666','2023-11-01','MASTERCARD',8);
/*!40000 ALTER TABLE `payment_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `table_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `date_reserved` date NOT NULL,
  `area_status` enum('RESERVED','NOT RESERVED') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  KEY `fk_reservation_table` (`table_id`),
  KEY `fk_reservation_customer` (`customer_id`),
  CONSTRAINT `fk_reservation_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reservation_table` FOREIGN KEY (`table_id`) REFERENCES `dining_area` (`table_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1201,5,'2023-12-25','RESERVED','14:00:00','15:00:00'),(1201,NULL,'2023-12-25','NOT RESERVED','15:00:00','16:00:00'),(1201,6,'2023-12-25','RESERVED','16:00:00','17:00:00'),(1201,NULL,'2023-12-25','NOT RESERVED','17:00:00','18:00:00'),(1202,NULL,'2023-12-25','NOT RESERVED','15:00:00','16:00:00'),(1202,5,'2023-12-25','RESERVED','16:00:00','17:00:00'),(1202,NULL,'2023-12-25','NOT RESERVED','17:00:00','18:00:00'),(1203,6,'2023-12-25','RESERVED','16:00:00','17:00:00'),(1203,NULL,'2023-12-25','NOT RESERVED','17:00:00','18:00:00'),(1701,NULL,'2023-12-25','NOT RESERVED','14:00:00','15:00:00'),(1701,7,'2023-12-25','RESERVED','15:00:00','16:00:00'),(1701,7,'2023-12-25','RESERVED','16:00:00','17:00:00'),(1701,NULL,'2023-12-25','NOT RESERVED','17:00:00','18:00:00'),(1702,6,'2023-12-25','RESERVED','14:00:00','15:00:00'),(1702,NULL,'2023-12-25','NOT RESERVED','15:00:00','16:00:00'),(1801,7,'2023-12-25','RESERVED','14:00:00','15:00:00'),(1801,NULL,'2023-12-25','NOT RESERVED','15:00:00','16:00:00'),(1801,NULL,'2023-12-25','NOT RESERVED','16:00:00','17:00:00'),(1801,NULL,'2023-12-25','NOT RESERVED','17:00:00','18:00:00'),(1802,NULL,'2023-12-25','NOT RESERVED','14:00:00','15:00:00'),(1802,NULL,'2023-12-25','NOT RESERVED','15:00:00','16:00:00'),(1802,NULL,'2023-12-25','NOT RESERVED','16:00:00','17:00:00'),(1803,NULL,'2023-12-25','NOT RESERVED','14:00:00','15:00:00'),(1803,NULL,'2023-12-25','NOT RESERVED','15:00:00','16:00:00'),(1804,NULL,'2023-12-25','NOT RESERVED','14:00:00','15:00:00'),(1804,NULL,'2023-12-25','NOT RESERVED','15:00:00','16:00:00'),(1804,NULL,'2023-12-25','NOT RESERVED','16:00:00','17:00:00');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `manage_reservation` BEFORE INSERT ON `reservation` FOR EACH ROW BEGIN
    DECLARE restaurant_opening_time TIME;
    DECLARE restaurant_closing_time TIME;

    SELECT r.open_time, r.close_time
    INTO restaurant_opening_time, restaurant_closing_time
    FROM dining_area da
    JOIN restaurant r ON da.restaurant_id = r.restaurant_id
    WHERE da.table_id = NEW.table_id;

    SET NEW.end_time = ADDTIME(NEW.start_time, '01:00:00');

    -- Check if start_time is after or equal to opening time and end_time is before or equal to closing time
    IF NEW.start_time < restaurant_opening_time OR NEW.end_time > restaurant_closing_time THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Reservation time is outside restaurant operating hours';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `restaurant_id` int NOT NULL,
  `restaurant_name` varchar(255) NOT NULL,
  `street_number` int NOT NULL,
  `street_name` varchar(255) NOT NULL,
  `zip_code` int NOT NULL,
  `state_abbreviation` char(3) NOT NULL,
  `open_time` time NOT NULL,
  `close_time` time NOT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (10012,'Italian Freestyle',123,'Main Street',12345,'NY','11:30:00','21:00:00'),(10017,'Vegetarian Delight',890,'Elm Avenue',98765,'CA','09:30:00','20:00:00'),(10018,'Indian Tadka',789,'Maple Road',67890,'TX','09:00:00','22:30:00');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_manager`
--

DROP TABLE IF EXISTS `staff_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_manager` (
  `manager_id` int NOT NULL,
  `restaurant_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  PRIMARY KEY (`manager_id`),
  UNIQUE KEY `staff_id` (`staff_id`),
  KEY `fk_staff_manager_restaurant` (`restaurant_id`),
  CONSTRAINT `fk_staff_manager_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_manager_staff_member` FOREIGN KEY (`staff_id`) REFERENCES `staff_member` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_manager`
--

LOCK TABLES `staff_manager` WRITE;
/*!40000 ALTER TABLE `staff_manager` DISABLE KEYS */;
INSERT INTO `staff_manager` VALUES (1103,10012,103),(1104,10017,104),(1105,10018,105);
/*!40000 ALTER TABLE `staff_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_member`
--

DROP TABLE IF EXISTS `staff_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_member` (
  `staff_id` int NOT NULL,
  `staff_first_name` varchar(255) NOT NULL,
  `staff_last_name` varchar(255) DEFAULT NULL,
  `salary` int NOT NULL,
  `restaurant_id` int DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `fk_staff_member_restaurant` (`restaurant_id`),
  CONSTRAINT `fk_staff_member_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`restaurant_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_member_user_name` FOREIGN KEY (`user_name`) REFERENCES `user_login` (`user_name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_member`
--

LOCK TABLES `staff_member` WRITE;
/*!40000 ALTER TABLE `staff_member` DISABLE KEYS */;
INSERT INTO `staff_member` VALUES (101,'JC','Gada',100000,10012,'JCGada'),(102,'Rachael','Green',150000,10017,'Rachael'),(103,'Devam','Jariwala',170000,10012,'Devam Jariwala'),(104,'Viral','Ahir',180000,10017,'Viral Ahir'),(105,'Helly',NULL,120000,10018,'Helly'),(106,'Khushi',NULL,100000,10018,'Khushi'),(107,'Riddhi',NULL,100000,10018,'Riddhi');
/*!40000 ALTER TABLE `staff_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login` (
  `user_name` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `is_staff` tinyint(1) DEFAULT '0',
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

LOCK TABLES `user_login` WRITE;
/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
INSERT INTO `user_login` VALUES ('Chandler','chandler12',0),('Devam Jariwala','devam123',1),('Helly','helly123',1),('JCGada','gada123',1),('Joey','joey12',0),('Kartik Ahir','kartik12',0),('Khushi','khushi123',1),('Michael Ross','michael12',0),('Monica','monica12',0),('Rachael','Rachael123',1),('Riddhi','riddhi123',1),('Ross','ross12',0),('Tanay Pandya','tanay12',0),('Viral Ahir','viral123',1);
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dine_easy'
--

--
-- Dumping routines for database 'dine_easy'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddItem`(
    IN itemId INT,
    IN quantityOrdered INT,
	IN restaurantId INT,
    IN orderId INT
)
BEGIN
        INSERT INTO food_items_order (item_id, quantity_ordered, order_id) 
        VALUES (itemId, quantityOrdered,orderId);
        
        UPDATE food_items_restaurant
        SET quantity_of_food_item = quantity_of_food_item - quantityOrdered
        WHERE item_id = itemId AND restaurant_id = (
            SELECT restaurant_id
            FROM order_placed
            WHERE order_id = orderId
        );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddNewFoodItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddNewFoodItem`(
    IN staffId INT,
    IN itemName VARCHAR(255),
    IN itemDescription VARCHAR(255),
    IN costOfItem FLOAT,
    IN initialAvailableQuantity INT
)
BEGIN
    DECLARE newFoodItemId INT;

    SELECT MAX(item_id) INTO newFoodItemId FROM food_items;
    SET newFoodItemId = newFoodItemId + 1;

    INSERT INTO food_items (item_id, item_name, item_description, cost_of_item)
    VALUES (newFoodItemId, itemName, itemDescription, costOfItem);

    INSERT INTO food_items_restaurant (item_id, restaurant_id, quantity_of_food_item)
    VALUES (newFoodItemId, (SELECT restaurant_id FROM staff_member WHERE staff_id = staffId), initialAvailableQuantity);

    SELECT newFoodItemId AS newFoodItemId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddOrder`(
	IN totalAmount FLOAT,
    IN customerId INT,
    IN cardNumber VARCHAR(255),
    IN restaurantId INT
)
BEGIN 
	INSERT INTO order_placed (order_date, total_amount, customer_id,card_number, restaurant_id) 
	VALUES (CURRENT_DATE, totalAmount, customerId, cardNumber, restaurantId);
    SELECT LAST_INSERT_ID() AS order_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckFoodItemQuantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckFoodItemQuantity`(IN staffId VARCHAR(255), IN itemName VARCHAR(255))
BEGIN
    DECLARE restaurantId INT;
    DECLARE itemId INT;

    SELECT restaurant_id INTO restaurantId
    FROM staff_member
    WHERE staff_id = staffId;

    IF restaurantId IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Restaurant not found';
    ELSE
        -- Get item_id for the provided item name
        SELECT item_id INTO itemId
        FROM food_items
        WHERE item_name = itemName;

        -- Check if the item exists
        IF itemId IS NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Food item not found';
        ELSE
            -- Get the quantity of the food item for the specific restaurant
            SELECT quantity_of_food_item
            FROM food_items_restaurant
            WHERE item_id = itemId AND restaurant_id = restaurantId;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteFoodItemByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteFoodItemByName`(
    IN itemNameToDelete VARCHAR(255)
)
BEGIN
    DECLARE itemIdToDelete INT;

    SELECT item_id INTO itemIdToDelete FROM food_items WHERE item_name = itemNameToDelete;

    DELETE FROM food_items WHERE item_name = itemNameToDelete;
    DELETE FROM food_items_restaurant WHERE item_id = itemIdToDelete;

    SELECT CONCAT('Food item "', itemNameToDelete, '" deleted successfully.') AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DisplayRestaurants` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DisplayRestaurants`()
BEGIN
    SELECT restaurant_id, restaurant_name FROM restaurant;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomerOrders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerOrders`(customerId INT)
BEGIN
    SELECT op.order_id, op.order_date, op.total_amount, r.restaurant_name
    FROM order_placed op
    JOIN restaurant r ON op.restaurant_id = r.restaurant_id
    WHERE op.customer_id = customerId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetCustomerReservations` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerReservations`(IN p_customer_id INT)
BEGIN
    SELECT r.restaurant_name, res.date_reserved, da.seating_capacity, res.start_time, res.end_time
    FROM reservation res
    JOIN dining_area da ON res.table_id = da.table_id
    JOIN restaurant r ON da.restaurant_id = r.restaurant_id
    WHERE res.customer_id = p_customer_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetNonReservedTables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetNonReservedTables`(IN restaurantId INT, IN reservationDate DATE)
BEGIN
	SELECT r.table_id, d.seating_capacity, r.start_time
		FROM reservation r 
		NATURAL JOIN dining_area d
		WHERE r.area_status = 'NOT RESERVED' 
		AND d.restaurant_id = restaurantId 
		AND r.date_reserved = reservationDate;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetRestaurantManagerInformation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRestaurantManagerInformation`(IN staffId INT)
BEGIN
	DECLARE restaurantId INT;
    DECLARE managerStaffId INT;

	SELECT restaurant_id INTO restaurantId
    FROM staff_member
    WHERE staff_id = staffId;
    
    SELECT staff_id INTO managerStaffId
    FROM staff_manager
    WHERE restaurant_id = restaurantId;

    SELECT r.restaurant_name, r.open_time, r.close_time, r.street_number,r.street_name,r.state_abbreviation,r.zip_code,s.staff_first_name, s.staff_last_name
    FROM staff_manager m
    JOIN staff_member s ON m.staff_id = s.staff_id
    JOIN restaurant r ON r.restaurant_id = s.restaurant_id
    WHERE m.staff_id = managerStaffId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MakeReservation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MakeReservation`(IN customerId INT, IN tableId INT, IN reservationDate DATE, IN startTime TIME)
BEGIN
    UPDATE reservation
    SET area_status = 'RESERVED', customer_id = customerId
    WHERE table_id = tableId
      AND customer_id IS NULL
      AND date_reserved = reservationDate
      AND start_time = startTime;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateFoodItemQuantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateFoodItemQuantity`(IN staffId VARCHAR(255), IN itemName VARCHAR(255), IN itemQuantity INT)
BEGIN
    DECLARE restaurantId INT;
    DECLARE itemId INT;

    SELECT restaurant_id INTO restaurantId
    FROM staff_member
    WHERE staff_id = staffId;

    IF restaurantId IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Restaurant not found';
    ELSE
        -- Get item_id for the provided item name
        SELECT item_id INTO itemId
        FROM food_items
        WHERE item_name = itemName;

        -- Check if the item exists
        IF itemId IS NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Food item not found';
        ELSE
            -- Set the quantity of the food item for the specific restaurant
            UPDATE food_items_restaurant
            SET quantity_of_food_item = itemQuantity
            WHERE item_id = itemId AND restaurant_id = restaurantId;
            SELECT 'Success' AS result;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdatePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePassword`(
    IN p_user_type VARCHAR(10),
    IN p_username VARCHAR(255),
    IN p_old_password VARCHAR(255),
    IN p_new_password VARCHAR(255)
)
BEGIN
    DECLARE v_user_exists INT;

    -- Check if the user exists and has the correct old password
    SELECT COUNT(*) INTO v_user_exists
    FROM user_login
    WHERE user_name = p_username
        AND user_password = p_old_password;

    IF v_user_exists > 0 THEN
        -- Update the password
        UPDATE user_login
        SET user_password = p_new_password
        WHERE user_name = p_username;
        SELECT 'Success' AS result;
    ELSE
        SELECT 'InvalidCredentials' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ValidateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ValidateUser`(
    IN p_user_type VARCHAR(10),
    IN p_username VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    DECLARE v_user_exists INT;

    -- Check if the user exists and has the correct password
    SELECT COUNT(*) INTO v_user_exists
    FROM user_login
    WHERE user_name = p_username
        AND user_password = p_password;

    IF v_user_exists > 0 THEN
        -- Check if the user is of the correct type (customer or staff)
        IF (p_user_type = 'customer' AND (SELECT is_staff FROM user_login WHERE user_name = p_username) = 0) OR
           (p_user_type = 'staff' AND (SELECT is_staff FROM user_login WHERE user_name = p_username) = 1) OR
           (p_user_type = 'manager' AND (SELECT is_staff FROM user_login WHERE user_name = p_username) = 1) THEN
           SELECT 'Success' AS result;
        ELSE
            SELECT 'InvalidUserType' AS result;
        END IF;
    ELSE
        SELECT 'InvalidCredentials' AS result;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerifyPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `VerifyPayment`(
    IN customerId INT,
    IN cardNumber VARCHAR(255),
	IN expirationDate DATE
)
BEGIN
    DECLARE cardExists INT;
    -- Check if the card exists
    SELECT COUNT(*) INTO cardExists
    FROM payment_card
    WHERE customer_id = customerId AND card_number = cardNumber AND expiration_date = expirationDate;

    IF cardExists = 0 THEN
        SELECT 'Invalid Card Details' AS result;
    ELSE
        SELECT 'Success' AS result;
    END IF;
END ;;
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

-- Dump completed on 2023-12-08 18:37:04
