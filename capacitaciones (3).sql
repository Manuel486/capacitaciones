-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-12-2025 a las 23:27:43
-- Versión del servidor: 10.4.19-MariaDB
-- Versión de PHP: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `capacitaciones`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acceso`
--

CREATE TABLE `acceso` (
  `id_acceso` int(11) NOT NULL,
  `permiso` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `acceso`
--

INSERT INTO `acceso` (`id_acceso`, `permiso`, `descripcion`) VALUES
(1, 'mis_cursos', 'Ver sus cursos en proceso y terminados'),
(2, 'gestionar_cursos', 'Se encargará de revisar sus cursos creados'),
(3, 'tomar_curso', 'Poder ver la estructura del curso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alternativa`
--

CREATE TABLE `alternativa` (
  `id_alternativa` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_pregunta` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `contenido` text COLLATE utf8_spanish_ci NOT NULL,
  `es_respuesta` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `alternativa`
--

INSERT INTO `alternativa` (`id_alternativa`, `id_pregunta`, `contenido`, `es_respuesta`) VALUES
('ALT001', 'PRE001', 'HTML significa HyperText Markup Language (Lenguaje de Marcado de Hipertexto)', 1),
('ALT002', 'PRE001', 'Lenguaje de Marcado de Hipertexto', 0),
('ALT549a02a190747f1cbc45246b2', 'PRE7bb91d6258b9cf3e5b4d4011c', '', 1),
('ALT671d4aca0eefbb656afa65082', 'PRE3b35dad547a4635e7928bbd87', 'Alternativa 1', 0),
('ALT99ec53bcf0148ce612a307b44', 'PRE8dfe6cd6dc9484bc1ee4f7d21', 'hhhh', 1),
('ALTbad4e866f17cc612590075e30', 'PRE3b35dad547a4635e7928bbd87', 'Aalternativa 2 - Correcta', 1),
('ALTf74adc50667eb34ac4f1c92fb', 'PRE3b35dad547a4635e7928bbd87', 'Alaternativa 3', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anuncio`
--

CREATE TABLE `anuncio` (
  `id_anuncio` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_tema` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `titulo` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `anuncio` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `anuncio`
--

INSERT INTO `anuncio` (`id_anuncio`, `id_tema`, `titulo`, `descripcion`, `anuncio`, `activo`) VALUES
('ANA5ab660eaaafb80757dc7ebf48', '', 'Anuncio de prueba58558', 'descripcion del anuncio de prueba', 'contenido del anuncio de prueba', 1),
('ANUNCIO001', 'TEMA001', 'Anuncio de prueba', 'Este anuncio permitirá determinar los objetivos del sistema', 'Debe ingresar al siguiente link para poder iniciar con su evaluacion', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE `auditoria` (
  `id` int(11) NOT NULL,
  `id_usuario` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `ip_usuario` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `user_agent` varchar(150) COLLATE utf8_spanish_ci DEFAULT NULL,
  `modulo` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `accion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `metodo_http` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `url` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `tabla_afectada` varchar(70) COLLATE utf8_spanish_ci DEFAULT NULL,
  `id_afectado` varchar(30) COLLATE utf8_spanish_ci DEFAULT NULL,
  `datos_entrada` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `exito` tinyint(1) NOT NULL DEFAULT 0,
  `mensaje` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `auditoria`
--

INSERT INTO `auditoria` (`id`, `id_usuario`, `ip_usuario`, `user_agent`, `modulo`, `accion`, `metodo_http`, `url`, `tabla_afectada`, `id_afectado`, `datos_entrada`, `exito`, `mensaje`, `fecha`) VALUES
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"pruebaa\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 15:43:34'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 15:51:16'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 15:51:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 15:52:14'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 15:52:54'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 15:55:16'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 16:04:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 16:04:30'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 16:05:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasda\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 16:05:18'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 16:05:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:05:27'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:05:34'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:05:47'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 16:05:51'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 16:07:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 16:07:20'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:17:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:17:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 16:17:40'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 16:50:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:50:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:50:40'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:50:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:50:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:51:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:51:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:51:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:51:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:51:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:51:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:51:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:51:59'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:52:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:52:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:54:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:54:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:54:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:54:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:54:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:54:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:55:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:56:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:56:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:56:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:56:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:57:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:57:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:57:19'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:57:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:57:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:57:27'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 16:57:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"mchunga@sepcon.net\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 16:57:37'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 18:51:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:55:09'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:55:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:55:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:55:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:55:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:11'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:19'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:56:59'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:57:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:57:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:57:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:57:09'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 18:57:12'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 18:58:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:58:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 18:58:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsad\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 18:58:56'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 19:04:30'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 19:14:05'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 19:14:29'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 19:14:52'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsad\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 19:14:56'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 19:21:39'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 19:27:50'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 19:28:13'),
(0, 'USR001', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 19:28:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:29:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:30:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:30:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:30:34'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:30:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:30:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:30:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:31:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:31:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:31:06'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:31:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:31:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:31:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:31:55'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:31:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:32:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:32:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:32:03'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:33:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:33:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:33:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 19:33:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:33:40'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:33:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:33:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:34:00'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:34:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 19:34:27'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:34:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 19:36:40'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:36:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:38:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:38:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:39:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:39:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:39:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:39:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:47:40'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:47:43'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 19:47:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"das\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 19:47:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-04 19:47:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-04 20:17:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-04 20:28:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-04 20:28:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-04 20:28:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-04 20:28:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-04 20:28:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-04 20:29:06'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 20:30:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 20:30:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 20:36:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:36:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:36:19'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsad\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 20:36:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 20:45:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:45:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:45:55');
INSERT INTO `auditoria` (`id`, `id_usuario`, `ip_usuario`, `user_agent`, `modulo`, `accion`, `metodo_http`, `url`, `tabla_afectada`, `id_afectado`, `datos_entrada`, `exito`, `mensaje`, `fecha`) VALUES
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:45:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:47:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:47:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:47:59'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsad\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:48:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:48:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:48:19'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:48:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:48:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:48:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"asd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:48:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:48:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:49:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:49:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:49:20'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:49:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:49:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"12345678\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 20:50:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"12345678\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 20:50:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 20:50:40'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:50:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"11223344\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 20:51:00'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 20:51:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:51:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"11223344\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 20:51:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 20:52:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:52:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:07'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:09'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"ddd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:53:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:43'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:47'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:53:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:54:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:54:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:54:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:54:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:54:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:55:00'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:55:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:55:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:55:07'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:55:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"usuario de prueba\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:55:20'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:56:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsad\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-04 20:56:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:56:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:56:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:56:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:19'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:58:59'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:40'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:47'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:55'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 20:59:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:00:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"72411391\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 21:00:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 21:01:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:01:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:02:00'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"72411391\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 21:02:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 21:03:03'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:03:03'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:03:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"72411391\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 21:03:27'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 21:04:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:04:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"72411391\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 21:05:22'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 21:28:00'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:28:01'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"87654321\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 21:28:15'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 21:28:24'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:28:25'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"12345678\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 21:28:35'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-04 21:47:29'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:47:29'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:47:31'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:47:34'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-04 21:47:36'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"12345678\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-04 21:47:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin token', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:45:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:45:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:45:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin token', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:45:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:45:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:45:27'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:50:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:51:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:51:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:51:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 13:51:39'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:32:26'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:34:19'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:34:21'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:35:20'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:35:22'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:41:35'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:43:21'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:43:31'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:43:35'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:43:40'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:43:46'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:43:59'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:44:06'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:44:18'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:44:24'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:44:53'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:44:56'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:45:04'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:45:51'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:46:04'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:46:07'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:49:53'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:51:09'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:51:10'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:51:34'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:51:45'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:51:46'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:51:47'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:52:09'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:52:10'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 14:52:55'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 14:54:46'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 14:54:47'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 14:54:59'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 14:55:41'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 15:18:26'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:18:26'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Credenciales incorrectas', '2025-12-05 15:18:30'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dad\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:21:07');
INSERT INTO `auditoria` (`id`, `id_usuario`, `ip_usuario`, `user_agent`, `modulo`, `accion`, `metodo_http`, `url`, `tabla_afectada`, `id_afectado`, `datos_entrada`, `exito`, `mensaje`, `fecha`) VALUES
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dad\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:21:32'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dad\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:21:33'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:21:36'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:21:39'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:22:35'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:23:23'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:23:25'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:23:26'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:23:33'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:23:53'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:23:54'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:23:56'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:24:53'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:24:56'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: desactivado', '2025-12-05 15:25:07'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:25:26'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dsd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:25:29'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario inactivo. Por favor, contacte al administrador.', '2025-12-05 15:25:37'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario inactivo. Por favor, contacte al administrador.', '2025-12-05 15:26:13'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario inactivo. Por favor, contacte al administrador.', '2025-12-05 15:26:16'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario inactivo. Por favor, contacte al administrador.', '2025-12-05 15:26:22'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario inactivo. Por favor, contacte al administrador.', '2025-12-05 15:26:27'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario inactivo. Por favor, contacte al administrador.', '2025-12-05 15:26:28'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:26:56'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario inactivo. Por favor, contacte al administrador.', '2025-12-05 15:27:06'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"ada\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:27:14'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 15:27:30'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"machunga\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:27:39'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"dasd\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 15:27:43'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario inactivo. Por favor, contacte al administrador.', '2025-12-05 15:28:13'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 15:28:25'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 20:59:28'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 20:59:29'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 20:59:44'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 20:59:55'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 20:59:58'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:00:04'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:01:19'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:01:38'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:01:55'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:03:09'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:03:09'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-05 21:03:19'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:04:09'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:04:18'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:04:27'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:04:28'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:07:29'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:07:36'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:08:45'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:08:46'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:08:58'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:09:27'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:09:28'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:09:38'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:10:20'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:10:21'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:10:34'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:10:46'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:10:47'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:10:58'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:13:25'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:13:26'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:19:17'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:19:26'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:19:32'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:19:33'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:19:43'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-05 21:19:52'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:19:53'),
(0, '1', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-05 21:20:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:21:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin token', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: token inválido o expirado', '2025-12-05 21:21:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 13:37:19'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 13:37:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 13:39:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 13:39:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-10 13:41:20'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 13:41:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 13:41:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'gestionar_cursos', 'Vista de Gestionar Cursos sin permisos', 'GET', '/capacitaciones/gestionar_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-10 13:45:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-10 13:45:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 13:45:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 13:45:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-10 18:35:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR002', NULL, NULL, '{\"id_curso\":\"CUR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-10 18:36:06'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-10 18:36:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 18:36:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 18:36:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR002', NULL, NULL, '{\"id_curso\":\"CUR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-10 18:36:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-10 18:38:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 18:38:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 18:38:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 18:38:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 19:39:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 19:39:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-10 20:15:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 20:15:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"DEACCO\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 20:15:10'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-10 20:18:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 20:18:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 20:18:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-10 21:58:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 21:58:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 21:58:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 21:59:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 21:59:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 21:59:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 21:59:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-11 15:09:34'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-11 15:11:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-11 15:12:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-11 15:12:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-11 20:23:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-11 20:23:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-11 22:42:10'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-11 22:42:11'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 13:19:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 13:19:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 14:13:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:13:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:14:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:14:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:14:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 14:14:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 14:17:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:17:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 14:17:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:23:47'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:23:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 14:23:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 14:34:10'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:34:11'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:34:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:34:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 14:34:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 14:35:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 14:35:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 14:36:00'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 15:11:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 15:11:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 15:11:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 15:11:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 15:11:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 15:35:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 15:35:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 15:36:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 19:52:09'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 19:52:10'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 19:52:20'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 21:39:00'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 21:39:03'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 21:39:04');
INSERT INTO `auditoria` (`id`, `id_usuario`, `ip_usuario`, `user_agent`, `modulo`, `accion`, `metodo_http`, `url`, `tabla_afectada`, `id_afectado`, `datos_entrada`, `exito`, `mensaje`, `fecha`) VALUES
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 21:39:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 21:56:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 21:56:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 21:59:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 21:59:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:07:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:07:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:07:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:07:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:07:43'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:07:43'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:08:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:08:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:08:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:08:15'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:08:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:08:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 22:08:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 22:08:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 22:09:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 22:09:34'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 22:09:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 22:09:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:09:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-12 22:09:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-12 22:10:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-12 22:10:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase`
--

CREATE TABLE `clase` (
  `id_clase` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_tema` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `titulo` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `video` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `clase`
--

INSERT INTO `clase` (`id_clase`, `id_tema`, `titulo`, `descripcion`, `video`, `activo`) VALUES
('CLA001', 'TEMA001', '¿Qué es HTML?', 'Clase introductoria al lenguaje HTML.', 'VIDEO_e17e593b98bc3edfd8bacf.mp4', 1),
('CLA002', 'TEMA002', 'Uso de etiquetas básicas', 'Explicación de etiquetas.', 'VIDEO_2dc4242ec4956ae14259fc.mp4', 1),
('CLA003', 'TEMA003', 'Selectores Simples', 'Clase sobre selectores CSS.', 'VIDEO_e0735fbdcc5e677393e5c2.mp4', 0),
('CLA004', 'TEMA004', 'Conociendo al cliente', 'Clase para entender perfiles de clientes.', 'VIDEO_fd48b9914103b35319c0a5.mp4', 1),
('CLA2c7e409c5832999564dcaeb0e', '', 'clase de prueba al sistema - 9', 'dedede', 'VIDEO_1a7000a254fecab38c972b.mp4', 1),
('CLA2d1458c50a970d8bf455f9446', '', 'titulo de prueba 3', 'descripcion 3', 'VIDEO_389743c67ee0151cf1a16a.mp4', 1),
('CLA4a25572f429b49c40f92d9292', '', 'vvvv', 'vvvv', 'VIDEO_e437ff41f4ec3a5dda4237.mp4', 1),
('CLA56c8ac5bca58e9b67afa4382d', '', 'clase del tema 3', 'descripcion del tema 3', 'VIDEO_a48bf3027d64d3bcab0381.mp4', 1),
('CLA591dbba3c92b2690b135d92a9', '', 'clase 2', 'descripcion 2', 'VIDEO_010e16048f40d9736534f5.mp4', 1),
('CLA5f24847193d332de5c6ebd322', '', 'jjjj', 'jjjj', 'VIDEO_b38696aab17e0ce1b81e92.mp4', 1),
('CLA70e862ad2731c99e5e15fa1d7', '', 'titulo de prueba 3', 'descripcion 3', 'VIDEO_78c9a56f960bffe97e0ef8.mp4', 1),
('CLA8a10a2ae08e2ac59c21fb1edc', '', 'titulo de prueba 2', 'descripcion de prueba 2', 'VIDEO_12f506025695c2d10efd7b.mp4', 1),
('CLA9c89e1a1ea4903e7b056ddf50', 'TEMA003', 'titulo de clase de prueba', 'descripcion de clase de prueba', 'VIDEO_817892ddcdc9bc21e2ae07.mp4', 1),
('CLA9e0c4f21ac7d669553f64259b', '', 'clase del tema final', 'descripcion del tema final', 'VIDEO_9ab5ffc730a7adefa70d10.mp4', 1),
('CLAb3e693eef29986c7843d8ed7f', '', 'clase 1', 'descripcion 1', 'VIDEO_e8f8d3e9ef7187f9d0b426.mp4', 0),
('CLAcaf499425f189a9a6649dfd36', '', 'clase de prueba para el tema de prueba', 'descripcion de prueba para el tema de prueba', 'VIDEO_c531867e1c35c67f7852ae.mp4', 1),
('CLAd496621946a1665deed6fd4b9', '', 'clase de prueba', 'descripcion de prueba para la clase', 'VIDEO_be9eb2c75fcccd14aee21c.mp4', 1),
('CLAe2146c5140ca8990aac88a7f7', '', 'clase de prueba para el tema 2', 'descripcion de clase de prueba  para el tema 2', 'VIDEO_87dff9c892c31a59b8506f.mp4', 1),
('CLAe40c92cb1af31dd050f53801e', '', 'sdd', 'asdasd', 'VIDEO_c0aff31133b69816b87be6.mp4', 1),
('CLAe5a7ac74529a6fe29e8d31464', '', 'clase de 2222', 'dwadadad', 'VIDEO_8431d086351bb441ba141a.mp4', 1),
('CLAec08311d9bd1ac57fc532d33d', '', 'clase de prueba 3 ', 'descripcion de prueba 3', 'VIDEO_3841c2c0c70f121c547174.mp4', 1),
('CLAf165d2b337da9022fcb26d88d', '', 'ssssssssssss', 'ssssss', 'VIDEO_79db6630101e31b2325fa7.mp4', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `id_comentario` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `id_item` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `dni_usuario` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `nombre_usuario` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `comentario` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `comentario`
--

INSERT INTO `comentario` (`id_comentario`, `id_item`, `dni_usuario`, `nombre_usuario`, `comentario`, `fecha_creacion`) VALUES
('COM089a6fb50709c8c0e4e797597', 'ITEM758657f6af0a46211e3a677e', '72411391', 'CHUNGA VARGAS MANUEL ALBERTO', 'comentario de prueba', '2025-12-12 23:29:15'),
('COMe0754ce41f34561fd3221aee7', 'ITEM758657f6af0a46211e3a677e', '72411391', 'CHUNGA VARGAS MANUEL ALBERTO', 'segundo comentario de prueba del sistema', '2025-12-12 23:31:29'),
('COMb15e519a24f98ba1caed6705f', 'ITEM758657f6af0a46211e3a677e', '72411391', 'CHUNGA VARGAS MANUEL ALBERTO', 'tercer comentario del sistema', '2025-12-12 23:31:45'),
('COM49e7d491cd4809312ac38d1e7', 'ITEM5d0b26dda3d65d56eac48f6f', '72411391', 'CHUNGA VARGAS MANUEL ALBERTO', 'Primer comentario de prueba', '2025-12-12 23:33:27'),
('COM4235b2802d14f89d953ccaa18', 'ITEM758657f6af0a46211e3a677e', '72411391', 'CHUNGA VARGAS MANUEL ALBERTO', 'comentario de prueba', '2025-12-12 23:56:11'),
('COM54c1b0d88a25e64ce0535f623', 'ITEM758657f6af0a46211e3a677e', '72411391', 'CHUNGA VARGAS MANUEL ALBERTO', 'sssssss', '2025-12-12 17:57:00'),
('COMefb525bb4fc401633609cbd98', 'ITEM001', '72411391', 'CHUNGA VARGAS MANUEL ALBERTO', 'Comentario de prueba', '2025-12-12 20:49:21'),
('COM87a6b8031c07d7bb0d9710e27', 'ITEM004', '72411391', 'CHUNGA VARGAS MANUEL ALBERTO', 'comentario de prueba', '2025-12-12 21:46:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id_curso` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_ruta` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nombre` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `imagen` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `dificultad` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `fecha_edicion` date DEFAULT NULL,
  `id_autor` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `acceso_libre` int(2) NOT NULL DEFAULT 1,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`id_curso`, `id_ruta`, `nombre`, `descripcion`, `imagen`, `dificultad`, `duracion`, `fecha_edicion`, `id_autor`, `acceso_libre`, `activo`) VALUES
('CUR001', 'RUTA001', 'Curso de HTML Básico', 'Aprende los fundamentos de HTML', 'PORTADA_d7266f26c654bc1be1ad.jpg', 'BÁSICO', 5, '2024-01-10', '72411391', 0, 1),
('CUR002', 'RUTA001', 'Curso de CSS Intermedio', 'Curso para mejorar tus habilidades en CSS', 'PORTADA_864cc37a6adbe4bc7143.jpg', 'MEDIA', 6, '2024-03-15', '72411391', 1, 1),
('CUR003', 'RUTA002', 'Curso de Ventas 1', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Error fugiat, explicabo est praesentium voluptas dolorem deleniti. Fugiat ipsam soluta cumque sint ipsa quis fugit aut deleniti odio? Nostrum, consectetur excepturi.', 'PORTADA_8629d3a4aebaa1b679be.jpg', 'BÁSICO', 3, '2024-02-05', '72411391', 1, 1),
('CUR10baeb98c29c08ad8c41edd7f', 'RUTA001', 'curso de prueba', 'descripcion de prueba', '350d2ed19564c3a9e620646dec40PORTADA_.png', 'principiante', 5, NULL, '72411391', 1, 1),
('CUR56c9cd767e03dd98cc9c79b48', NULL, 'prueba4', 'descripcion4', '5a50963a3584571301a0e0d643eePORTADA_.png', 'intermedio', 4, NULL, '72411391', 0, 0),
('CUR5878f3081fe80e6028d817e0a', NULL, 'curso de html de pruebass', 'descripcion de prueba para el curso de html', 'PORTADA_35e1678bb0bcfdc4709a.jfif', 'principiante', 4, NULL, '72411391', 1, 1),
('CUR661dc0472f01c2aa3b5a2081c', NULL, 'prueba3', 'descripcion\n3', '36d5936670125dd7a8dd41b5ac70PORTADA_.jpg', 'avanzado', 4, NULL, '72411391', 1, 1),
('CURd811d2b0b7f8415cd7ea0e29a', NULL, 'Curso de prueba', 'dadasd', 'PORTADA_110559a1be66bc9ac99b.jpg', 'principiante', 4, NULL, '72411391', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_usuario`
--

CREATE TABLE `curso_usuario` (
  `id_curso_usuario` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_curso` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_usuario` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_inicio` datetime DEFAULT current_timestamp(),
  `fecha_fin` datetime DEFAULT NULL,
  `progreso` int(11) DEFAULT 0,
  `nota_final` decimal(5,2) DEFAULT NULL,
  `certificado_emitido` tinyint(1) DEFAULT 0,
  `estado` varchar(50) COLLATE utf8_spanish_ci DEFAULT 'en_progreso',
  `obligatorio` int(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `curso_usuario`
--

INSERT INTO `curso_usuario` (`id_curso_usuario`, `id_curso`, `id_usuario`, `fecha_inicio`, `fecha_fin`, `progreso`, `nota_final`, `certificado_emitido`, `estado`, `obligatorio`) VALUES
('CUU012a0db1e501bbcbdf75c6dfb', 'CUR002', '72042099', '2025-12-11 14:00:26', NULL, 0, NULL, 0, 'en_progreso', 0),
('CUU2a0ffe12e01e70443dbc19109', 'CUR002', '45290953', '2025-12-11 14:00:26', NULL, 0, NULL, 0, 'en_progreso', 0),
('CUU2d17363fca8660b40d7cc761b', 'CUR003', '72411391', '2025-12-12 10:08:42', NULL, 100, NULL, 0, 'en_progreso', 0),
('CUU2fb1b92c26f4a879e1fb31d71', 'CUR002', '72411391', '2025-12-11 14:00:27', NULL, 20, NULL, 0, 'en_progreso', 0),
('CUU3b094433dc9e2d23735c261e6', 'CURd811d2b0b7f8415cd7ea0e29a', '72411391', '2025-12-12 11:05:58', NULL, 100, NULL, 0, 'en_progreso', 0),
('CUU3c761657488b24f197ef60156', 'CUR001', '72411391', '2025-12-12 09:30:08', NULL, 100, NULL, 0, 'en_progreso', 0),
('CUU63bc24058c7ab523a57a81caf', 'CUR002', '77100151', '2025-12-11 14:00:27', NULL, 0, NULL, 0, 'en_progreso', 0),
('CUU64c217348924922d39fb334d8', 'CUR002', '77238280', '2025-12-11 14:00:26', NULL, 0, NULL, 0, 'en_progreso', 0),
('CUU90748197e84848a2ef92caf27', 'CUR002', '71169364', '2025-12-11 14:00:27', NULL, 0, NULL, 0, 'en_progreso', 0),
('CUUac9a1307d8e29215098ec0b08', 'CUR001', '43506099', '2025-12-11 13:50:05', NULL, 100, NULL, 0, 'en_progreso', 0),
('CUUd6dd17b14e08d5877b298e91a', 'CUR002', '43506099', '2025-12-11 17:39:58', NULL, 0, NULL, 0, 'en_progreso', 0),
('CUUecaecdba0f5c524138ecf792d', 'CUR002', '76478671', '2025-12-11 14:00:27', NULL, 0, NULL, 0, 'en_progreso', 0),
('CUUfcd8a35eb17a161f4e2585ec5', 'CUR002', '73830015', '2025-12-11 14:00:27', NULL, 0, NULL, 0, 'en_progreso', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_valoracion`
--

CREATE TABLE `curso_valoracion` (
  `id_valoracion` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `id_curso` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `nombre_usuario` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `valoracion` int(11) NOT NULL,
  `id_usuario` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `comentario` text COLLATE utf8_spanish_ci NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `curso_valoracion`
--

INSERT INTO `curso_valoracion` (`id_valoracion`, `id_curso`, `nombre_usuario`, `valoracion`, `id_usuario`, `comentario`, `fecha_registro`) VALUES
('CVA48cd5c69ab202265adf888152', 'CUR003', 'MANUEL ALBERTO CHUNGA VARGAS', 4, '72411391', 'Comentario de prueba', '2025-12-12 22:05:10'),
('CVA768d879aa9a08a39204bab1cd', 'CUR001', 'MANUEL ALBERTO CHUNGA VARGAS', 4, '72411391', 'Comentario de prueba', '2025-12-12 22:17:58');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion`
--

CREATE TABLE `evaluacion` (
  `id_evaluacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `titulo` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `evaluacion`
--

INSERT INTO `evaluacion` (`id_evaluacion`, `titulo`, `descripcion`, `activo`) VALUES
('EVA345ee56abaa0a79e8cc4e6572', 'da', 'da', 1),
('EVAa7dfe79334f68c3f3e8c5ae79', 'tttttt', 'tttt', 1),
('EVAb9eca6ccb634ef3f662a3071f', 'Evaluacion de prueba', 'Descripcion para la evaluación de prueba', 1),
('EVAL001', 'Evaluación de Html', 'Esta evaluación permitirá determinar el progreso del usuario dentro del sistema.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta`
--

CREATE TABLE `pregunta` (
  `id_pregunta` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_evaluacion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `contenido` text COLLATE utf8_spanish_ci NOT NULL,
  `puntaje` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `pregunta`
--

INSERT INTO `pregunta` (`id_pregunta`, `id_evaluacion`, `contenido`, `puntaje`) VALUES
('PRE001', 'EVAL001', '¿Que significa HTML?', 1),
('PRE3b35dad547a4635e7928bbd87', 'EVAb9eca6ccb634ef3f662a3071f', 'aaaa', 1),
('PRE7bb91d6258b9cf3e5b4d4011c', 'EVA345ee56abaa0a79e8cc4e6572', '', 1),
('PRE8dfe6cd6dc9484bc1ee4f7d21', 'EVAa7dfe79334f68c3f3e8c5ae79', 'ttt', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `progreso_item`
--

CREATE TABLE `progreso_item` (
  `id_progreso` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_curso_usuario` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_item` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `completado` tinyint(1) DEFAULT 0,
  `fecha_completado` datetime DEFAULT NULL,
  `tiempo_visto` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `progreso_item`
--

INSERT INTO `progreso_item` (`id_progreso`, `id_curso_usuario`, `id_item`, `completado`, `fecha_completado`, `tiempo_visto`) VALUES
('PRI0026201ee61349c7afd7be840', 'CUU2fb1b92c26f4a879e1fb31d71', 'ITEMb7b967b022762bcf02d91b07', 1, NULL, 0),
('PRI2bc0585ce27b469458f8f6192', 'CUU9e5a860c81c3fce356a623ce0', 'ITEMc26ae7f8cbef1b54b38fca36', 1, NULL, 0),
('PRI2ce601ffc13ba0f6117eda94d', 'CUU9e5a860c81c3fce356a623ce0', 'ITEM3bd3b8acfed507876297a98c', 1, NULL, 0),
('PRI38fdea21431a98c276a84851f', 'CUU77a5419a59473aad61f40fdc9', 'ITEM003', 1, NULL, 0),
('PRI506848081dbc39415f14a76c2', 'CUUa59f205f6310f06c76aa7c0d4', 'ITEM006', 1, NULL, 0),
('PRI5c262cca4018d67cca747e8a0', 'CUU3b094433dc9e2d23735c261e6', 'ITEMe69fdafa1f999fb34d5fe351', 1, NULL, 0),
('PRI5d5ac55c402e9dda8873c08a8', 'CUUac9a1307d8e29215098ec0b08', 'ITEM006', 1, NULL, 0),
('PRI6b8eef73f0ea77ec5cb52f489', 'CUU9e5a860c81c3fce356a623ce0', 'ITEMbc467097d5c60ffb765dade1', 1, NULL, 0),
('PRI6c708990d89a82a7599de7d1d', 'CUU9e5a860c81c3fce356a623ce0', 'ITEM5d0b26dda3d65d56eac48f6f', 1, NULL, 0),
('PRI70510d6a985cf58eadb8172d0', 'CUU9e5a860c81c3fce356a623ce0', 'ITEM003', 1, NULL, 0),
('PRI75e3c5b405bb9f0fb957875c0', 'CUU9e5a860c81c3fce356a623ce0', 'ITEM3c83ed49658699203db71ec4', 1, NULL, 0),
('PRI80945555904059a307a495f5d', 'CUU3c761657488b24f197ef60156', 'ITEM006', 1, NULL, 0),
('PRI8ed9633cf0ad7eb4e88781647', 'CUU3c761657488b24f197ef60156', 'ITEM005', 1, NULL, 0),
('PRI8fcedf747b3f6890b9110d622', 'CUUa59f205f6310f06c76aa7c0d4', 'ITEM001', 1, NULL, 0),
('PRI96d29f5ad18f341c52b441c84', 'CUUac9a1307d8e29215098ec0b08', 'ITEM001', 1, NULL, 0),
('PRI9787304330de76b641b9e5584', 'CUU9e5a860c81c3fce356a623ce0', 'ITEMb7b967b022762bcf02d91b07', 1, NULL, 0),
('PRI9989590c1f3fe36e9149d63e6', 'CUU2fb1b92c26f4a879e1fb31d71', 'ITEM1b76f9f716138f05c93a75f2', 1, NULL, 0),
('PRI99cdf959e7c94aeaa6b59f2ac', 'CUU3b094433dc9e2d23735c261e6', 'ITEM1f3f2a8b6e37648f7bac7928', 1, NULL, 0),
('PRI9fdd4bfd4858f90b651856a7e', 'CUU3b094433dc9e2d23735c261e6', 'ITEM758657f6af0a46211e3a677e', 1, NULL, 0),
('PRIa81b00fbda8b5e237035bf263', 'CUUac9a1307d8e29215098ec0b08', 'ITEM005', 1, NULL, 0),
('PRIaf9425b0043596dc76807ad26', 'CUU404ebe15e4d3db329c8d87b56', 'ITEM004', 1, NULL, 0),
('PRIb9d60301007ad380e27d6e41e', 'CUUa59f205f6310f06c76aa7c0d4', 'ITEM005', 1, NULL, 0),
('PRIbc603b2ba9d0d3b666fd107c7', 'CUUac9a1307d8e29215098ec0b08', 'ITEM002', 1, NULL, 0),
('PRIbf5ba661d1aaaf805a2fabd18', 'CUU3c761657488b24f197ef60156', 'ITEM002', 1, NULL, 0),
('PRIc3a3024764457baeeec7d6394', 'CUU2fb1b92c26f4a879e1fb31d71', 'ITEM7b002c86a0877f2bf88a761c', 1, NULL, 0),
('PRIc5e60dd8d54ab4bdcc55b8a78', 'CUU9e5a860c81c3fce356a623ce0', 'ITEM7502a9d61652923e4a6744a8', 1, NULL, 0),
('PRIcb68938309706f00e7e609f37', 'CUU2d17363fca8660b40d7cc761b', 'ITEM004', 1, NULL, 0),
('PRId8813cd62e7cd5526b3b2fab7', 'CUU3c761657488b24f197ef60156', 'ITEM001', 1, NULL, 0),
('PRIdf9162475b3ad6ef2f78db9e8', 'CUUa59f205f6310f06c76aa7c0d4', 'ITEM002', 1, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre`, `descripcion`) VALUES
(1, 'ROL_ADMINISTRADOR', 'Control total del sistema'),
(2, 'ROL_INSTRUCTOR', 'Creador de cursos'),
(3, 'ROL_ESTUDIANTE', 'Usuario que realiza cursos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_acceso`
--

CREATE TABLE `rol_acceso` (
  `id_rol_acceso` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_acceso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `rol_acceso`
--

INSERT INTO `rol_acceso` (`id_rol_acceso`, `id_rol`, `id_acceso`) VALUES
(1, 3, 1),
(2, 2, 2),
(3, 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ruta`
--

CREATE TABLE `ruta` (
  `id_ruta` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `imagen` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `ruta`
--

INSERT INTO `ruta` (`id_ruta`, `nombre`, `descripcion`, `imagen`, `activo`) VALUES
('RUTA001', 'Ruta de Programación', 'Ruta orientada a conceptos base de programación', NULL, 1),
('RUTA002', 'Ruta de Ventas', 'Ruta para capacitar sobre ventas y atención al cliente', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema`
--

CREATE TABLE `tema` (
  `id_tema` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_curso` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `orden` int(11) DEFAULT 0,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tema`
--

INSERT INTO `tema` (`id_tema`, `id_curso`, `nombre`, `orden`, `activo`) VALUES
('TEM1fc8b6682e1373ad07c411ddb', 'CUR002', 'tema final 6666', 6, 1),
('TEM2aab84e05a63dbda6a0576624', 'CURd811d2b0b7f8415cd7ea0e29a', 'tema 1', 1, 1),
('TEM2ab59064868bfe16a400bcfa1', 'CUR001', 'a', 3, 1),
('TEM52c4151091a9cacf17c2e827e', 'CUR002', 'tema de priueba2', 3, 1),
('TEM65d1321083b4378e721628c68', 'CUR002', 'tema de prueba del sistema', 5, 1),
('TEM7b7b98c5aa12015041caf2c37', 'CUR002', 'tema 3', 4, 1),
('TEMA001', 'CUR001', 'Introducción al HTML', 1, 1),
('TEMA002', 'CUR001', 'Etiquetas básicas', 2, 1),
('TEMA003', 'CUR002', 'Selectores CSS6666', 1, 1),
('TEMA004', 'CUR003', 'Psicología del Cliente', 1, 1),
('TEMef0790207e668ee19adee87ff', 'CUR002', 'tema de prueba', 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema_item`
--

CREATE TABLE `tema_item` (
  `id_item` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_tema` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `tipo` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_referencia` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `orden` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tema_item`
--

INSERT INTO `tema_item` (`id_item`, `id_tema`, `tipo`, `id_referencia`, `orden`) VALUES
('ITEM001', 'TEMA001', 'clase', 'CLA001', 1),
('ITEM002', 'TEMA002', 'clase', 'CLA002', 1),
('ITEM003', 'TEMA003', 'clase', 'CLA003', 1),
('ITEM004', 'TEMA004', 'clase', 'CLA004', 1),
('ITEM005', 'TEMA001', 'anuncio', 'ANUNCIO001', 2),
('ITEM006', 'TEMA001', 'evaluacion', 'EVAL001', 3),
('ITEM1b76f9f716138f05c93a75f2', 'TEM65d1321083b4378e721628c68', 'clase', 'CLA2c7e409c5832999564dcaeb0e', 1),
('ITEM1f3f2a8b6e37648f7bac7928', 'TEM2aab84e05a63dbda6a0576624', 'clase', 'CLA4a25572f429b49c40f92d9292', 3),
('ITEM295eec78dee201c59882e1e2', 'TEM2aab84e05a63dbda6a0576624', 'clase', 'CLAb3e693eef29986c7843d8ed7f', 1),
('ITEM3082d1d4f4a860885aa1f86e', 'TEMA001', 'clase', 'CLAe40c92cb1af31dd050f53801e', 4),
('ITEM33e69ac1a06095e3fa56b4ac', 'TEM52c4151091a9cacf17c2e827e', 'clase', 'CLAe2146c5140ca8990aac88a7f7', 1),
('ITEM3bd3b8acfed507876297a98c', 'TEMA003', 'clase', 'CLA8a10a2ae08e2ac59c21fb1edc', 4),
('ITEM3be2339e1937692e99a1bef2', 'TEMef0790207e668ee19adee87ff', 'clase', 'CLAcaf499425f189a9a6649dfd36', 0),
('ITEM3c83ed49658699203db71ec4', 'TEMA003', 'clase', 'CLAf165d2b337da9022fcb26d88d', 6),
('ITEM5d0b26dda3d65d56eac48f6f', 'TEMA003', 'clase', 'CLA2d1458c50a970d8bf455f9446', 3),
('ITEM7502a9d61652923e4a6744a8', 'TEMA003', 'clase', 'CLA70e862ad2731c99e5e15fa1d7', 3),
('ITEM758657f6af0a46211e3a677e', 'TEM2aab84e05a63dbda6a0576624', 'clase', 'CLA591dbba3c92b2690b135d92a9', 2),
('ITEM7b002c86a0877f2bf88a761c', 'TEM7b7b98c5aa12015041caf2c37', 'evaluacion', 'EVAb9eca6ccb634ef3f662a3071f', 2),
('ITEM87046890c5b896b6a2fcfa7f', 'TEMA003', 'clase', 'CLAd496621946a1665deed6fd4b9', 9),
('ITEM9ad3887bd1942d3b8c5e8c33', 'TEM1fc8b6682e1373ad07c411ddb', 'clase', 'CLA9e0c4f21ac7d669553f64259b', 1),
('ITEMb7b967b022762bcf02d91b07', 'TEMA003', 'anuncio', 'ANA5ab660eaaafb80757dc7ebf48', 8),
('ITEMbc467097d5c60ffb765dade1', 'TEMA003', 'clase', 'CLAec08311d9bd1ac57fc532d33d', 4),
('ITEMc09e3f46f220bd5cb8a97c7e', 'TEM7b7b98c5aa12015041caf2c37', 'clase', 'CLA56c8ac5bca58e9b67afa4382d', 1),
('ITEMc26ae7f8cbef1b54b38fca36', 'TEMA003', 'clase', 'CLAe5a7ac74529a6fe29e8d31464', 7),
('ITEMcc73f91d413d3502fefa58dd', 'TEMA001', 'evaluacion', 'EVAa7dfe79334f68c3f3e8c5ae79', 6),
('ITEMcc8c8b709cda18cf0ef1b489', 'TEMA001', 'evaluacion', 'EVA345ee56abaa0a79e8cc4e6572', 5),
('ITEMe69fdafa1f999fb34d5fe351', 'TEM2aab84e05a63dbda6a0576624', 'clase', 'CLA5f24847193d332de5c6ebd322', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `nombres` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `correo` varchar(150) COLLATE utf8_spanish_ci NOT NULL,
  `usuario` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `documento` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cargo` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `foto` varchar(255) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombres`, `apellidos`, `correo`, `usuario`, `password`, `documento`, `cargo`, `foto`, `telefono`, `activo`, `last_login`, `created_at`, `updated_at`) VALUES
('USR001', 'Juan', 'Pérez', 'juan.perez@example.com', 'JPEREZ', '123456', '12345678', 'Instructor', NULL, '987654321', 1, NULL, '2025-12-02 11:08:51', '2025-12-04 15:41:00'),
('USR002', 'María', 'López', 'maria.lopez@example.com', 'MLOPEZ', '123456', '87654321', 'Vendedora', NULL, '912345678', 1, NULL, '2025-12-02 11:08:51', '2025-12-04 15:41:31'),
('USR003', 'Carlos', 'Ramírez', 'carlos.ramirez@example.com', 'CRAMIREZ', '72411391', '72411391', 'Analista', NULL, '923456789', 1, NULL, '2025-12-02 11:08:51', '2025-12-04 16:01:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_rol`
--

CREATE TABLE `usuario_rol` (
  `id_usuario_rol` int(11) NOT NULL,
  `id_usuario` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario_rol`
--

INSERT INTO `usuario_rol` (`id_usuario_rol`, `id_usuario`, `id_rol`) VALUES
(7, '72411391', 3),
(8, '72411391', 2),
(9, '42072498', 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acceso`
--
ALTER TABLE `acceso`
  ADD PRIMARY KEY (`id_acceso`);

--
-- Indices de la tabla `alternativa`
--
ALTER TABLE `alternativa`
  ADD PRIMARY KEY (`id_alternativa`);

--
-- Indices de la tabla `anuncio`
--
ALTER TABLE `anuncio`
  ADD PRIMARY KEY (`id_anuncio`);

--
-- Indices de la tabla `clase`
--
ALTER TABLE `clase`
  ADD PRIMARY KEY (`id_clase`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`);

--
-- Indices de la tabla `curso_usuario`
--
ALTER TABLE `curso_usuario`
  ADD PRIMARY KEY (`id_curso_usuario`);

--
-- Indices de la tabla `curso_valoracion`
--
ALTER TABLE `curso_valoracion`
  ADD PRIMARY KEY (`id_valoracion`);

--
-- Indices de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD PRIMARY KEY (`id_evaluacion`);

--
-- Indices de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD PRIMARY KEY (`id_pregunta`);

--
-- Indices de la tabla `progreso_item`
--
ALTER TABLE `progreso_item`
  ADD PRIMARY KEY (`id_progreso`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `rol_acceso`
--
ALTER TABLE `rol_acceso`
  ADD PRIMARY KEY (`id_rol_acceso`);

--
-- Indices de la tabla `ruta`
--
ALTER TABLE `ruta`
  ADD PRIMARY KEY (`id_ruta`);

--
-- Indices de la tabla `tema`
--
ALTER TABLE `tema`
  ADD PRIMARY KEY (`id_tema`);

--
-- Indices de la tabla `tema_item`
--
ALTER TABLE `tema_item`
  ADD PRIMARY KEY (`id_item`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  ADD PRIMARY KEY (`id_usuario_rol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acceso`
--
ALTER TABLE `acceso`
  MODIFY `id_acceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rol_acceso`
--
ALTER TABLE `rol_acceso`
  MODIFY `id_rol_acceso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario_rol`
--
ALTER TABLE `usuario_rol`
  MODIFY `id_usuario_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
