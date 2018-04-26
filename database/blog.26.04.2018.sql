-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.7.16 - MySQL Community Server (GPL)
-- Операционная система:         Win32
-- HeidiSQL Версия:              9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных blog
CREATE DATABASE IF NOT EXISTS `blog` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `blog`;

-- Дамп структуры для таблица blog.likes
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `post_id` int(11) unsigned DEFAULT NULL,
  `is_like` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_post_id_is_like` (`user_id`,`post_id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `FK_likes_posts` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `FK_likes_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы blog.likes: ~3 rows (приблизительно)
DELETE FROM `likes`;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` (`id`, `user_id`, `post_id`, `is_like`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 1, '2018-04-26 09:37:13', '2018-04-26 09:37:13'),
	(2, 1, 2, 1, '2018-04-26 09:37:24', '2018-04-26 09:37:24'),
	(3, 2, 2, 1, '2018-04-26 09:37:49', '2018-04-26 09:37:49');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;

-- Дамп структуры для таблица blog.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы blog.migrations: ~4 rows (приблизительно)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Дамп структуры для таблица blog.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы blog.password_resets: ~0 rows (приблизительно)
DELETE FROM `password_resets`;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Дамп структуры для таблица blog.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `intro` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `FK_posts_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы blog.posts: ~2 rows (приблизительно)
DELETE FROM `posts`;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`, `user_id`, `title`, `intro`, `body`, `created_at`, `updated_at`, `alias`, `logo`) VALUES
	(1, 1, 'Test #1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget arcu quis leo luctus semper sed ut augue. Aenean sodales, felis sit amet sodales interdum, ex neque feugiat nulla, eu fermentum metus lorem vitae ante. Aenean maximus urna eu dui vestibulum sodales. Sed aliquam diam enim. Mauris eget cursus metus. Pellentesque interdum molestie enim at porttitor. Vivamus posuere vestibulum justo, sodales commodo metus tristique vel. Donec in elit pretium, egestas erat non, varius libero.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget arcu quis leo luctus semper sed ut augue. Aenean sodales, felis sit amet sodales interdum, ex neque feugiat nulla, eu fermentum metus lorem vitae ante. Aenean maximus urna eu dui vestibulum sodales. Sed aliquam diam enim. Mauris eget cursus metus. Pellentesque interdum molestie enim at porttitor. Vivamus posuere vestibulum justo, sodales commodo metus tristique vel. Donec in elit pretium, egestas erat non, varius libero.\r\n\r\nNullam sollicitudin lobortis vulputate. Sed tincidunt fermentum felis sed laoreet. In interdum luctus ipsum vitae pharetra. Donec vel arcu vitae tortor sodales cursus. Suspendisse potenti. Nulla non posuere eros. Nullam luctus purus eget ligula euismod, eu facilisis diam varius. Ut sed tristique quam. Morbi non dolor sed ligula faucibus bibendum. Sed scelerisque quam nec magna tempor, eget bibendum lectus malesuada. Nam fringilla dolor massa, ac egestas tellus rhoncus sit amet. Aliquam magna nibh, dictum nec finibus quis, vestibulum id erat. Donec commodo ante dui, quis pharetra tellus lobortis et.', '2018-04-26 09:34:38', '2018-04-26 09:34:38', 'Test #1', 'uploads/post/1/7250eb93b3c18cc9daa29cf58af7a004.jpg'),
	(2, 1, 'Test #2 | б****к and х**ь', 'б****к and х**ь\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget arcu quis leo luctus semper sed ut augue. Aenean sodales, felis sit amet sodales interdum, ex neque feugiat nulla, eu fermentum metus lorem vitae ante. Aenean maximus urna eu dui vestibulum sodales. Sed aliquam diam enim. Mauris eget cursus metus. Pellentesque interdum molestie enim at porttitor. Vivamus posuere vestibulum justo, sodales commodo metus tristique vel. Donec in elit pretium, egestas erat non, varius libero.', 'б****к and х**ь\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget arcu quis leo luctus semper sed ut augue. Aenean sodales, felis sit amet sodales interdum, ex neque feugiat nulla, eu fermentum metus lorem vitae ante. Aenean maximus urna eu dui vestibulum sodales. Sed aliquam diam enim. Mauris eget cursus metus. Pellentesque interdum molestie enim at porttitor. Vivamus posuere vestibulum justo, sodales commodo metus tristique vel. Donec in elit pretium, egestas erat non, varius libero.\r\n\r\nNullam sollicitudin lobortis vulputate. Sed tincidunt fermentum felis sed laoreet. In interdum luctus ipsum vitae pharetra. Donec vel arcu vitae tortor sodales cursus. Suspendisse potenti. Nulla non posuere eros. Nullam luctus purus eget ligula euismod, eu facilisis diam varius. Ut sed tristique quam. Morbi non dolor sed ligula faucibus bibendum. Sed scelerisque quam nec magna tempor, eget bibendum lectus malesuada. Nam fringilla dolor massa, ac egestas tellus rhoncus sit amet. Aliquam magna nibh, dictum nec finibus quis, vestibulum id erat. Donec commodo ante dui, quis pharetra tellus lobortis et.', '2018-04-26 09:36:33', '2018-04-26 09:44:27', 'Test #2 | б****к and х**ь', 'uploads/post/2/b73ce398c39f506af761d2277d853a92.jpg');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;

-- Дамп структуры для таблица blog.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы blog.users: ~2 rows (приблизительно)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin@gmail.com', '$2y$10$D/QAEIrcRHS1a.O002dUAOzimZ50pO4f/EAUbTU93SJ1x18UVnhEW', 'T2i2SIuBmz0lklj9JvGRTKZlqqihDjwPpE3dWmvAOIpqm960zRqkABdZhV3W', '2018-04-18 07:35:09', '2018-04-18 07:35:09'),
	(2, 'test', 'test@gmail.com', '$2y$10$D/QAEIrcRHS1a.O002dUAOzimZ50pO4f/EAUbTU93SJ1x18UVnhEW', 'bxu8Q2RdvzFWwAm8hiezuqniWgXbgAcerZvtNWwGJ7oeBxOIoNmItqDJeMzm', '2018-04-18 07:35:09', '2018-04-18 07:35:09');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
