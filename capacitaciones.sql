-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-12-2025 a las 07:02:17
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
(3, 'tomar_curso', 'Llevar el curso');

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
('ALT002', 'PRE001', 'Lenguaje de Marcado de Hipertexto', 0);

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
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:15:11'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:15:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:15:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:16:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:16:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:18:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:18:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:18:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:03'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:06'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:09'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:11'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:19:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:20:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:19'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:27'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:47'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:21:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:23:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:32:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 16:32:59'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 16:54:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:54:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:54:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:54:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:03'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:07'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:09'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:55:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 16:56:07'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 16:56:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:03:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:03:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:03:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:04:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:04:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-06 17:04:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:05:06'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:07:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:07:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:07:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:08:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:08:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:08:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:09:07'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:10:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:10:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:10:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:12:06'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:12:06'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:12:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:31:20'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:31:20'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:31:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:35:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:35:18'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:35:27');
INSERT INTO `auditoria` (`id`, `id_usuario`, `ip_usuario`, `user_agent`, `modulo`, `accion`, `metodo_http`, `url`, `tabla_afectada`, `id_afectado`, `datos_entrada`, `exito`, `mensaje`, `fecha`) VALUES
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:39:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:39:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:40:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:40:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:40:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:40:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:40:55'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:41:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:41:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'GET', '/capacitaciones/api/curso_estructura?id_curso=CUR002', NULL, NULL, '{\"id_curso\":\"CUR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:41:43'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR002', NULL, NULL, '{\"id_curso\":\"CUR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:43:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:43:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:43:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:43:27'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:43:29'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR003', NULL, NULL, '{\"id_curso\":\"CUR003\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:43:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:43:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:46:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:46:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:47:10'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:47:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:43'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:45'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:55'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:49:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:50:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:50:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:50:47'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:50:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 17:59:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 17:59:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 17:59:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:59:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:59:47'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:59:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:59:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:59:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 17:59:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 18:20:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 18:20:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 18:20:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:55'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:20:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:25:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:25:03'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:25:55'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/mis_cursos', NULL, NULL, '[]', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:26:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 18:29:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 18:29:38'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 0, 'Intento fallido de inicio de sesión: Usuario o contraseña incorrectos.', '2025-12-06 18:29:47'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 18:29:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'curso', 'Obtener estructura del curso sin permisos', 'POST', '/capacitaciones/api/mis_cursos', NULL, NULL, '{\"id_usuario\":\"USR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-06 18:29:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-06 18:57:07'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 18:57:07'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 18:57:08'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-06 18:57:14'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-06 18:57:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-07 01:13:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR002', NULL, NULL, '{\"id_curso\":\"CUR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-07 01:13:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR002', NULL, NULL, '{\"id_curso\":\"CUR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-07 01:14:00'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR001', NULL, NULL, '{\"id_curso\":\"CUR001\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-07 01:17:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'tomar_curso', 'Vista de Tomar Curso sin permisos', 'GET', '/capacitaciones/tomar_curso?id_curso=CUR002', NULL, NULL, '{\"id_curso\":\"CUR002\"}', 0, 'Acceso denegado: no tiene permisos requeridos', '2025-12-07 01:17:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-07 01:18:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:18:40'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-07 01:18:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-07 01:18:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:18:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-07 01:18:59'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-07 01:54:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:54:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:55:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:55:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:56:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:56:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:56:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:56:07'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:56:09'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-07 01:56:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-07 01:56:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 01:56:35'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-07 01:56:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-07 04:24:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 04:24:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 04:24:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 04:25:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-07 04:25:49'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:27:40'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:27:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:27:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:27:43'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:27:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:28:42'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:30:11'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:34:23'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:34:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:35:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:35:54'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:36:00'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:36:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:36:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:36:24'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:36:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:36:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-07 12:36:37'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-07 12:36:48'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:29'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:34'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:34'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:36'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:39'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:03:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:07:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:07:22'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:08:57'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:08:58'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:08:59'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:09:01'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-08 15:09:12'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-08 15:13:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:13:53'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:14:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:14:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:14:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:14:20'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:14:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 15:14:34'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-08 15:14:50'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Logout', 'GET', '/capacitaciones/logout', NULL, NULL, '[]', 1, 'El responsable cerró sesión correctamente.', '2025-12-08 17:45:05');
INSERT INTO `auditoria` (`id`, `id_usuario`, `ip_usuario`, `user_agent`, `modulo`, `accion`, `metodo_http`, `url`, `tabla_afectada`, `id_afectado`, `datos_entrada`, `exito`, `mensaje`, `fecha`) VALUES
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 17:45:05'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 17:45:13'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 17:45:16'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-08 17:45:17'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-08 17:45:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 02:24:02'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 02:24:03'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 02:24:04'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 02:25:51'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 02:25:52'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 02:25:55'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 02:25:56'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 02:25:59'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:25'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:26'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:27'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:28'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:30'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:31'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:32'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-09 14:51:33'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-09 14:51:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 05:26:21'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 05:54:29'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 05:54:41'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 05:54:43'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 05:54:44'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 05:54:46'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Verificar Token sin token', 'GET', '/capacitaciones/verificar_token', NULL, NULL, '[]', 0, 'Acceso denegado: token inválido o expirado', '2025-12-10 05:58:29'),
(0, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'autenticacion', 'Login', 'POST', '/capacitaciones/login', NULL, NULL, '{\"usuario\":\"MACHUNGA\",\"password\":\"[PROTEGIDO]\"}', 1, 'Inicio de sesión exitoso del responsable.', '2025-12-10 05:58:41');

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
('CLA001', 'TEMA001', '¿Qué es HTML?', 'Clase introductoria al lenguaje HTML.', 'video1.mp4', 1),
('CLA002', 'TEMA002', 'Uso de etiquetas básicas', 'Explicación de etiquetas.', 'video2.mp4', 1),
('CLA003', 'TEMA003', 'Selectores Simples', 'Clase sobre selectores CSS.', 'video3.mp4', 1),
('CLA004', 'TEMA004', 'Conociendo al cliente', 'Clase para entender perfiles de clientes.', 'video4.mp4', 1);

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
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`id_curso`, `id_ruta`, `nombre`, `descripcion`, `imagen`, `dificultad`, `duracion`, `fecha_edicion`, `id_autor`, `activo`) VALUES
('CUR001', 'RUTA001', 'Curso de HTML Básico', 'Aprende los fundamentos de HTML', NULL, 'BÁSICO', 5, '2024-01-10', 'USR001', 1),
('CUR002', 'RUTA001', 'Curso de CSS Intermedio', 'Curso para mejorar tus habilidades en CSS', NULL, 'MEDIA', 6, '2024-03-15', 'USR001', 1),
('CUR003', 'RUTA002', 'Curso de Ventas 1', 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Error fugiat, explicabo est praesentium voluptas dolorem deleniti. Fugiat ipsam soluta cumque sint ipsa quis fugit aut deleniti odio? Nostrum, consectetur excepturi.', NULL, 'BÁSICO', 3, '2024-02-05', 'USR002', 1);

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
  `estado` varchar(50) COLLATE utf8_spanish_ci DEFAULT 'en_progreso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `curso_usuario`
--

INSERT INTO `curso_usuario` (`id_curso_usuario`, `id_curso`, `id_usuario`, `fecha_inicio`, `fecha_fin`, `progreso`, `nota_final`, `certificado_emitido`, `estado`) VALUES
('CUU404ebe15e4d3db329c8d87b56', 'CUR003', 'pe_6818d43784206', '2025-12-05 10:13:50', NULL, 100, NULL, 0, 'en_progreso'),
('CUU77a5419a59473aad61f40fdc9', 'CUR002', 'pe_6818d43784206', '2025-12-05 10:14:29', NULL, 100, NULL, 0, 'en_progreso'),
('CUUde3ca6b1ba19c1d0f709ce97a', 'CUR001', 'pe_6818d43784206', '2025-12-06 11:56:25', NULL, 25, NULL, 0, 'en_progreso');

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
('PRE001', 'EVAL001', '¿Que significa HTML?', 1);

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
('PRI1166c6066fc3f6160b1155f34', 'CUUde3ca6b1ba19c1d0f709ce97a', 'ITEM001', 1, NULL, 0),
('PRI38fdea21431a98c276a84851f', 'CUU77a5419a59473aad61f40fdc9', 'ITEM003', 0, NULL, 0),
('PRI7444437c2e754d0ffe0685ec8', 'CUUde3ca6b1ba19c1d0f709ce97a', 'ITEM006', 0, NULL, 0),
('PRIa792b0c5f8fe1428f1275b128', 'CUU404ebe15e4d3db329c8d87b56', 'ITEM004', 0, NULL, 0),
('PRIe3f9398ca5c3a35720b843770', 'CUUde3ca6b1ba19c1d0f709ce97a', 'ITEM005', 0, NULL, 0),
('PRIeeaadc56a35b5c182de9578f8', 'CUUde3ca6b1ba19c1d0f709ce97a', 'ITEM002', 0, NULL, 0);

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
('TEMA001', 'CUR001', 'Introducción al HTML', 1, 1),
('TEMA002', 'CUR001', 'Etiquetas básicas', 2, 1),
('TEMA003', 'CUR002', 'Selectores CSS', 1, 1),
('TEMA004', 'CUR003', 'Psicología del Cliente', 1, 1);

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
('ITEM006', 'TEMA001', 'evaluacion', 'EVAL001', 3);

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
(8, '72411391', 2),
(9, '72411391', 3);

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
