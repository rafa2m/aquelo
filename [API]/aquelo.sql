-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 22, 2018 at 05:10 PM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 5.6.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aquelo`
--
CREATE DATABASE IF NOT EXISTS `aquelo` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `aquelo`;

-- --------------------------------------------------------

--
-- Table structure for table `Activacion`
--

CREATE TABLE `Activacion` (
  `fechahora` datetime NOT NULL COMMENT 'Fecha y hora en que se produce la activación',
  `fecharegla` datetime NOT NULL COMMENT 'Fecha de la regla de activación asociada',
  `idactivador` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tipoactivador` bigint(20) NOT NULL,
  `marcaactivador` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modeloactivador` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `zona` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Activador`
--

CREATE TABLE `Activador` (
  `id` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tipo` bigint(20) NOT NULL,
  `marca` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `modelo` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `tipo_comunicacion` int(11) DEFAULT NULL COMMENT 'Tipo de comunicacion: analógica o digital',
  `canal` int(11) DEFAULT NULL COMMENT 'Canal al que está conectado el activador a la estación (Arduino)',
  `estado` int(11) NOT NULL DEFAULT '1' COMMENT 'Estado del activador: activo o inactivo (0)',
  `potencia_soportada` varchar(45) DEFAULT NULL COMMENT 'Potencia de trabajo en mW',
  `idzona` varchar(60) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL COMMENT 'Identificador de la zona donde está instalado el activador',
  `observacion` varchar(300) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `Activador`
--

INSERT INTO `Activador` (`id`, `tipo`, `marca`, `modelo`, `tipo_comunicacion`, `canal`, `estado`, `potencia_soportada`, `idzona`, `observacion`) VALUES
('SRD-05VDC-SL-C', 2, 'NIUKETAT', 'SRD-05VDC-SL-C', 0, 7, 1, '5V', 'Zona_1', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Actuador`
--

CREATE TABLE `Actuador` (
  `id` varchar(30) NOT NULL,
  `nombre` varchar(60) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tipo` bigint(20) NOT NULL,
  `marca` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modelo` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `zona` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Actuador`
--

INSERT INTO `Actuador` (`id`, `nombre`, `tipo`, `marca`, `modelo`, `zona`) VALUES
('EV01', 'Electroválvula-01', 3, 'Leroy Merlin', 'EV1209', 'ZONA_1');

-- --------------------------------------------------------

--
-- Table structure for table `Calendario`
--

CREATE TABLE `Calendario` (
  `fecha_inicio` datetime NOT NULL,
  `id` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tipo` bigint(20) NOT NULL,
  `marca` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modelo` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `fecha_fin` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Calendario`
--

INSERT INTO `Calendario` (`fecha_inicio`, `id`, `tipo`, `marca`, `modelo`, `fecha_fin`) VALUES
('2018-04-19 16:00:00', 'SRD-05VDC-SL-C', 2, '---', '---', '2018-04-19 17:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `ConfiguracionSensor`
--

CREATE TABLE `ConfiguracionSensor` (
  `fechahora` datetime NOT NULL,
  `id` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tipo` bigint(20) NOT NULL,
  `marca` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modelo` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `idestacion` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL DEFAULT '' COMMENT 'Identificador de la estación al que se asocia la configuración',
  `altura` double NOT NULL COMMENT 'Altura a la que está instalado (metros)',
  `calibracion` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL COMMENT 'Datos de calibración del fabricante',
  `offset` float DEFAULT NULL COMMENT 'Datos de calibración del fabricante',
  `slope` float DEFAULT NULL COMMENT 'Datos de calibración del fabricante',
  `fechafinconfig` datetime DEFAULT NULL COMMENT 'Fecha en la que concluye una configuración (null es la configuración actual)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `ConfiguracionSensor`
--

INSERT INTO `ConfiguracionSensor` (`fechahora`, `id`, `tipo`, `marca`, `modelo`, `idestacion`, `altura`, `calibracion`, `offset`, `slope`, `fechafinconfig`) VALUES
('2018-04-20 00:00:00', 'OBSoil-01', 1, 'Soil Humidity Sensor', 'OBSoil-01', 'STCN1', 56, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Estacion`
--

CREATE TABLE `Estacion` (
  `id` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `longitud` float NOT NULL,
  `latitud` float NOT NULL,
  `altura` float NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `nombre_corto` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `observacion` varchar(300) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `altitud` float NOT NULL,
  `idlogger` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Identificador del microcontralador que toma las medidas de los sensores (arduino)'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `Estacion`
--

INSERT INTO `Estacion` (`id`, `longitud`, `latitud`, `altura`, `fecha`, `nombre_corto`, `observacion`, `altitud`, `idlogger`) VALUES
('STCN1', -5.2754, 37.6912, 56, '2018-04-19 17:16:00', 'estación_1', 'Estación para el proyecto integrado, Aquelos', 56, 'Arduino uno');

-- --------------------------------------------------------

--
-- Table structure for table `MedidaSensor`
--

CREATE TABLE `MedidaSensor` (
  `fecha_medida` datetime NOT NULL,
  `nombre` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Nombre corto de la medida',
  `fechaconfigsensor` datetime NOT NULL COMMENT 'Fecha de configuración del sensor asociada',
  `idsensor` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tiposensor` bigint(20) NOT NULL,
  `marcasensor` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modelosensor` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `idestacion` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `valor` decimal(9,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `ModeloDispositivo`
--

CREATE TABLE `ModeloDispositivo` (
  `id_tipo` bigint(20) NOT NULL,
  `marca` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modelo` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `observacion` varchar(300) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `ModeloDispositivo`
--

INSERT INTO `ModeloDispositivo` (`id_tipo`, `marca`, `modelo`, `observacion`) VALUES
(1, 'Soil Humidity Sensor', 'OBSoil-01', 'Sensor de humedad de tierra'),
(2, 'NIUKETAT', 'SRD-05VDC-SL-C', 'Rele de Rafa'),
(3, 'Leroy Merlin', 'EV1209', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ReglaActivacion`
--

CREATE TABLE `ReglaActivacion` (
  `fecha_creada` datetime NOT NULL,
  `idactivador` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tipoactivador` bigint(20) NOT NULL,
  `marcaactivador` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modeloactivador` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `secuencial` bit(1) NOT NULL COMMENT 'Indica si es secuencial o no (0)',
  `estado` int(11) NOT NULL DEFAULT '1' COMMENT 'Estado de la regla de activación (1 Activa)',
  `duracion` float NOT NULL COMMENT 'Tiempo que la regla activa al activador',
  `nombremedida` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Nombre la medida del sensor con que esta asociada la regla',
  `fechaconfigsensor` datetime NOT NULL,
  `idsensor` varchar(60) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tiposensor` bigint(20) NOT NULL,
  `marcasensor` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modelosensor` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `idestacion` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `observacion` varchar(500) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `Sensor`
--

CREATE TABLE `Sensor` (
  `id` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `tipo` bigint(20) NOT NULL,
  `marca` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `modelo` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL DEFAULT '',
  `idestacion` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `observacion` varchar(300) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `tipo_comunicacion` int(11) DEFAULT NULL COMMENT 'Digital o analógica',
  `canal` varchar(11) DEFAULT NULL COMMENT 'Canal al que está conectado en el datalogger (arduino)',
  `estado` int(11) NOT NULL DEFAULT '0' COMMENT 'Activo o inactivo',
  `potencia_soportada` varchar(45) DEFAULT NULL COMMENT 'Potencia de trabajo según el fabricante',
  `idzona` varchar(60) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL COMMENT 'Sólo para aquelo, emecubo debe quitar este campo'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `Sensor`
--

INSERT INTO `Sensor` (`id`, `tipo`, `marca`, `modelo`, `idestacion`, `observacion`, `tipo_comunicacion`, `canal`, `estado`, `potencia_soportada`, `idzona`) VALUES
('bryan', 1, 'Soil Humidity Sensor', 'OBSoil-01', 'STCN1', 'prueba', 9, '1', 0, '26v', 'zona3'),
('OBSoil-01', 1, 'Soil Humidity Sensor', 'OBSoil-01', 'STCN1', 'puede leer la cantidad de humedad presente en el suelo que lo rodea. Ideal para monitorear un jardín urbano, o el nivel de agua de su plantas', 1, 'A1', 1, '3.3  -   5   V ', 'Zona_1');

-- --------------------------------------------------------

--
-- Table structure for table `TipoDispositivo`
--

CREATE TABLE `TipoDispositivo` (
  `id_tipo` bigint(20) NOT NULL,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `observacion` varchar(300) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `TipoDispositivo`
--

INSERT INTO `TipoDispositivo` (`id_tipo`, `nombre`, `observacion`) VALUES
(1, 'Sensor', NULL),
(2, 'Rele', NULL),
(3, 'Electroválvula', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `TipoMedidaSensor`
--

CREATE TABLE `TipoMedidaSensor` (
  `nombre` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL COMMENT 'Nombre corto de la medida (Ejemplo: sa1)',
  `fechaconfigsensor` datetime NOT NULL,
  `idsensor` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `idtiposensor` bigint(20) NOT NULL,
  `marcasensor` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `modelosensor` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `idestacion` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `nombre_descriptivo` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL COMMENT 'Nombre largo de la medida (Ejemplo: velocidad media)',
  `dimension` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL COMMENT 'Unidad de medida',
  `valor_max` decimal(9,3) DEFAULT NULL COMMENT 'Valor máximo indicado por el fabricante',
  `valor_min` decimal(9,3) DEFAULT NULL COMMENT 'Valor mínimo indicado por el fabricante',
  `valores_error` varchar(255) DEFAULT NULL COMMENT 'Lista de errores tipificados separados con '','' ',
  `observacion` varchar(300) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `TipoMedidaSensor`
--

INSERT INTO `TipoMedidaSensor` (`nombre`, `fechaconfigsensor`, `idsensor`, `idtiposensor`, `marcasensor`, `modelosensor`, `idestacion`, `nombre_descriptivo`, `dimension`, `valor_max`, `valor_min`, `valores_error`, `observacion`) VALUES
('H', '2018-04-20 00:00:00', 'OBSoil-01', 1, 'Soil Humidity Sensor', 'OBSoil-01', 'STCN1', 'Recoge del sensor de tierra', 'porcentajes', NULL, NULL, 'Fuera del rango', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Activacion`
--
ALTER TABLE `Activacion`
  ADD PRIMARY KEY (`fechahora`,`fecharegla`,`idactivador`,`tipoactivador`,`marcaactivador`,`modeloactivador`),
  ADD KEY `fecharegla` (`fecharegla`,`idactivador`,`tipoactivador`,`marcaactivador`,`modeloactivador`),
  ADD KEY `idactivador` (`idactivador`),
  ADD KEY `tipoactivador` (`tipoactivador`);

--
-- Indexes for table `Activador`
--
ALTER TABLE `Activador`
  ADD PRIMARY KEY (`id`,`tipo`,`marca`,`modelo`),
  ADD KEY `id_zona` (`idzona`),
  ADD KEY `id_zona_2` (`idzona`),
  ADD KEY `tipo` (`tipo`,`marca`,`modelo`);

--
-- Indexes for table `Actuador`
--
ALTER TABLE `Actuador`
  ADD KEY `tipo` (`tipo`,`marca`,`modelo`),
  ADD KEY `tipo_2` (`tipo`,`marca`,`modelo`);

--
-- Indexes for table `Calendario`
--
ALTER TABLE `Calendario`
  ADD PRIMARY KEY (`fecha_inicio`,`id`,`tipo`,`marca`,`modelo`,`fecha_fin`),
  ADD UNIQUE KEY `fecha_inicio` (`fecha_inicio`,`id`,`tipo`,`marca`,`modelo`,`fecha_fin`),
  ADD UNIQUE KEY `fecha_inicio_2` (`fecha_inicio`,`id`,`tipo`,`marca`,`modelo`,`fecha_fin`),
  ADD KEY `id` (`id`),
  ADD KEY `tipo` (`tipo`,`marca`,`modelo`);

--
-- Indexes for table `ConfiguracionSensor`
--
ALTER TABLE `ConfiguracionSensor`
  ADD PRIMARY KEY (`fechahora`,`id`,`tipo`,`marca`,`modelo`,`idestacion`),
  ADD KEY `id` (`id`,`tipo`),
  ADD KEY `id_2` (`id`,`tipo`,`marca`,`modelo`),
  ADD KEY `id_3` (`id`,`tipo`,`marca`,`modelo`),
  ADD KEY `id_4` (`id`,`tipo`,`marca`,`modelo`,`idestacion`);

--
-- Indexes for table `Estacion`
--
ALTER TABLE `Estacion`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `MedidaSensor`
--
ALTER TABLE `MedidaSensor`
  ADD PRIMARY KEY (`fecha_medida`,`fechaconfigsensor`,`nombre`,`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`,`idestacion`),
  ADD KEY `fechaconfigsensor` (`fechaconfigsensor`);

--
-- Indexes for table `ModeloDispositivo`
--
ALTER TABLE `ModeloDispositivo`
  ADD PRIMARY KEY (`id_tipo`,`marca`,`modelo`);

--
-- Indexes for table `ReglaActivacion`
--
ALTER TABLE `ReglaActivacion`
  ADD PRIMARY KEY (`fecha_creada`,`idactivador`,`tipoactivador`,`modeloactivador`,`marcaactivador`),
  ADD KEY `id_activador` (`idactivador`,`tipoactivador`,`marcasensor`,`modeloactivador`),
  ADD KEY `id_activador_2` (`idactivador`,`tipoactivador`,`marcasensor`,`modeloactivador`),
  ADD KEY `idsensor` (`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`,`nombremedida`,`fechaconfigsensor`),
  ADD KEY `idsensor_2` (`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`,`nombremedida`,`fechaconfigsensor`),
  ADD KEY `idsensor_3` (`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`,`nombremedida`,`fechaconfigsensor`),
  ADD KEY `idsensor_4` (`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`,`nombremedida`,`fechaconfigsensor`),
  ADD KEY `idsensor_5` (`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`,`nombremedida`,`fechaconfigsensor`),
  ADD KEY `nombremedida` (`nombremedida`,`fechaconfigsensor`,`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`),
  ADD KEY `idactivador` (`idactivador`,`tipoactivador`,`marcaactivador`,`modeloactivador`),
  ADD KEY `fecha_creada` (`fecha_creada`,`idactivador`,`tipoactivador`,`marcaactivador`,`modeloactivador`),
  ADD KEY `fecha_creada_2` (`fecha_creada`,`idactivador`,`tipoactivador`,`marcaactivador`,`modeloactivador`),
  ADD KEY `fecha_creada_3` (`fecha_creada`,`idactivador`,`tipoactivador`,`marcaactivador`,`modeloactivador`),
  ADD KEY `nombremedida_2` (`nombremedida`,`fechaconfigsensor`,`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`,`idestacion`);

--
-- Indexes for table `Sensor`
--
ALTER TABLE `Sensor`
  ADD PRIMARY KEY (`id`,`tipo`,`modelo`,`marca`,`idestacion`),
  ADD KEY `id` (`id`,`tipo`,`marca`,`modelo`),
  ADD KEY `id_2` (`id`,`tipo`,`marca`,`modelo`),
  ADD KEY `tipo` (`tipo`,`marca`,`modelo`),
  ADD KEY `idestacion` (`idestacion`),
  ADD KEY `id_3` (`id`,`tipo`,`marca`,`modelo`,`idestacion`);

--
-- Indexes for table `TipoDispositivo`
--
ALTER TABLE `TipoDispositivo`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indexes for table `TipoMedidaSensor`
--
ALTER TABLE `TipoMedidaSensor`
  ADD PRIMARY KEY (`nombre`,`fechaconfigsensor`,`idsensor`,`idtiposensor`,`marcasensor`,`modelosensor`,`idestacion`),
  ADD KEY `fechaconfigsensor` (`fechaconfigsensor`,`idsensor`,`idtiposensor`,`marcasensor`,`modelosensor`,`idestacion`),
  ADD KEY `fechaconfigsensor_2` (`fechaconfigsensor`,`idsensor`,`idtiposensor`,`marcasensor`,`modelosensor`,`idestacion`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Activacion`
--
ALTER TABLE `Activacion`
  ADD CONSTRAINT `Activacion_ibfk_1` FOREIGN KEY (`fechahora`) REFERENCES `Calendario` (`fecha_inicio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Activacion_ibfk_2` FOREIGN KEY (`idactivador`) REFERENCES `Calendario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Activacion_ibfk_3` FOREIGN KEY (`tipoactivador`) REFERENCES `Calendario` (`tipo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Activador`
--
ALTER TABLE `Activador`
  ADD CONSTRAINT `fk_Activador_ModeloDispositivo1` FOREIGN KEY (`tipo`,`marca`,`modelo`) REFERENCES `ModeloDispositivo` (`id_tipo`, `marca`, `modelo`) ON UPDATE CASCADE;

--
-- Constraints for table `Actuador`
--
ALTER TABLE `Actuador`
  ADD CONSTRAINT `fk_Actuador_ModeloDispositivo1` FOREIGN KEY (`tipo`,`marca`,`modelo`) REFERENCES `ModeloDispositivo` (`id_tipo`, `marca`, `modelo`) ON UPDATE CASCADE;

--
-- Constraints for table `Calendario`
--
ALTER TABLE `Calendario`
  ADD CONSTRAINT `Calendario_ibfk_1` FOREIGN KEY (`id`) REFERENCES `Activador` (`id`),
  ADD CONSTRAINT `Calendario_ibfk_2` FOREIGN KEY (`tipo`) REFERENCES `Activador` (`tipo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ConfiguracionSensor`
--
ALTER TABLE `ConfiguracionSensor`
  ADD CONSTRAINT `fk_ConfiguracionesSensor_Sensor_1` FOREIGN KEY (`id`,`tipo`,`marca`,`modelo`,`idestacion`) REFERENCES `Sensor` (`id`, `tipo`, `marca`, `modelo`, `idestacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ModeloDispositivo`
--
ALTER TABLE `ModeloDispositivo`
  ADD CONSTRAINT `fk_ModelosSensor_TiposSensores_1` FOREIGN KEY (`id_tipo`) REFERENCES `TipoDispositivo` (`id_tipo`);

--
-- Constraints for table `ReglaActivacion`
--
ALTER TABLE `ReglaActivacion`
  ADD CONSTRAINT `fk_ReglaActivacion_Activacion1` FOREIGN KEY (`fecha_creada`,`idactivador`,`tipoactivador`,`marcaactivador`,`modeloactivador`) REFERENCES `Activacion` (`fecharegla`, `idactivador`, `tipoactivador`, `marcaactivador`, `modeloactivador`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ReglaActivacion_Activador1` FOREIGN KEY (`idactivador`,`tipoactivador`,`marcaactivador`,`modeloactivador`) REFERENCES `Activador` (`id`, `tipo`, `marca`, `modelo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ReglaActivacion_TipoMedida1` FOREIGN KEY (`nombremedida`,`fechaconfigsensor`,`idsensor`,`tiposensor`,`marcasensor`,`modelosensor`,`idestacion`) REFERENCES `TipoMedidaSensor` (`nombre`, `fechaconfigsensor`, `idsensor`, `idtiposensor`, `marcasensor`, `modelosensor`, `idestacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Sensor`
--
ALTER TABLE `Sensor`
  ADD CONSTRAINT `fk_Sensor_Estacion1` FOREIGN KEY (`idestacion`) REFERENCES `Estacion` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Sensor_ModelosDispositivo_1` FOREIGN KEY (`tipo`,`marca`,`modelo`) REFERENCES `ModeloDispositivo` (`id_tipo`, `marca`, `modelo`) ON UPDATE CASCADE;

--
-- Constraints for table `TipoMedidaSensor`
--
ALTER TABLE `TipoMedidaSensor`
  ADD CONSTRAINT `fk_TipoMedida_ConfiguracionSensor1` FOREIGN KEY (`fechaconfigsensor`,`idsensor`,`idtiposensor`,`marcasensor`,`modelosensor`,`idestacion`) REFERENCES `ConfiguracionSensor` (`fechahora`, `id`, `tipo`, `marca`, `modelo`, `idestacion`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
