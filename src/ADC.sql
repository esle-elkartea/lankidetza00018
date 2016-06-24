-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.37-standard


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema adc
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ adc;
USE adc;

--
-- Table structure for table `adc`.`actividades`
--

DROP TABLE IF EXISTS `actividades`;
CREATE TABLE `actividades` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL default '',
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`areas_funcionales`
--

DROP TABLE IF EXISTS `areas_funcionales`;
CREATE TABLE `areas_funcionales` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`cargos`
--

DROP TABLE IF EXISTS `cargos`;
CREATE TABLE `cargos` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  `nivel` varchar(200) default '0',
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`categorias_contrato`
--

DROP TABLE IF EXISTS `categorias_contrato`;
CREATE TABLE `categorias_contrato` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`categorias_profesionales`
--

DROP TABLE IF EXISTS `categorias_profesionales`;
CREATE TABLE `categorias_profesionales` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`causas`
--

DROP TABLE IF EXISTS `causas`;
CREATE TABLE `causas` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`centros_empresa`
--

DROP TABLE IF EXISTS `centros_empresa`;
CREATE TABLE `centros_empresa` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_empresa` int(10) unsigned NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(100) default NULL,
  `poblacion` varchar(45) default NULL,
  `telefono` varchar(45) default NULL,
  `fax` varchar(45) default NULL,
  `responsable` varchar(100) default NULL,
  `mail` varchar(45) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_centros_empresa_1` (`cod_empresa`),
  CONSTRAINT `FK_centros_empresa_1` FOREIGN KEY (`cod_empresa`) REFERENCES `empresas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`empleados`
--

DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `DNI` varchar(45) NOT NULL default '',
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `fecha_nacimiento` date default NULL,
  `NSS` varchar(45) default NULL,
  `cod_categoria` int(10) unsigned default NULL,
  `fecha_alta` date default NULL,
  `fecha_baja` date default NULL,
  `cod_area` int(10) unsigned default NULL,
  `cod_empresa` int(10) unsigned default NULL,
  `cod_centro` int(10) unsigned default NULL,
  `recurso_preventivo` varchar(45) default 'No',
  `domicilio` varchar(100) default NULL,
  `poblacion` varchar(45) default NULL,
  `telefono` varchar(45) default NULL,
  `fecha_ultimo_reconocimiento` date default NULL,
  `estado_ultimo_reconocimiento` varchar(45) default NULL,
  `observaciones` varchar(200) default NULL,
  `cod_cargo` int(10) unsigned default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_empleados_1` (`cod_categoria`),
  KEY `FK_empleados_2` (`cod_area`),
  KEY `FK_empleados_4` (`cod_empresa`),
  KEY `FK_empleados_5` (`cod_cargo`),
  CONSTRAINT `FK_empleados_5` FOREIGN KEY (`cod_cargo`) REFERENCES `cargos` (`codigo`),
  CONSTRAINT `FK_empleados_1` FOREIGN KEY (`cod_categoria`) REFERENCES `categorias_contrato` (`codigo`),
  CONSTRAINT `FK_empleados_2` FOREIGN KEY (`cod_area`) REFERENCES `areas_funcionales` (`codigo`),
  CONSTRAINT `FK_empleados_3` FOREIGN KEY (`cod_empresa`) REFERENCES `empresas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 10240 kB; (`cod_categoria`) REFER `adc/categori';

--
-- Table structure for table `adc`.`empleados_actividades`
--

DROP TABLE IF EXISTS `empleados_actividades`;
CREATE TABLE `empleados_actividades` (
  `cod_empleado` int(10) unsigned NOT NULL,
  `cod_perfil_actividad` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`cod_empleado`,`cod_perfil_actividad`),
  KEY `FK_empleados_actividades_2` (`cod_perfil_actividad`),
  CONSTRAINT `FK_empleados_actividades_1` FOREIGN KEY (`cod_empleado`) REFERENCES `empleados` (`codigo`),
  CONSTRAINT `FK_empleados_actividades_2` FOREIGN KEY (`cod_perfil_actividad`) REFERENCES `perfil_actividades` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`empleados_cargos`
--

DROP TABLE IF EXISTS `empleados_cargos`;
CREATE TABLE `empleados_cargos` (
  `cod_empleado` int(10) unsigned NOT NULL,
  `cod_cargo` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`cod_empleado`,`cod_cargo`),
  KEY `FK_empleados_cargos_1` (`cod_cargo`),
  CONSTRAINT `FK_empleados_cargos_1` FOREIGN KEY (`cod_cargo`) REFERENCES `cargos` (`codigo`),
  CONSTRAINT `FK_empleados_cargos_2` FOREIGN KEY (`cod_empleado`) REFERENCES `empleados` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`empleados_formacion`
--

DROP TABLE IF EXISTS `empleados_formacion`;
CREATE TABLE `empleados_formacion` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_empleado` int(10) unsigned NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `certificacion` varchar(45) default 'Si',
  `interno_externo` varchar(45) default 'I',
  `fecha_obtencion` date default NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`empleados_perfiles`
--

DROP TABLE IF EXISTS `empleados_perfiles`;
CREATE TABLE `empleados_perfiles` (
  `cod_empleado` int(10) unsigned NOT NULL,
  `cod_perfil_empresa` int(10) unsigned NOT NULL,
  `codigo` int(10) unsigned NOT NULL auto_increment,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`empleados_restricciones`
--

DROP TABLE IF EXISTS `empleados_restricciones`;
CREATE TABLE `empleados_restricciones` (
  `cod_empleado` int(10) unsigned NOT NULL,
  `cod_restriccion` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`cod_empleado`,`cod_restriccion`),
  KEY `FK_empleados_restricciones_2` (`cod_restriccion`),
  KEY `FK_empleados_restricciones_1` (`cod_empleado`),
  CONSTRAINT `FK_empleados_restricciones_1` FOREIGN KEY (`cod_empleado`) REFERENCES `empleados` (`codigo`),
  CONSTRAINT `FK_empleados_restricciones_2` FOREIGN KEY (`cod_restriccion`) REFERENCES `restricciones` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`empresas`
--

DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cif` varchar(45) NOT NULL,
  `razon_social` varchar(100) NOT NULL,
  `direccion` varchar(200) default NULL,
  `cod_sector` int(10) unsigned NOT NULL,
  `num_empleados` int(10) unsigned default NULL,
  `zona` varchar(45) default NULL,
  `num_contrato` varchar(45) default NULL,
  `num_centros` int(10) unsigned default NULL,
  `cod_responsable` int(10) unsigned default '0',
  `accidentes` varchar(2000) default NULL COMMENT 'procedimiento de investigacion de accidentes',
  `coord_preventiva` varchar(2000) default NULL COMMENT 'procedimiento de coordinacion preventiva',
  `plan_emergencia` varchar(2000) default NULL COMMENT 'procedimiento de plan de emergencia',
  `mail` varchar(45) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_empresas_1` (`cod_sector`),
  KEY `FK_empresas_2` (`cod_responsable`),
  CONSTRAINT `FK_empresas_1` FOREIGN KEY (`cod_sector`) REFERENCES `sectores` (`codigo`),
  CONSTRAINT `FK_empresas_2` FOREIGN KEY (`cod_responsable`) REFERENCES `empleados` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`epis`
--

DROP TABLE IF EXISTS `epis`;
CREATE TABLE `epis` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  `cod_tipo` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_epis_1` (`cod_tipo`),
  CONSTRAINT `FK_epis_1` FOREIGN KEY (`cod_tipo`) REFERENCES `tipos_epi` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`equipos_epis`
--

DROP TABLE IF EXISTS `equipos_epis`;
CREATE TABLE `equipos_epis` (
  `cod_equipo` int(10) unsigned NOT NULL,
  `cod_epi` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`cod_equipo`,`cod_epi`),
  KEY `FK_equipos_epis_2` (`cod_epi`),
  CONSTRAINT `FK_equipos_epis_1` FOREIGN KEY (`cod_equipo`) REFERENCES `equipos_trabajo` (`codigo`),
  CONSTRAINT `FK_equipos_epis_2` FOREIGN KEY (`cod_epi`) REFERENCES `epis` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`equipos_perfiles_actividades`
--

DROP TABLE IF EXISTS `equipos_perfiles_actividades`;
CREATE TABLE `equipos_perfiles_actividades` (
  `cod_perfil_actividad` int(10) unsigned NOT NULL,
  `cod_equipo` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`cod_perfil_actividad`,`cod_equipo`),
  KEY `FK_equipos_perfiles_actividades_2` (`cod_equipo`),
  CONSTRAINT `FK_equipos_perfiles_actividades_1` FOREIGN KEY (`cod_perfil_actividad`) REFERENCES `perfil_actividades` (`codigo`),
  CONSTRAINT `FK_equipos_perfiles_actividades_2` FOREIGN KEY (`cod_equipo`) REFERENCES `equipos_trabajo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`equipos_prevencion`
--

DROP TABLE IF EXISTS `equipos_prevencion`;
CREATE TABLE `equipos_prevencion` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `descripcion` varchar(200) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`equipos_riesgos_fabricante`
--

DROP TABLE IF EXISTS `equipos_riesgos_fabricante`;
CREATE TABLE `equipos_riesgos_fabricante` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_equipo` int(10) unsigned NOT NULL,
  `cod_riesgo` int(10) unsigned NOT NULL,
  `cod_causa` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_equipos_riesgos_fabricante_1` (`cod_equipo`),
  KEY `FK_equipos_riesgos_fabricante_2` (`cod_riesgo`),
  KEY `FK_equipos_riesgos_fabricante_3` (`cod_causa`),
  CONSTRAINT `FK_equipos_riesgos_fabricante_1` FOREIGN KEY (`cod_equipo`) REFERENCES `equipos_trabajo` (`codigo`),
  CONSTRAINT `FK_equipos_riesgos_fabricante_2` FOREIGN KEY (`cod_riesgo`) REFERENCES `riesgos` (`codigo`),
  CONSTRAINT `FK_equipos_riesgos_fabricante_3` FOREIGN KEY (`cod_causa`) REFERENCES `causas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`equipos_riesgos_utilizacion`
--

DROP TABLE IF EXISTS `equipos_riesgos_utilizacion`;
CREATE TABLE `equipos_riesgos_utilizacion` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_riesgo` int(10) unsigned NOT NULL,
  `cod_causa` int(10) unsigned NOT NULL,
  `grado_riesgo` varchar(45) default NULL,
  `probabilidad_riesgo` varchar(45) default NULL,
  `valoracion_riesgo` varchar(45) default NULL,
  `propuestas_mejora` varchar(1000) default NULL,
  `grado_riesgo_2` varchar(45) default NULL COMMENT 'despues de la aplicacion de la medida',
  `probabilidad_riesgo_2` varchar(45) default NULL COMMENT 'despues de la aplicacion de la medida',
  `valoracion_riesgo_2` varchar(45) default NULL COMMENT 'despues de la aplicacion de la medida',
  `cod_equipo` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_equipos_riesgos_utilizacion_1` (`cod_riesgo`),
  KEY `FK_equipos_riesgos_utilizacion_2` (`cod_causa`),
  KEY `FK_equipos_riesgos_utilizacion_3` (`cod_equipo`),
  CONSTRAINT `FK_equipos_riesgos_utilizacion_1` FOREIGN KEY (`cod_riesgo`) REFERENCES `riesgos` (`codigo`),
  CONSTRAINT `FK_equipos_riesgos_utilizacion_2` FOREIGN KEY (`cod_causa`) REFERENCES `causas` (`codigo`),
  CONSTRAINT `FK_equipos_riesgos_utilizacion_3` FOREIGN KEY (`cod_equipo`) REFERENCES `equipos_trabajo` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`equipos_trabajo`
--

DROP TABLE IF EXISTS `equipos_trabajo`;
CREATE TABLE `equipos_trabajo` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_empresa` int(10) unsigned NOT NULL,
  `cod_familia` int(10) unsigned default NULL,
  `cod_marca` int(10) unsigned default NULL,
  `cod_modelo` int(10) unsigned default NULL,
  `marcado_ce` varchar(45) default NULL COMMENT 'si/no',
  `caracteristicas` varchar(2000) default NULL,
  `observaciones` varchar(2000) default NULL,
  `anio_fabricacion` date default NULL,
  `restricciones` varchar(2000) default NULL,
  `cod_responsable` int(10) unsigned default NULL,
  `cod_evaluacion` int(10) unsigned default '0',
  `cod_perfil1` int(10) unsigned default NULL,
  `cod_perfil2` int(10) unsigned default NULL,
  `cod_perfil3` int(10) unsigned default NULL,
  `cod_riesgo1` int(10) unsigned default NULL,
  `cod_riesgo2` int(10) unsigned default NULL,
  `cod_riesgo3` int(10) unsigned default NULL,
  `cod_epi1` int(10) unsigned default NULL,
  `cod_epi2` int(10) unsigned default NULL,
  `cod_epi3` int(10) unsigned default NULL,
  `nombre` varchar(200) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_equipos_trabajo_1` (`cod_empresa`),
  KEY `FK_equipos_trabajo_2` (`cod_familia`),
  KEY `FK_equipos_trabajo_3` (`cod_marca`),
  KEY `FK_equipos_trabajo_4` (`cod_modelo`),
  KEY `FK_equipos_trabajo_5` (`cod_responsable`),
  KEY `FK_equipos_trabajo_6` (`cod_evaluacion`),
  CONSTRAINT `FK_equipos_trabajo_1` FOREIGN KEY (`cod_empresa`) REFERENCES `empresas` (`codigo`),
  CONSTRAINT `FK_equipos_trabajo_2` FOREIGN KEY (`cod_familia`) REFERENCES `familias_maquina` (`codigo`),
  CONSTRAINT `FK_equipos_trabajo_3` FOREIGN KEY (`cod_marca`) REFERENCES `marcas_maquina` (`codigo`),
  CONSTRAINT `FK_equipos_trabajo_4` FOREIGN KEY (`cod_modelo`) REFERENCES `modelos_maquina` (`codigo`),
  CONSTRAINT `FK_equipos_trabajo_5` FOREIGN KEY (`cod_responsable`) REFERENCES `empleados` (`codigo`),
  CONSTRAINT `FK_equipos_trabajo_6` FOREIGN KEY (`cod_evaluacion`) REFERENCES `evaluaciones` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`evaluaciones`
--

DROP TABLE IF EXISTS `evaluaciones`;
CREATE TABLE `evaluaciones` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `zona` varchar(45) default '',
  `cod_empresa` int(10) unsigned NOT NULL default '0',
  `cod_centro` int(10) unsigned NOT NULL default '0',
  `estado` varchar(45) default '',
  `cod_tecnico` varchar(45) default '0',
  `anio` varchar(4) default NULL,
  `fecha_ultima_actualizacion` datetime default NULL,
  `fecha_evaluacion` datetime default NULL,
  `cod_politica` varchar(2000) default NULL,
  `cod_responsable_empresa` int(10) unsigned default NULL,
  `cod_responsable_centro` int(10) unsigned default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_evaluaciones_1` (`cod_empresa`),
  KEY `FK_evaluaciones_2` (`cod_centro`),
  KEY `FK_evaluaciones_4` (`cod_tecnico`),
  KEY `FK_evaluaciones_3` (`cod_responsable_empresa`),
  KEY `FK_evaluaciones_5` (`cod_responsable_centro`),
  CONSTRAINT `FK_evaluaciones_3` FOREIGN KEY (`cod_responsable_empresa`) REFERENCES `empleados` (`codigo`),
  CONSTRAINT `FK_evaluaciones_5` FOREIGN KEY (`cod_responsable_centro`) REFERENCES `empleados` (`codigo`),
  CONSTRAINT `FK_evaluaciones_1` FOREIGN KEY (`cod_empresa`) REFERENCES `empresas` (`codigo`),
  CONSTRAINT `FK_evaluaciones_2` FOREIGN KEY (`cod_centro`) REFERENCES `centros_empresa` (`codigo`),
  CONSTRAINT `FK_evaluaciones_4` FOREIGN KEY (`cod_tecnico`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`familias_maquina`
--

DROP TABLE IF EXISTS `familias_maquina`;
CREATE TABLE `familias_maquina` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`instalaciones`
--

DROP TABLE IF EXISTS `instalaciones`;
CREATE TABLE `instalaciones` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_evaluacion` int(10) unsigned NOT NULL default '0',
  `denominacion` varchar(200) default NULL,
  `observaciones` varchar(200) default NULL,
  `plano` varchar(45) default 'No',
  `cod_responsable_instalacion` int(10) unsigned default NULL,
  `cod_responsable_emergencias` int(10) unsigned default NULL,
  `cod_equipo1` int(10) unsigned default NULL,
  `cod_equipo2` int(10) unsigned default NULL,
  `cod_equipo3` int(10) unsigned default NULL,
  `cod_prevencion1` int(10) unsigned default NULL,
  `cod_prevencion2` int(10) unsigned default NULL,
  `cod_prevencion3` int(10) unsigned default NULL,
  `nombre` varchar(200) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_instalacion_1` (`cod_evaluacion`),
  KEY `FK_instalaciones_2` (`cod_responsable_instalacion`),
  KEY `FK_instalaciones_3` (`cod_responsable_emergencias`),
  CONSTRAINT `FK_instalaciones_2` FOREIGN KEY (`cod_responsable_instalacion`) REFERENCES `empleados` (`codigo`),
  CONSTRAINT `FK_instalaciones_3` FOREIGN KEY (`cod_responsable_emergencias`) REFERENCES `empleados` (`codigo`),
  CONSTRAINT `FK_instalacion_1` FOREIGN KEY (`cod_evaluacion`) REFERENCES `evaluaciones` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 10240 kB; (`cod_evaluacion`) REFER `adc/evaluac';


--
-- Table structure for table `adc`.`instalaciones_epis`
--

DROP TABLE IF EXISTS `instalaciones_epis`;
CREATE TABLE `instalaciones_epis` (
  `cod_instalacion` int(10) unsigned NOT NULL,
  `cod_epi` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`cod_instalacion`,`cod_epi`),
  KEY `FK_instalaciones_epis_2` (`cod_epi`),
  CONSTRAINT `FK_instalaciones_epis_1` FOREIGN KEY (`cod_instalacion`) REFERENCES `instalaciones` (`codigo`),
  CONSTRAINT `FK_instalaciones_epis_2` FOREIGN KEY (`cod_epi`) REFERENCES `epis` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 9216 kB; (`cod_epi`) REFER `adc/epis`(`codigo`)';

--
-- Table structure for table `adc`.`instalaciones_riesgos`
--

DROP TABLE IF EXISTS `instalaciones_riesgos`;
CREATE TABLE `instalaciones_riesgos` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_instalacion` int(10) unsigned NOT NULL,
  `cod_riesgo` int(10) unsigned NOT NULL,
  `cod_causa` int(10) unsigned NOT NULL,
  `grado_riesgo` varchar(45) default NULL,
  `probabilidad_riesgo` varchar(45) default NULL,
  `valoracion_riesgo` varchar(45) default NULL,
  `grado_riesgo_2` varchar(45) default NULL COMMENT 'despues de la aplicacion de la medida',
  `probabilidad_riesgo_2` varchar(45) default NULL COMMENT 'despues de la aplicacion de la medida',
  `valoracion_riesgo_2` varchar(45) default NULL COMMENT 'despues de la aplicacion de la medida',
  `propuesta_mejora` varchar(200) default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_instalaciones_riesgos_1` (`cod_instalacion`),
  KEY `FK_instalaciones_riesgos_2` (`cod_riesgo`),
  KEY `FK_instalaciones_riesgos_3` (`cod_causa`),
  CONSTRAINT `FK_instalaciones_riesgos_1` FOREIGN KEY (`cod_instalacion`) REFERENCES `instalaciones` (`codigo`),
  CONSTRAINT `FK_instalaciones_riesgos_2` FOREIGN KEY (`cod_riesgo`) REFERENCES `riesgos` (`codigo`),
  CONSTRAINT `FK_instalaciones_riesgos_3` FOREIGN KEY (`cod_causa`) REFERENCES `causas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`marcas_maquina`
--

DROP TABLE IF EXISTS `marcas_maquina`;
CREATE TABLE `marcas_maquina` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`modelos_maquina`
--

DROP TABLE IF EXISTS `modelos_maquina`;
CREATE TABLE `modelos_maquina` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  `cod_marca` int(10) unsigned NOT NULL,
  `cod_familia` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_modelos_maquina_1` (`cod_marca`),
  KEY `FK_modelos_maquina_2` (`cod_familia`),
  CONSTRAINT `FK_modelos_maquina_1` FOREIGN KEY (`cod_marca`) REFERENCES `marcas_maquina` (`codigo`),
  CONSTRAINT `FK_modelos_maquina_2` FOREIGN KEY (`cod_familia`) REFERENCES `familias_maquina` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`perfil_actividades`
--

DROP TABLE IF EXISTS `perfil_actividades`;
CREATE TABLE `perfil_actividades` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_perfil_empresa` int(10) unsigned NOT NULL,
  `cod_actividad` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_perfil_actividades_1` (`cod_perfil_empresa`),
  KEY `FK_perfil_actividades_2` (`cod_actividad`),
  CONSTRAINT `FK_perfil_actividades_1` FOREIGN KEY (`cod_perfil_empresa`) REFERENCES `perfiles_empresa` (`codigo`),
  CONSTRAINT `FK_perfil_actividades_2` FOREIGN KEY (`cod_actividad`) REFERENCES `actividades` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`perfil_epis`
--

DROP TABLE IF EXISTS `perfil_epis`;
CREATE TABLE `perfil_epis` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_perfil_empresa` int(10) unsigned NOT NULL,
  `cod_epi` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_perfil_epis_1` (`cod_perfil_empresa`),
  KEY `FK_perfil_epis_2` (`cod_epi`),
  CONSTRAINT `FK_perfil_epis_1` FOREIGN KEY (`cod_perfil_empresa`) REFERENCES `perfiles_empresa` (`codigo`),
  CONSTRAINT `FK_perfil_epis_2` FOREIGN KEY (`cod_epi`) REFERENCES `epis` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`perfil_riesgos`
--

DROP TABLE IF EXISTS `perfil_riesgos`;
CREATE TABLE `perfil_riesgos` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_perfil_empresa` int(10) unsigned NOT NULL,
  `cod_riesgo` int(10) unsigned NOT NULL,
  `cod_causa` int(10) unsigned NOT NULL,
  `grado_riesgo` varchar(45) default '',
  `probabilidad_riesgo` varchar(45) default '',
  `valoracion_riesgo` varchar(45) default '',
  `propuestas_mejora` varchar(1000) default '',
  `grado_riesgo_2` varchar(45) default '' COMMENT 'despues de la aplicacion de la medida',
  `probabilidad_riesgo_2` varchar(45) default '' COMMENT 'despues de la aplicacion de la medida',
  `valoracion_riesgo_2` varchar(45) default '' COMMENT 'despues de la aplicacion de la medida',
  PRIMARY KEY  (`codigo`),
  KEY `FK_perfil_riesgos_1` (`cod_perfil_empresa`),
  KEY `FK_perfil_riesgos_2` (`cod_riesgo`),
  KEY `FK_perfil_riesgos_3` (`cod_causa`),
  CONSTRAINT `FK_perfil_riesgos_1` FOREIGN KEY (`cod_perfil_empresa`) REFERENCES `perfiles_empresa` (`codigo`),
  CONSTRAINT `FK_perfil_riesgos_2` FOREIGN KEY (`cod_riesgo`) REFERENCES `riesgos` (`codigo`),
  CONSTRAINT `FK_perfil_riesgos_3` FOREIGN KEY (`cod_causa`) REFERENCES `causas` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 9216 kB; (`cod_riesgo`) REFER `adc/riesgos`(`co';

--
-- Table structure for table `adc`.`perfiles`
--

DROP TABLE IF EXISTS `perfiles`;
CREATE TABLE `perfiles` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`perfiles_empresa`
--

DROP TABLE IF EXISTS `perfiles_empresa`;
CREATE TABLE `perfiles_empresa` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `cod_empresa` int(10) unsigned NOT NULL,
  `cod_sector` int(10) unsigned default NULL,
  `cod_categoria` int(10) unsigned default NULL,
  `cod_perfil` int(10) unsigned default NULL,
  PRIMARY KEY  (`codigo`),
  KEY `FK_perfiles_empresa_1` (`cod_empresa`),
  KEY `FK_perfiles_empresa_4` (`cod_sector`),
  KEY `FK_perfiles_empresa_5` (`cod_categoria`),
  KEY `FK_perfiles_empresa_6` (`cod_perfil`),
  CONSTRAINT `FK_perfiles_empresa_1` FOREIGN KEY (`cod_empresa`) REFERENCES `empresas` (`codigo`),
  CONSTRAINT `FK_perfiles_empresa_4` FOREIGN KEY (`cod_sector`) REFERENCES `sectores` (`codigo`),
  CONSTRAINT `FK_perfiles_empresa_5` FOREIGN KEY (`cod_categoria`) REFERENCES `categorias_profesionales` (`codigo`),
  CONSTRAINT `FK_perfiles_empresa_6` FOREIGN KEY (`cod_perfil`) REFERENCES `perfiles` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 9216 kB; (`cod_empresa`) REFER `adc/empresas`(`';


--
-- Table structure for table `adc`.`politicas_empresa`
--

DROP TABLE IF EXISTS `politicas_empresa`;
CREATE TABLE `politicas_empresa` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(2000) NOT NULL default '',
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`responsabilidades`
--

DROP TABLE IF EXISTS `responsabilidades`;
CREATE TABLE `responsabilidades` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`restricciones`
--

DROP TABLE IF EXISTS `restricciones`;
CREATE TABLE `restricciones` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`riesgos`
--

DROP TABLE IF EXISTS `riesgos`;
CREATE TABLE `riesgos` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  `tipo_riesgo` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `adc`.`sectores`
--

DROP TABLE IF EXISTS `sectores`;
CREATE TABLE `sectores` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`tipos_epi`
--

DROP TABLE IF EXISTS `tipos_epi`;
CREATE TABLE `tipos_epi` (
  `codigo` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY  (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `adc`.`usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id_usuario` varchar(16) NOT NULL default '',
  `pwd` blob NOT NULL,
  `tipo` int(10) unsigned NOT NULL COMMENT '0-Sin acceso; 1-Evaluador; 2-Administrador',
  `nombre` varchar(200) default NULL,
  PRIMARY KEY  (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
