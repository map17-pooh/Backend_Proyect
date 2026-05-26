-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 26, 2026 at 09:05 PM
-- Server version: 10.6.26-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bd_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 3, 'add_permission'),
(6, 'Can change permission', 3, 'change_permission'),
(7, 'Can delete permission', 3, 'delete_permission'),
(8, 'Can view permission', 3, 'view_permission'),
(9, 'Can add group', 2, 'add_group'),
(10, 'Can change group', 2, 'change_group'),
(11, 'Can delete group', 2, 'delete_group'),
(12, 'Can view group', 2, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add diagnostico', 11, 'add_diagnostico'),
(26, 'Can change diagnostico', 11, 'change_diagnostico'),
(27, 'Can delete diagnostico', 11, 'delete_diagnostico'),
(28, 'Can view diagnostico', 11, 'view_diagnostico'),
(29, 'Can add usuario externo', 13, 'add_usuarioexterno'),
(30, 'Can change usuario externo', 13, 'change_usuarioexterno'),
(31, 'Can delete usuario externo', 13, 'delete_usuarioexterno'),
(32, 'Can view usuario externo', 13, 'view_usuarioexterno'),
(33, 'Can add acudiente', 7, 'add_acudiente'),
(34, 'Can change acudiente', 7, 'change_acudiente'),
(35, 'Can delete acudiente', 7, 'delete_acudiente'),
(36, 'Can view acudiente', 7, 'view_acudiente'),
(37, 'Can add usuario interno', 14, 'add_usuariointerno'),
(38, 'Can change usuario interno', 14, 'change_usuariointerno'),
(39, 'Can delete usuario interno', 14, 'delete_usuariointerno'),
(40, 'Can view usuario interno', 14, 'view_usuariointerno'),
(41, 'Can add administrador', 8, 'add_administrador'),
(42, 'Can change administrador', 8, 'change_administrador'),
(43, 'Can delete administrador', 8, 'delete_administrador'),
(44, 'Can view administrador', 8, 'view_administrador'),
(45, 'Can add asesoria', 9, 'add_asesoria'),
(46, 'Can change asesoria', 9, 'change_asesoria'),
(47, 'Can delete asesoria', 9, 'delete_asesoria'),
(48, 'Can view asesoria', 9, 'view_asesoria'),
(49, 'Can add caracterizacion', 10, 'add_caracterizacion'),
(50, 'Can change caracterizacion', 10, 'change_caracterizacion'),
(51, 'Can delete caracterizacion', 10, 'delete_caracterizacion'),
(52, 'Can view caracterizacion', 10, 'view_caracterizacion'),
(53, 'Can add historial clinico', 12, 'add_historialclinico'),
(54, 'Can change historial clinico', 12, 'change_historialclinico'),
(55, 'Can delete historial clinico', 12, 'delete_historialclinico'),
(56, 'Can view historial clinico', 12, 'view_historialclinico');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'group'),
(3, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'nombre_proyecto', 'acudiente'),
(8, 'nombre_proyecto', 'administrador'),
(9, 'nombre_proyecto', 'asesoria'),
(10, 'nombre_proyecto', 'caracterizacion'),
(11, 'nombre_proyecto', 'diagnostico'),
(12, 'nombre_proyecto', 'historialclinico'),
(13, 'nombre_proyecto', 'usuarioexterno'),
(14, 'nombre_proyecto', 'usuariointerno'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-05-24 00:26:43.351239'),
(2, 'auth', '0001_initial', '2026-05-24 00:26:43.522294'),
(3, 'admin', '0001_initial', '2026-05-24 00:26:43.566760'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-05-24 00:26:43.576706'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-05-24 00:26:43.582503'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-05-24 00:26:43.615667'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-05-24 00:26:43.637106'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-05-24 00:26:43.653459'),
(9, 'auth', '0004_alter_user_username_opts', '2026-05-24 00:26:43.659479'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-05-24 00:26:43.680965'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-05-24 00:26:43.682516'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-05-24 00:26:43.688282'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-05-24 00:26:43.703145'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-05-24 00:26:43.719155'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-05-24 00:26:43.733131'),
(16, 'auth', '0011_update_proxy_permissions', '2026-05-24 00:26:43.738133'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-05-24 00:26:43.751887'),
(18, 'nombre_proyecto', '0001_initial', '2026-05-24 00:26:43.787094'),
(19, 'nombre_proyecto', '0002_usuarioexterno_auth_token_expires_at', '2026-05-24 00:26:43.799216'),
(20, 'nombre_proyecto', '0003_create_interno_administrador', '2026-05-24 00:26:43.817981'),
(21, 'nombre_proyecto', '0004_asesoria', '2026-05-24 00:26:43.841730'),
(22, 'nombre_proyecto', '0005_alter_acudiente_id_alter_administrador_id_and_more', '2026-05-24 00:26:44.385490'),
(23, 'nombre_proyecto', '0006_caracterizacion', '2026-05-24 00:26:44.436420'),
(24, 'nombre_proyecto', '0007_caracterizacion_metodo_proteccion_and_more', '2026-05-24 00:26:44.493822'),
(25, 'nombre_proyecto', '0008_caracterizacion_citologia_rectal_and_more', '2026-05-24 00:26:44.574057'),
(26, 'nombre_proyecto', '0009_historialclinico', '2026-05-24 00:26:44.608329'),
(27, 'nombre_proyecto', '0010_alter_acudiente_id_alter_administrador_id_and_more', '2026-05-24 00:26:45.033338'),
(28, 'nombre_proyecto', '0011_caracterizacion_eps_ips_sexo_biologico_citologia', '2026-05-24 00:26:45.114850'),
(29, 'nombre_proyecto', '0012_alter_acudiente_id_alter_administrador_id_and_more', '2026-05-24 00:26:45.692906'),
(30, 'nombre_proyecto', '0013_add_refresh_token_fields', '2026-05-24 00:26:45.769485'),
(31, 'nombre_proyecto', '0014_alter_acudiente_id_alter_administrador_id_and_more', '2026-05-24 00:26:46.330931'),
(32, 'sessions', '0001_initial', '2026-05-24 00:26:46.349378');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nombre_proyecto_acudiente`
--

CREATE TABLE `nombre_proyecto_acudiente` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `parentesco` varchar(100) NOT NULL,
  `usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `nombre_proyecto_acudiente`
--

INSERT INTO `nombre_proyecto_acudiente` (`id`, `nombre`, `telefono`, `parentesco`, `usuario_id`) VALUES
(1, 'Maria', '3216549879', 'Otro', 1);

-- --------------------------------------------------------

--
-- Table structure for table `nombre_proyecto_administrador`
--

CREATE TABLE `nombre_proyecto_administrador` (
  `id` bigint(20) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `nivel` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(128) NOT NULL,
  `auth_token` varchar(40) DEFAULT NULL,
  `auth_token_expires_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `refresh_token` varchar(64) DEFAULT NULL,
  `refresh_token_expires_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nombre_proyecto_asesoria`
--

CREATE TABLE `nombre_proyecto_asesoria` (
  `id` bigint(20) NOT NULL,
  `fecha` date NOT NULL,
  `hora` varchar(10) NOT NULL,
  `motivo` longtext NOT NULL,
  `estado` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nombre_proyecto_caracterizacion`
--

CREATE TABLE `nombre_proyecto_caracterizacion` (
  `id` bigint(20) NOT NULL,
  `sexo` varchar(100) NOT NULL,
  `identidad_otro` varchar(100) NOT NULL,
  `estado_civil` varchar(100) NOT NULL,
  `estrato` varchar(10) NOT NULL,
  `ocupacion` varchar(150) NOT NULL,
  `nivel_educativo` varchar(100) NOT NULL,
  `institucion_educativa` varchar(255) NOT NULL,
  `zona_residencia` varchar(50) NOT NULL,
  `municipio` varchar(100) NOT NULL,
  `num_embarazos` smallint(5) UNSIGNED DEFAULT NULL CHECK (`num_embarazos` >= 0),
  `num_partos` smallint(5) UNSIGNED DEFAULT NULL CHECK (`num_partos` >= 0),
  `num_cesareas` smallint(5) UNSIGNED DEFAULT NULL CHECK (`num_cesareas` >= 0),
  `num_abortos` smallint(5) UNSIGNED DEFAULT NULL CHECK (`num_abortos` >= 0),
  `usa_anticonceptivo` tinyint(1) DEFAULT NULL,
  `metodo_anticonceptivo` varchar(200) NOT NULL,
  `fecha_ultima_citologia` date DEFAULT NULL,
  `en_gestacion` tinyint(1) DEFAULT NULL,
  `en_lactancia` tinyint(1) DEFAULT NULL,
  `tiene_hijos` tinyint(1) DEFAULT NULL,
  `numero_hijos` smallint(5) UNSIGNED DEFAULT NULL CHECK (`numero_hijos` >= 0),
  `edades_hijos` varchar(255) NOT NULL,
  `vive_solo` tinyint(1) DEFAULT NULL,
  `red_apoyo` longtext NOT NULL,
  `dificultad_movilidad` tinyint(1) DEFAULT NULL,
  `caidas_ultimo_anio` smallint(5) UNSIGNED DEFAULT NULL CHECK (`caidas_ultimo_anio` >= 0),
  `polifarmacia` tinyint(1) DEFAULT NULL,
  `vida_sexual_activa` tinyint(1) DEFAULT NULL,
  `consume_alcohol` varchar(50) NOT NULL,
  `consume_tabaco` varchar(50) NOT NULL,
  `fecha_registro` datetime(6) NOT NULL,
  `fecha_actualizacion` datetime(6) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `metodo_proteccion` varchar(20) NOT NULL,
  `num_parejas_actuales` smallint(5) UNSIGNED DEFAULT NULL CHECK (`num_parejas_actuales` >= 0),
  `num_parejas_ultimo_anio` smallint(5) UNSIGNED DEFAULT NULL CHECK (`num_parejas_ultimo_anio` >= 0),
  `prueba_ets` tinyint(1) DEFAULT NULL,
  `citologia_rectal` tinyint(1) NOT NULL,
  `citologia_vaginal` tinyint(1) NOT NULL,
  `citologia_vph` tinyint(1) NOT NULL,
  `pareja_sexual_es` varchar(50) NOT NULL,
  `tiene_pareja` tinyint(1) DEFAULT NULL,
  `eps_ips` varchar(200) NOT NULL,
  `sexo_biologico` varchar(20) NOT NULL,
  `metodo_anticonceptivo_pareja` varchar(200) NOT NULL,
  `ha_realizado_citologia` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `nombre_proyecto_caracterizacion`
--

INSERT INTO `nombre_proyecto_caracterizacion` (`id`, `sexo`, `identidad_otro`, `estado_civil`, `estrato`, `ocupacion`, `nivel_educativo`, `institucion_educativa`, `zona_residencia`, `municipio`, `num_embarazos`, `num_partos`, `num_cesareas`, `num_abortos`, `usa_anticonceptivo`, `metodo_anticonceptivo`, `fecha_ultima_citologia`, `en_gestacion`, `en_lactancia`, `tiene_hijos`, `numero_hijos`, `edades_hijos`, `vive_solo`, `red_apoyo`, `dificultad_movilidad`, `caidas_ultimo_anio`, `polifarmacia`, `vida_sexual_activa`, `consume_alcohol`, `consume_tabaco`, `fecha_registro`, `fecha_actualizacion`, `usuario_id`, `metodo_proteccion`, `num_parejas_actuales`, `num_parejas_ultimo_anio`, `prueba_ets`, `citologia_rectal`, `citologia_vaginal`, `citologia_vph`, `pareja_sexual_es`, `tiene_pareja`, `eps_ips`, `sexo_biologico`, `metodo_anticonceptivo_pareja`, `ha_realizado_citologia`) VALUES
(1, 'No binario', '', 'Soltero/a', '3', 'estudiante', 'Secundaria', 'colegio', 'Rural', 'Agua de Dios', NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, 1, 1, '', 1, 'institucion', NULL, NULL, NULL, 1, 'N/A', 'N/A', '2026-05-24 00:44:32.006648', '2026-05-24 00:45:01.157386', 1, 'A veces', 12, 12, 1, 0, 0, 0, '', NULL, '', 'Hombre', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `nombre_proyecto_diagnostico`
--

CREATE TABLE `nombre_proyecto_diagnostico` (
  `id` bigint(20) NOT NULL,
  `diagnostico` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nombre_proyecto_historialclinico`
--

CREATE TABLE `nombre_proyecto_historialclinico` (
  `id` bigint(20) NOT NULL,
  `inicio_vida_sexual` varchar(10) NOT NULL,
  `edad_inicio_vida_sexual` varchar(10) NOT NULL,
  `tiene_pareja` varchar(10) NOT NULL,
  `pareja_sexual` varchar(50) NOT NULL,
  `numero_parejas` varchar(10) NOT NULL,
  `desea_tener_hijos` varchar(20) NOT NULL,
  `tiene_hijos` varchar(10) NOT NULL,
  `cantidad_hijos` varchar(10) NOT NULL,
  `fecha_citologia` varchar(20) NOT NULL,
  `citologia_tipo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`citologia_tipo`)),
  `gestaciones` varchar(10) NOT NULL,
  `partos` varchar(10) NOT NULL,
  `cesareas` varchar(10) NOT NULL,
  `abortos` varchar(10) NOT NULL,
  `ectopicos` varchar(10) NOT NULL,
  `hijos_nacidos_vivos` varchar(10) NOT NULL,
  `hijos_nacidos_muertos` varchar(10) NOT NULL,
  `ha_usado_metodo` varchar(10) NOT NULL,
  `metodo_usado` varchar(100) NOT NULL,
  `experiencia_metodo` varchar(50) NOT NULL,
  `experiencia_observacion` longtext NOT NULL,
  `metodos_utilizados` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`metodos_utilizados`)),
  `usa_metodo_actual` varchar(10) NOT NULL,
  `metodo_actual` varchar(100) NOT NULL,
  `tiempo_metodo_actual` varchar(100) NOT NULL,
  `necesidades_orientacion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`necesidades_orientacion`)),
  `otro_tema_orientacion` varchar(255) NOT NULL,
  `antecedentes_personales` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`antecedentes_personales`)),
  `otra_enfermedad` varchar(255) NOT NULL,
  `fecha_registro` datetime(6) NOT NULL,
  `fecha_actualizacion` datetime(6) NOT NULL,
  `usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nombre_proyecto_usuarioexterno`
--

CREATE TABLE `nombre_proyecto_usuarioexterno` (
  `id` bigint(20) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `tipo_documento` varchar(100) NOT NULL,
  `numero_documento` varchar(100) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(50) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(128) NOT NULL,
  `es_menor_14` tinyint(1) NOT NULL,
  `auth_token` varchar(40) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `auth_token_expires_at` datetime(6) DEFAULT NULL,
  `refresh_token` varchar(64) DEFAULT NULL,
  `refresh_token_expires_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `nombre_proyecto_usuarioexterno`
--

INSERT INTO `nombre_proyecto_usuarioexterno` (`id`, `nombre_completo`, `tipo_documento`, `numero_documento`, `fecha_nacimiento`, `telefono`, `direccion`, `email`, `password`, `es_menor_14`, `auth_token`, `created_at`, `auth_token_expires_at`, `refresh_token`, `refresh_token_expires_at`) VALUES
(1, 'maria', 'Tarjeta de Identidad', '123456523', '2012-12-23', '3333333', 'mnb', 'prueba@prueba.prueba', 'pbkdf2_sha256$1200000$2XkfLIUpVlL9WotuU0gakH$e3uykAzf+ajf2pGdnItKCdxLMg1usXrO4BbKYhAvLLE=', 1, '7bf48cccad030b7562b74fbc29e24d925c6d78bc', '2026-05-24 00:30:48.378226', '2026-05-24 01:09:53.038635', '9d3fbd7a881c7964b905cc596782452a1908e4a3d76e04faa69ded5e8704f250', '2026-05-31 00:54:53.038645');

-- --------------------------------------------------------

--
-- Table structure for table `nombre_proyecto_usuariointerno`
--

CREATE TABLE `nombre_proyecto_usuariointerno` (
  `id` bigint(20) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `puesto` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(128) NOT NULL,
  `auth_token` varchar(40) DEFAULT NULL,
  `auth_token_expires_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `refresh_token` varchar(64) DEFAULT NULL,
  `refresh_token_expires_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `nombre_proyecto_acudiente`
--
ALTER TABLE `nombre_proyecto_acudiente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`);

--
-- Indexes for table `nombre_proyecto_administrador`
--
ALTER TABLE `nombre_proyecto_administrador`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `auth_token` (`auth_token`),
  ADD UNIQUE KEY `refresh_token` (`refresh_token`);

--
-- Indexes for table `nombre_proyecto_asesoria`
--
ALTER TABLE `nombre_proyecto_asesoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nombre_proyecto_asesoria_usuario_id_01121c71_fk` (`usuario_id`);

--
-- Indexes for table `nombre_proyecto_caracterizacion`
--
ALTER TABLE `nombre_proyecto_caracterizacion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`);

--
-- Indexes for table `nombre_proyecto_diagnostico`
--
ALTER TABLE `nombre_proyecto_diagnostico`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nombre_proyecto_historialclinico`
--
ALTER TABLE `nombre_proyecto_historialclinico`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario_id` (`usuario_id`);

--
-- Indexes for table `nombre_proyecto_usuarioexterno`
--
ALTER TABLE `nombre_proyecto_usuarioexterno`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `auth_token` (`auth_token`),
  ADD UNIQUE KEY `refresh_token` (`refresh_token`);

--
-- Indexes for table `nombre_proyecto_usuariointerno`
--
ALTER TABLE `nombre_proyecto_usuariointerno`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `auth_token` (`auth_token`),
  ADD UNIQUE KEY `refresh_token` (`refresh_token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `nombre_proyecto_acudiente`
--
ALTER TABLE `nombre_proyecto_acudiente`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nombre_proyecto_administrador`
--
ALTER TABLE `nombre_proyecto_administrador`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nombre_proyecto_asesoria`
--
ALTER TABLE `nombre_proyecto_asesoria`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nombre_proyecto_caracterizacion`
--
ALTER TABLE `nombre_proyecto_caracterizacion`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nombre_proyecto_diagnostico`
--
ALTER TABLE `nombre_proyecto_diagnostico`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nombre_proyecto_historialclinico`
--
ALTER TABLE `nombre_proyecto_historialclinico`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nombre_proyecto_usuarioexterno`
--
ALTER TABLE `nombre_proyecto_usuarioexterno`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `nombre_proyecto_usuariointerno`
--
ALTER TABLE `nombre_proyecto_usuariointerno`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `nombre_proyecto_acudiente`
--
ALTER TABLE `nombre_proyecto_acudiente`
  ADD CONSTRAINT `nombre_proyecto_acudiente_usuario_id_4ea725ee_fk` FOREIGN KEY (`usuario_id`) REFERENCES `nombre_proyecto_usuarioexterno` (`id`);

--
-- Constraints for table `nombre_proyecto_asesoria`
--
ALTER TABLE `nombre_proyecto_asesoria`
  ADD CONSTRAINT `nombre_proyecto_asesoria_usuario_id_01121c71_fk` FOREIGN KEY (`usuario_id`) REFERENCES `nombre_proyecto_usuarioexterno` (`id`);

--
-- Constraints for table `nombre_proyecto_caracterizacion`
--
ALTER TABLE `nombre_proyecto_caracterizacion`
  ADD CONSTRAINT `nombre_proyecto_caracterizacion_usuario_id_bec06bef_fk` FOREIGN KEY (`usuario_id`) REFERENCES `nombre_proyecto_usuarioexterno` (`id`);

--
-- Constraints for table `nombre_proyecto_historialclinico`
--
ALTER TABLE `nombre_proyecto_historialclinico`
  ADD CONSTRAINT `nombre_proyecto_historialclinico_usuario_id_7715d464_fk` FOREIGN KEY (`usuario_id`) REFERENCES `nombre_proyecto_usuarioexterno` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
