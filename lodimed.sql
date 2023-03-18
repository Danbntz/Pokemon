/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 100804
 Source Host           : localhost:3308
 Source Schema         : lodimed

 Target Server Type    : MySQL
 Target Server Version : 100804
 File Encoding         : 65001

 Date: 17/03/2023 20:29:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for abastos_servicio
-- ----------------------------
DROP TABLE IF EXISTS `abastos_servicio`;
CREATE TABLE `abastos_servicio`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `folio` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `unidad` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `detalle_producto` int UNSIGNED NULL DEFAULT NULL,
  `codigo_barras` int NULL DEFAULT NULL,
  `cantidad` int NULL DEFAULT NULL,
  `estado` enum('NO_SINCRONIZADO','SINCRONIZADO','CANCELADO') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT 'NO_SINCRONIZADO',
  `estado_almacen` tinyint UNSIGNED NULL DEFAULT 0 COMMENT 'Emula al campo númerico en almacen, pero es igual al campo estado.',
  `detalle_receta` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `unidad`(`unidad`) USING BTREE,
  INDEX `detalle_producto`(`detalle_producto`) USING BTREE,
  INDEX `codigo_barras`(`codigo_barras`) USING BTREE,
  INDEX `detalle_receta`(`detalle_receta`) USING BTREE,
  CONSTRAINT `abastos_servicio_ibfk_1` FOREIGN KEY (`unidad`) REFERENCES `unidades` (`cla_uni`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `abastos_servicio_ibfk_2` FOREIGN KEY (`detalle_producto`) REFERENCES `detalle_productos` (`det_pro`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `abastos_servicio_ibfk_3` FOREIGN KEY (`codigo_barras`) REFERENCES `tb_codigob` (`F_Id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `abastos_servicio_ibfk_4` FOREIGN KEY (`detalle_receta`) REFERENCES `detreceta` (`fol_det`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7629 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for apartamiento
-- ----------------------------
DROP TABLE IF EXISTS `apartamiento`;
CREATE TABLE `apartamiento`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `detalle_producto` int UNSIGNED NOT NULL,
  `detalle_receta` int NOT NULL,
  `cantidad` int UNSIGNED NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `status` tinyint UNSIGNED NULL DEFAULT NULL,
  `tipo` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `usuario` int UNSIGNED NULL DEFAULT NULL,
  `fecha_creacion` datetime(0) NULL DEFAULT current_timestamp(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `producto_status`(`detalle_producto`, `status`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `detalle_receta`(`detalle_receta`) USING BTREE,
  INDEX `status_receta_producto`(`status`, `detalle_receta`, `detalle_producto`) USING BTREE,
  INDEX `apartamiento_ibfk_4`(`usuario`) USING BTREE,
  CONSTRAINT `apartamiento_ibfk_1` FOREIGN KEY (`status`) REFERENCES `estado_apartamiento` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `apartamiento_ibfk_2` FOREIGN KEY (`detalle_receta`) REFERENCES `detreceta` (`fol_det`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `apartamiento_ibfk_3` FOREIGN KEY (`detalle_producto`) REFERENCES `detalle_productos` (`det_pro`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `apartamiento_ibfk_4` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id_usu`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 57773 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for carga_abasto
-- ----------------------------
DROP TABLE IF EXISTS `carga_abasto`;
CREATE TABLE `carga_abasto`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `lote` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `caducidad` date NOT NULL,
  `cantidad` int NOT NULL,
  `origen` int NOT NULL,
  `cb` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cargado` tinyint NOT NULL DEFAULT 0,
  `observacion` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `historial` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `ampuleo` smallint UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idIndex`(`id`) USING BTREE,
  INDEX `claveIndex`(`clave`) USING BTREE,
  CONSTRAINT `carga_abasto_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 11565 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for causes
-- ----------------------------
DROP TABLE IF EXISTS `causes`;
CREATE TABLE `causes`  (
  `id_cau` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0',
  `des_cau` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `descripcion_fulltext` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `descripcion_terms` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  PRIMARY KEY (`id_cau`) USING BTREE,
  UNIQUE INDEX `idIndex`(`id_cau`) USING BTREE,
  INDEX `descIndex`(`des_cau`) USING BTREE,
  FULLTEXT INDEX `descripcion`(`descripcion_fulltext`)
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cedis
-- ----------------------------
DROP TABLE IF EXISTS `cedis`;
CREATE TABLE `cedis`  (
  `id_cedis` int NOT NULL AUTO_INCREMENT,
  `des_cedis` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_cedis`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contactos
-- ----------------------------
DROP TABLE IF EXISTS `contactos`;
CREATE TABLE `contactos`  (
  `F_Id` int NOT NULL AUTO_INCREMENT,
  `F_Nombre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F_Correo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F_Obs` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F_Fecha` date NOT NULL,
  `F_Hora` time(0) NOT NULL,
  PRIMARY KEY (`F_Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detalle_productos
-- ----------------------------
DROP TABLE IF EXISTS `detalle_productos`;
CREATE TABLE `detalle_productos`  (
  `det_pro` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `cla_pro` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `lot_pro` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cad_pro` date NULL DEFAULT NULL,
  `ampuleo` smallint UNSIGNED NULL DEFAULT NULL,
  `cla_fin` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `id_ori` int NULL DEFAULT NULL,
  `web` int NULL DEFAULT 0,
  PRIMARY KEY (`det_pro`) USING BTREE,
  INDEX `detalle_profk1`(`cla_fin`) USING BTREE,
  INDEX `det_pro_fk2`(`id_ori`) USING BTREE,
  INDEX `lote_ind1`(`lot_pro`) USING BTREE,
  INDEX `cad_ind2`(`cad_pro`) USING BTREE,
  INDEX `ori_ind1`(`id_ori`) USING BTREE,
  INDEX `cla_pro_fk2`(`cla_pro`, `lot_pro`) USING BTREE,
  INDEX `detalle_clave`(`det_pro`, `cla_pro`) USING BTREE,
  INDEX `det_origen_clave_lote_cad`(`det_pro`, `id_ori`, `cla_pro`, `lot_pro`, `cad_pro`) USING BTREE,
  INDEX `origen_clave`(`id_ori`, `cla_pro`) USING BTREE,
  INDEX `clave_lote_cad_origen`(`cla_pro`, `lot_pro`, `cad_pro`, `id_ori`) USING BTREE,
  CONSTRAINT `detalle_productos_ibfk_1` FOREIGN KEY (`cla_pro`) REFERENCES `productos` (`cla_pro`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detalle_productos_ibfk_2` FOREIGN KEY (`cla_fin`) REFERENCES `financiamientos` (`cla_fin`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `detalle_productos_ibfk_3` FOREIGN KEY (`id_ori`) REFERENCES `origen` (`id_ori`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2960 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci COMMENT = 'InnoDB free: 93184 kB; (`cla_pro`) REFER `receta_electronica' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detalle_receta_servicios
-- ----------------------------
DROP TABLE IF EXISTS `detalle_receta_servicios`;
CREATE TABLE `detalle_receta_servicios`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `receta` int NOT NULL,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `inicio_tratamiento` datetime(0) NULL DEFAULT NULL,
  `frecuencia_tratamiento` smallint UNSIGNED NULL DEFAULT NULL,
  `duracion_tratamiento` smallint NULL DEFAULT NULL,
  `dosis_tratamiento` tinyint UNSIGNED NULL DEFAULT NULL,
  `cama` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `usuario` int UNSIGNED NULL DEFAULT NULL,
  `estado` enum('PENDIENTE','RECOLECTADO') CHARACTER SET utf32 COLLATE utf32_unicode_ci NULL DEFAULT 'PENDIENTE',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_detalle_receta`(`receta`) USING BTREE,
  INDEX `usuario`(`usuario`) USING BTREE,
  INDEX `clave`(`clave`) USING BTREE,
  CONSTRAINT `detalle_receta_servicios_ibfk_2` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id_usu`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `detalle_receta_servicios_ibfk_3` FOREIGN KEY (`receta`) REFERENCES `receta` (`id_rec`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `detalle_receta_servicios_ibfk_4` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf32 COLLATE = utf32_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for detreceta
-- ----------------------------
DROP TABLE IF EXISTS `detreceta`;
CREATE TABLE `detreceta`  (
  `fol_det` int NOT NULL AUTO_INCREMENT,
  `det_pro` int UNSIGNED NULL DEFAULT NULL,
  `can_sol` int NULL DEFAULT NULL,
  `cant_sur` int NULL DEFAULT NULL,
  `fec_sur` date NULL DEFAULT NULL,
  `status` int NULL DEFAULT NULL,
  `id_rec` int NULL DEFAULT NULL,
  `hor_sur` time(0) NULL DEFAULT '08:00:00',
  `id_cau` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `indicaciones` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `baja` int NULL DEFAULT 0,
  `web` int NULL DEFAULT 0,
  `id_cau2` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`fol_det`) USING BTREE,
  INDEX `det_pro_fk`(`det_pro`) USING BTREE,
  INDEX `detreceta_ibfk_3`(`id_cau`) USING BTREE,
  INDEX `id_rec_fk2`(`id_rec`, `det_pro`) USING BTREE,
  INDEX `status`(`status`) USING BTREE,
  INDEX `fecha_baja_sol_sur`(`fec_sur`, `baja`, `can_sol`, `cant_sur`) USING BTREE,
  INDEX `fecha_baja_sur_receta`(`det_pro`, `fec_sur`, `baja`, `cant_sur`, `id_rec`) USING BTREE,
  INDEX `producto_baja_receta_solicitado`(`det_pro`, `baja`, `id_rec`, `can_sol`) USING BTREE,
  CONSTRAINT `detreceta_ibfk_1` FOREIGN KEY (`id_rec`) REFERENCES `receta` (`id_rec`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreceta_ibfk_2` FOREIGN KEY (`id_cau`) REFERENCES `causes` (`id_cau`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreceta_ibfk_3` FOREIGN KEY (`det_pro`) REFERENCES `detalle_productos` (`det_pro`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 66859 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'InnoDB free: 93184 kB; (`det_pro`) REFER `receta_electronica' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for estado_apartamiento
-- ----------------------------
DROP TABLE IF EXISTS `estado_apartamiento`;
CREATE TABLE `estado_apartamiento`  (
  `id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for financiamientos
-- ----------------------------
DROP TABLE IF EXISTS `financiamientos`;
CREATE TABLE `financiamientos`  (
  `cla_fin` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `des_fin` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cla_fin`) USING BTREE,
  INDEX `claveIndex`(`cla_fin`) USING BTREE,
  INDEX `descIndex`(`des_fin`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for indices
-- ----------------------------
DROP TABLE IF EXISTS `indices`;
CREATE TABLE `indices`  (
  `id_rec` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `paramFol` int NULL DEFAULT NULL,
  `tipRec` tinyint(1) NULL DEFAULT NULL,
  `reincio_sistema` tinyint(1) NULL DEFAULT NULL,
  `seleccion_unidad` tinyint(1) NULL DEFAULT NULL,
  `cargo_servicios` tinyint(1) NULL DEFAULT NULL,
  `cargo_cdm` tinyint(1) NULL DEFAULT NULL,
  `paramRec` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `inicio_jornada` timestamp(0) NULL DEFAULT NULL,
  `fin_jornada` timestamp(0) NULL DEFAULT NULL,
  `numero_por_dia` int UNSIGNED NULL DEFAULT 3,
  `maximo_dias` int UNSIGNED NULL DEFAULT 7,
  `ciclicos` int NULL DEFAULT NULL,
  `tipoCaptura` int NULL DEFAULT NULL,
  `canal_comunicacion` enum('SOCKET','HTTP') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `comienzo_proyecto` date NULL DEFAULT NULL COMMENT 'Desde este momento se calcula el consumo promedio mensual.',
  `version_bd` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT '',
  `version_bd_last` varchar(9) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `fecha_ultima_actualizacion` datetime(0) NULL DEFAULT NULL,
  `tipo_servicio` enum('Hospitalario','No Hospitalario') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventario
-- ----------------------------
DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario`  (
  `fec_ela` date NULL DEFAULT NULL,
  `cla_uni` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `det_pro` int UNSIGNED NULL DEFAULT NULL,
  `cant` int NULL DEFAULT NULL,
  `id_inv` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `web` int NULL DEFAULT 0,
  PRIMARY KEY (`id_inv`) USING BTREE,
  INDEX `cla_uni_fk_inv`(`cla_uni`) USING BTREE,
  INDEX `det_pro_fk_inv`(`det_pro`, `cant`) USING BTREE,
  INDEX `detalle_cantidad_unidad`(`det_pro`, `cant`, `cla_uni`) USING BTREE,
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`cla_uni`) REFERENCES `unidades` (`cla_uni`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventario_ibfk_2` FOREIGN KEY (`det_pro`) REFERENCES `detalle_productos` (`det_pro`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2367 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'InnoDB free: 93184 kB; (`det_pro`) REFER `receta_electronica' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventario_ciclico
-- ----------------------------
DROP TABLE IF EXISTS `inventario_ciclico`;
CREATE TABLE `inventario_ciclico`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `lote` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `caducidad` date NULL DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time(0) NOT NULL,
  `fisico` int NOT NULL,
  `sistema` int NOT NULL,
  `diferencia` int NOT NULL DEFAULT 0,
  `tipo_ciclico` enum('ABIERTO','CONTROLADO','ALTO COSTO') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IndexFecha`(`fecha`) USING BTREE,
  INDEX `Fk_FCatalogoCiclico`(`tipo_ciclico`) USING BTREE,
  INDEX `clave`(`clave`) USING BTREE,
  CONSTRAINT `inventario_ciclico_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inventario_inicial
-- ----------------------------
DROP TABLE IF EXISTS `inventario_inicial`;
CREATE TABLE `inventario_inicial`  (
  `fec_ela` date NULL DEFAULT NULL,
  `cla_uni` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `det_pro` int UNSIGNED NULL DEFAULT NULL,
  `cant` int NULL DEFAULT NULL,
  `id_inv` int NOT NULL AUTO_INCREMENT,
  `web` int NULL DEFAULT 0,
  PRIMARY KEY (`id_inv`) USING BTREE,
  INDEX `cla_uni_fk_inv`(`cla_uni`) USING BTREE,
  INDEX `det_pro_fk_inv`(`det_pro`) USING BTREE,
  CONSTRAINT `inventario_inicial_ibfk_1` FOREIGN KEY (`cla_uni`) REFERENCES `unidades` (`cla_uni`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventario_inicial_ibfk_2` FOREIGN KEY (`det_pro`) REFERENCES `detalle_productos` (`det_pro`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 821 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'InnoDB free: 93184 kB; (`det_pro`) REFER `receta_electronica' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for jurisdicciones
-- ----------------------------
DROP TABLE IF EXISTS `jurisdicciones`;
CREATE TABLE `jurisdicciones`  (
  `id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
  `clave_secretaria` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  `des_jur` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT '',
  `id_cedis` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jurisfk1`(`id_cedis`) USING BTREE,
  CONSTRAINT `jurisdicciones_ibfk_1` FOREIGN KEY (`id_cedis`) REFERENCES `cedis` (`id_cedis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kardex
-- ----------------------------
DROP TABLE IF EXISTS `kardex`;
CREATE TABLE `kardex`  (
  `id_kardex` int NOT NULL AUTO_INCREMENT,
  `id_rec` int NULL DEFAULT NULL,
  `det_pro` int UNSIGNED NULL DEFAULT NULL,
  `cant` int NULL DEFAULT NULL,
  `tipo_mov` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `fol_aba` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `fecha` datetime(0) NULL DEFAULT NULL,
  `obser` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `id_usu` int UNSIGNED NULL DEFAULT NULL,
  `web` int NULL DEFAULT 0,
  PRIMARY KEY (`id_kardex`) USING BTREE,
  INDEX `kardex_fk1`(`id_rec`) USING BTREE,
  INDEX `kardex_fk2`(`det_pro`) USING BTREE,
  INDEX `kardex_ibfk_1`(`id_usu`) USING BTREE,
  INDEX `producto_fecha_cant`(`det_pro`, `fecha`, `cant`) USING BTREE,
  INDEX `det_producto_cantidad_fecha`(`det_pro`, `cant`, `fecha`) USING BTREE,
  INDEX `folio`(`fol_aba`) USING BTREE,
  CONSTRAINT `kardex_ibfk_1` FOREIGN KEY (`det_pro`) REFERENCES `detalle_productos` (`det_pro`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kardex_ibfk_2` FOREIGN KEY (`id_usu`) REFERENCES `usuarios` (`id_usu`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kardex_ibfk_3` FOREIGN KEY (`id_rec`) REFERENCES `receta` (`id_rec`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 27539 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'InnoDB free: 93184 kB; (`id_usu`) REFER `receta_electronica/' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kardex_rei
-- ----------------------------
DROP TABLE IF EXISTS `kardex_rei`;
CREATE TABLE `kardex_rei`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `lote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `caducidad` date NOT NULL,
  `cantidad` int NOT NULL,
  `movimiento` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `receta` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `folio_anterior` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `folio_nuevo` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `fecha_original` datetime(0) NULL DEFAULT NULL,
  `fecha_nueva` datetime(0) NULL DEFAULT NULL,
  `observacion` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `det_pro` int NULL DEFAULT NULL,
  `receta_id` int NULL DEFAULT NULL,
  `kardex_id` int NULL DEFAULT NULL,
  `abasto_id` int NULL DEFAULT NULL,
  `traspaso_id` int NULL DEFAULT NULL,
  `concat_prepare` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `unidad` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clave_lote_caducidad`(`clave`, `lote`, `caducidad`) USING BTREE,
  INDEX `receta`(`receta`) USING BTREE,
  INDEX `movimiento`(`movimiento`) USING BTREE,
  INDEX `movimiento_receta`(`movimiento`, `receta`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1802 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for medicos
-- ----------------------------
DROP TABLE IF EXISTS `medicos`;
CREATE TABLE `medicos`  (
  `nom_med` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ape_pat` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ape_mat` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nom_com` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `cedula` int NOT NULL AUTO_INCREMENT,
  `web` int NOT NULL,
  `rfc` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clauni` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cedulapro` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `f_status` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `fecnac` date NOT NULL,
  `iniRec` int NOT NULL,
  `finRec` int NOT NULL,
  `folAct` int NOT NULL,
  `tipoConsulta` enum('','Hospitalización','Consulta Externa','Urgencias') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  PRIMARY KEY (`cedula`) USING BTREE,
  INDEX `unis`(`clauni`) USING BTREE,
  INDEX `nom_comIndex`(`nom_com`) USING BTREE,
  INDEX `cedula`(`cedulapro`) USING BTREE,
  INDEX `paterno`(`ape_pat`) USING BTREE,
  CONSTRAINT `medicos_ibfk_1` FOREIGN KEY (`clauni`) REFERENCES `unidades` (`cla_uni`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10055 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mensaje_hl7
-- ----------------------------
DROP TABLE IF EXISTS `mensaje_hl7`;
CREATE TABLE `mensaje_hl7`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `mensaje` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `status` int NOT NULL,
  `fecha` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'NOW()',
  `idrec` int NULL DEFAULT NULL,
  `nummsg` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40274 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for municipios
-- ----------------------------
DROP TABLE IF EXISTS `municipios`;
CREATE TABLE `municipios`  (
  `cla_mun` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `des_mun` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT '',
  `jurisdiccion` smallint UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`cla_mun`) USING BTREE,
  INDEX `cla_jur_fk`(`jurisdiccion`) USING BTREE,
  CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`jurisdiccion`) REFERENCES `jurisdicciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 393 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for origen
-- ----------------------------
DROP TABLE IF EXISTS `origen`;
CREATE TABLE `origen`  (
  `id_ori` int NOT NULL DEFAULT 0,
  `des_ori` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `es_facturable` enum('SI','NO') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'NO',
  PRIMARY KEY (`id_ori`) USING BTREE,
  INDEX `id_descripcion`(`id_ori`, `des_ori`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pacientes
-- ----------------------------
DROP TABLE IF EXISTS `pacientes`;
CREATE TABLE `pacientes`  (
  `id_pac` int NOT NULL AUTO_INCREMENT,
  `ape_pat` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ape_mat` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nom_pac` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nom_com` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `fec_nac` date NOT NULL,
  `sexo` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `num_afi` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `tip_cob` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `ini_vig` date NOT NULL,
  `fin_vig` date NOT NULL,
  `web` int NOT NULL DEFAULT 0,
  `expediente` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `f_status` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `direccion` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `idpac_hl7` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '-',
  PRIMARY KEY (`id_pac`) USING BTREE,
  INDEX `nom_comIndex`(`nom_com`) USING BTREE,
  INDEX `num_afi`(`num_afi`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37099 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for parametros
-- ----------------------------
DROP TABLE IF EXISTS `parametros`;
CREATE TABLE `parametros`  (
  `id` tinyint UNSIGNED NOT NULL AUTO_INCREMENT,
  `clave` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `texto` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `entero` int NULL DEFAULT NULL,
  `decimal` decimal(12, 4) NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT NULL,
  `hora` time(0) NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp(0) NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `clave`(`clave`) USING HASH
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos`  (
  `cla_pro` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `des_pro` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `tip_pro` enum('MEDICAMENTO','MATERIAL DE CURACIÓN') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cos_pro` decimal(10, 2) NULL DEFAULT NULL,
  `pres_pro` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `amp_pro` int NULL DEFAULT NULL,
  `f_status` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `cla_lic` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clasificacion` enum('ABIERTO','ALTO COSTO','CONTROLADO','ANTIBIOTICO') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cobertura` enum('SEGURO POPULAR','SIGLO XXI','POBLACIÓN ABIERTA','GASTOS CATASTROFICOS','INSABI','FASSA') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `grupo_terapeutico` varchar(75) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `es_causes` enum('SI','NO') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `descripcion_fulltext` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `descripcion_terms` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `factor_empaque` smallint UNSIGNED NULL DEFAULT 1,
  PRIMARY KEY (`cla_pro`) USING BTREE,
  INDEX `indexprod1`(`cla_pro`) USING BTREE,
  INDEX `clave_clasificacion_cobertura`(`cla_pro`, `clasificacion`, `cobertura`) USING BTREE,
  INDEX `clave_larga`(`cla_lic`) USING BTREE,
  FULLTEXT INDEX `descripcion`(`descripcion_fulltext`)
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for productos_proyecto
-- ----------------------------
DROP TABLE IF EXISTS `productos_proyecto`;
CREATE TABLE `productos_proyecto`  (
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `proyecto` tinyint UNSIGNED NOT NULL,
  `costo` decimal(10, 2) NULL DEFAULT NULL,
  `ampuleo` int UNSIGNED NULL DEFAULT NULL,
  `dispensacion` enum('CAJAS','UNIDOSIS','PASTILLEO') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `via_administracion` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT 'N/A',
  `en_reabastecimiento` enum('SI','NO') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'SI',
  PRIMARY KEY (`clave`, `proyecto`) USING BTREE,
  INDEX `proyecto`(`proyecto`) USING BTREE,
  INDEX `clave`(`clave`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for productosnivel
-- ----------------------------
DROP TABLE IF EXISTS `productosnivel`;
CREATE TABLE `productosnivel`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nivel` int NULL DEFAULT NULL,
  `en_catalogo` enum('SI','NO') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'NO',
  `en_reabastecimiento` enum('SI','NO') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'SI',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `clave_nivel`(`clave`, `nivel`) USING BTREE,
  INDEX `clave`(`clave`) USING BTREE,
  CONSTRAINT `productosnivel_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 741 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reabastecimiento
-- ----------------------------
DROP TABLE IF EXISTS `reabastecimiento`;
CREATE TABLE `reabastecimiento`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `meses_consumidos` tinyint UNSIGNED NULL DEFAULT NULL,
  `consumo_total` int UNSIGNED NULL DEFAULT NULL,
  `consumo_mensual` int UNSIGNED NOT NULL,
  `existencia` int UNSIGNED NOT NULL,
  `inventario_fijo_sugerido` int UNSIGNED NOT NULL,
  `estado` enum('DESABASTO','NORMAL','SOBREABASTO') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `diagnostico` int NOT NULL,
  `sugerido` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clave`(`clave`) USING BTREE,
  CONSTRAINT `reabastecimiento_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 919 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reabastecimiento_registro
-- ----------------------------
DROP TABLE IF EXISTS `reabastecimiento_registro`;
CREATE TABLE `reabastecimiento_registro`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `folio` int NOT NULL,
  `fecha` date NOT NULL,
  `id_usuario` int NOT NULL,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `presentacion` smallint UNSIGNED NULL DEFAULT NULL,
  `meses_consumidos` tinyint UNSIGNED NULL DEFAULT NULL,
  `consumo_total` int UNSIGNED NULL DEFAULT NULL,
  `consumo_mensual` int UNSIGNED NOT NULL,
  `existencia` int UNSIGNED NOT NULL,
  `inventario_fijo_sugerido` int UNSIGNED NOT NULL,
  `estado` enum('DESABASTO','NORMAL','SOBREABASTO') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `diagnostico` int NOT NULL,
  `sugerido` int NOT NULL,
  `cantidad_pedido` int NOT NULL,
  `tipo` enum('SUGERIDO','EXTRAORDINARIO','MANUAL') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `enviado` enum('SI','NO') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clave`(`clave`) USING BTREE,
  CONSTRAINT `reabastecimiento_registro_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 725 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for reabastecimiento_temporal
-- ----------------------------
DROP TABLE IF EXISTS `reabastecimiento_temporal`;
CREATE TABLE `reabastecimiento_temporal`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `id_usuario` int UNSIGNED NOT NULL,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `presentacion` smallint UNSIGNED NULL DEFAULT NULL,
  `meses_consumidos` tinyint UNSIGNED NULL DEFAULT NULL,
  `consumo_total` int UNSIGNED NULL DEFAULT NULL,
  `consumo_mensual` int UNSIGNED NOT NULL,
  `existencia` int UNSIGNED NOT NULL,
  `inventario_fijo_sugerido` int UNSIGNED NOT NULL,
  `estado` enum('DESABASTO','NORMAL','SOBREABASTO') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `diagnostico` int NOT NULL,
  `sugerido` int NOT NULL,
  `tipo` enum('SUGERIDO','EXTRAORDINARIO','MANUAL') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clave`(`clave`) USING BTREE,
  INDEX `fk_usuario_id`(`id_usuario`) USING BTREE,
  INDEX `clave_usuario`(`clave`, `id_usuario`) USING BTREE,
  CONSTRAINT `fk_usuario_id` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usu`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reabastecimiento_temporal_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1024 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for receta
-- ----------------------------
DROP TABLE IF EXISTS `receta`;
CREATE TABLE `receta`  (
  `id_rec` int NOT NULL AUTO_INCREMENT,
  `fol_rec` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0',
  `id_pac` int NOT NULL DEFAULT 0,
  `cedula` int NOT NULL DEFAULT 0,
  `id_tip` tinyint UNSIGNED NOT NULL,
  `id_usu` int UNSIGNED NOT NULL DEFAULT 0,
  `enc_ser` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `carnet` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `id_ser` int NULL DEFAULT NULL,
  `fecha_hora` datetime(0) NULL DEFAULT NULL,
  `transito` int NULL DEFAULT NULL,
  `baja` int NULL DEFAULT 0,
  `notificahl7` int NULL DEFAULT NULL,
  `obser` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL,
  `tip_cons` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `hl7_obser` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id_rec`) USING BTREE,
  INDEX `cla_pac_fk`(`id_pac`) USING BTREE,
  INDEX `cla_med_fk`(`cedula`) USING BTREE,
  INDEX `id_rec`(`id_rec`) USING BTREE,
  INDEX `recetafk4`(`id_usu`) USING BTREE,
  INDEX `recetafk`(`id_tip`) USING BTREE,
  INDEX `receta_ibfk_6`(`id_ser`) USING BTREE,
  INDEX `transito_baja`(`transito`, `baja`) USING BTREE,
  INDEX `id_tipo_folio`(`id_rec`, `id_tip`, `fol_rec`) USING BTREE,
  INDEX `id_tipo`(`id_rec`, `id_tip`) USING BTREE,
  INDEX `cedula_tipo_fecha_paciente`(`cedula`, `id_tip`, `fecha_hora`, `id_pac`) USING BTREE,
  INDEX `baja_fecha`(`baja`, `fecha_hora`) USING BTREE,
  INDEX `tipo_transito_folio`(`id_tip`, `transito`, `fol_rec`) USING BTREE,
  INDEX `tipo_baja_observaciones`(`id_tip`, `baja`, `obser`(50)) USING BTREE,
  CONSTRAINT `receta_ibfk_3` FOREIGN KEY (`cedula`) REFERENCES `medicos` (`cedula`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `receta_ibfk_4` FOREIGN KEY (`id_pac`) REFERENCES `pacientes` (`id_pac`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `receta_ibfk_5` FOREIGN KEY (`id_usu`) REFERENCES `usuarios` (`id_usu`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `receta_ibfk_6` FOREIGN KEY (`id_tip`) REFERENCES `tipo_receta` (`id_tip`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `receta_ibfk_7` FOREIGN KEY (`id_ser`) REFERENCES `servicios` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 22557 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'InnoDB free: 93184 kB; (`id_tip`) REFER `receta_electronica/' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for receta_hl7_log
-- ----------------------------
DROP TABLE IF EXISTS `receta_hl7_log`;
CREATE TABLE `receta_hl7_log`  (
  `tipo_mensaje` varchar(250) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `hl7_mensaje` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `fecha` datetime(0) NULL DEFAULT NULL,
  `estatus` int NULL DEFAULT NULL,
  `proceso` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103683 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for receta_servicio
-- ----------------------------
DROP TABLE IF EXISTS `receta_servicio`;
CREATE TABLE `receta_servicio`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `receta` int NOT NULL,
  `cama` varchar(10) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `procedencia_insumo` enum('local','remoto') CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `turno` enum('MATUTINO','VESPERTINO','NOCTURNO') CHARACTER SET utf32 COLLATE utf32_unicode_ci NULL DEFAULT 'MATUTINO',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_receta`(`receta`) USING BTREE,
  CONSTRAINT `receta_servicio_ibfk_1` FOREIGN KEY (`receta`) REFERENCES `receta` (`id_rec`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf32 COLLATE = utf32_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for registro_entradas
-- ----------------------------
DROP TABLE IF EXISTS `registro_entradas`;
CREATE TABLE `registro_entradas`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `fecha` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `userIndex`(`user`) USING BTREE,
  CONSTRAINT `registro_entradas_ibfk_1` FOREIGN KEY (`user`) REFERENCES `usuarios` (`user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for registros_auditoria
-- ----------------------------
DROP TABLE IF EXISTS `registros_auditoria`;
CREATE TABLE `registros_auditoria`  (
  `id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario` int UNSIGNED NOT NULL,
  `tabla` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `id_registro` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `campo` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `tipo` enum('INSERT','UPDATE','DELETE') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `valor_anterior` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `valor_nuevo` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `fecha` date NULL DEFAULT curdate,
  `hora` time(0) NULL DEFAULT curtime,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `usuario`(`usuario`) USING BTREE,
  CONSTRAINT `registros_auditoria_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id_usu`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1351662 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for remisiones_traspasos
-- ----------------------------
DROP TABLE IF EXISTS `remisiones_traspasos`;
CREATE TABLE `remisiones_traspasos`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `unidad` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT NULL,
  `fecha_inicio` date NULL DEFAULT NULL,
  `fecha_fin` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for remisiones_traspasos_detalle
-- ----------------------------
DROP TABLE IF EXISTS `remisiones_traspasos_detalle`;
CREATE TABLE `remisiones_traspasos_detalle`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `folio` int NULL DEFAULT NULL,
  `detalle_producto` int NULL DEFAULT NULL,
  `codigo_barras` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cant` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_folio_remi_traspasos`(`folio`) USING BTREE,
  CONSTRAINT `fk_folio_remi_traspasos` FOREIGN KEY (`folio`) REFERENCES `remisiones_traspasos` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for reporte_abasto
-- ----------------------------
DROP TABLE IF EXISTS `reporte_abasto`;
CREATE TABLE `reporte_abasto`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `lote_original` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `lote` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `caducidad_original` date NULL DEFAULT NULL,
  `caducidad` date NOT NULL,
  `cantidad_original` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cantidad` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `origen` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cb` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `fecha` datetime(0) NOT NULL,
  `nom_abasto` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cargado` tinyint NOT NULL,
  `observacion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `historial` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clave`(`clave`) USING BTREE,
  INDEX `nom_abastoIndex`(`nom_abasto`) USING BTREE,
  CONSTRAINT `reporte_abasto_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 7750 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reporte_rurales
-- ----------------------------
DROP TABLE IF EXISTS `reporte_rurales`;
CREATE TABLE `reporte_rurales`  (
  `JURISDICCION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `UNIDAD` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Fecha` date NULL DEFAULT NULL,
  `Folio` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `Servicio` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `CLAVE_CB` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `Description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `Lote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `Caducidad` date NULL DEFAULT NULL,
  `Cant_Sol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `Cant_Sur` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `tipo_de_requerimiento` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `SUMINISTRO` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `COBERTURA` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `PRECIO_UNITARIO` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `TIPO_DE_UNIDAD` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `CLUES` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `Localidad` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for reporte_rurales_global
-- ----------------------------
DROP TABLE IF EXISTS `reporte_rurales_global`;
CREATE TABLE `reporte_rurales_global`  (
  `jurisdicion` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `clues` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `domicilio` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `localidad` varchar(65) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `tipo_unidad` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL,
  `lote` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `caducidad` date NULL DEFAULT NULL,
  `total` tinyint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for reporte_rurales_temporal
-- ----------------------------
DROP TABLE IF EXISTS `reporte_rurales_temporal`;
CREATE TABLE `reporte_rurales_temporal`  (
  `id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `nombre_unidad` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `nombre_jurisdiccion` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `clave` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `nombre_producto` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `FecEnt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `folio` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `caducidad` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `lote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `costo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `requerido` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `surtido` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for servicio_stock_minimo
-- ----------------------------
DROP TABLE IF EXISTS `servicio_stock_minimo`;
CREATE TABLE `servicio_stock_minimo`  (
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `stock_minimo` int UNSIGNED NOT NULL,
  `via_administracion` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT 'N/A',
  `dispensacion` enum('CAJAS','UNIDOSIS','PASTILLEO') CHARACTER SET utf32 COLLATE utf32_unicode_ci NULL DEFAULT 'CAJAS',
  `dosis` int NULL DEFAULT NULL,
  `es_consumible` enum('SI','NO') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT 'NO',
  `farmacia` enum('CONSULTA EXTERNA','UNIDOSIS') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT 'CONSULTA EXTERNA',
  PRIMARY KEY (`clave`) USING BTREE,
  INDEX `cla_pro`(`clave`) USING BTREE,
  CONSTRAINT `servicio_stock_minimo_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf32 COLLATE = utf32_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for servicios
-- ----------------------------
DROP TABLE IF EXISTS `servicios`;
CREATE TABLE `servicios`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `prefijo` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `tiene_bd` enum('SI','NO') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'NO',
  `nombre_bd` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idIndex`(`id`) USING BTREE,
  UNIQUE INDEX `prefijo`(`prefijo`) USING HASH,
  INDEX `descIndex`(`nombre`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for solicitudes_existencia
-- ----------------------------
DROP TABLE IF EXISTS `solicitudes_existencia`;
CREATE TABLE `solicitudes_existencia`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `folio` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `cantidad` int(11) UNSIGNED ZEROFILL NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT curdate,
  `hora` time(0) NULL DEFAULT curtime,
  `mes` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ampuleo` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `clave_folio`(`clave`, `folio`) USING BTREE,
  INDEX `folio`(`folio`) USING BTREE,
  INDEX `fecha`(`fecha`) USING BTREE,
  INDEX `fecha_clave_cantidad`(`fecha`, `clave`, `cantidad`) USING BTREE,
  INDEX `fecha_clave_mes_cant`(`fecha`, `clave`, `mes`, `cantidad`) USING BTREE,
  CONSTRAINT `solicitudes_existencia_ibfk_1` FOREIGN KEY (`clave`) REFERENCES `productos` (`cla_pro`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_codigob
-- ----------------------------
DROP TABLE IF EXISTS `tb_codigob`;
CREATE TABLE `tb_codigob`  (
  `F_Id` int NOT NULL AUTO_INCREMENT,
  `F_Cb` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F_Clave` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `F_Lote` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `F_Cadu` date NOT NULL,
  PRIMARY KEY (`F_Id`) USING BTREE,
  INDEX `codigo_barras`(`F_Cb`) USING BTREE,
  INDEX `clave`(`F_Clave`) USING BTREE,
  INDEX `CB1`(`F_Cb`, `F_Clave`, `F_Lote`, `F_Cadu`) USING BTREE,
  INDEX `clave_lote_caducidad_cb`(`F_Clave`, `F_Lote`, `F_Cadu`, `F_Cb`) USING BTREE,
  CONSTRAINT `tb_codigob_ibfk_1` FOREIGN KEY (`F_Clave`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 5878 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbcdm
-- ----------------------------
DROP TABLE IF EXISTS `tbcdm`;
CREATE TABLE `tbcdm`  (
  `FId` int NOT NULL AUTO_INCREMENT,
  `cla_pro` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `FCdm` int NOT NULL,
  `FFec` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`FId`) USING BTREE,
  INDEX `TbCdm_pk1`(`cla_pro`) USING BTREE,
  INDEX `fecha`(`FFec`) USING BTREE,
  CONSTRAINT `tbcdm_ibfk_1` FOREIGN KEY (`cla_pro`) REFERENCES `productos` (`cla_pro`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2407 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tipo_receta
-- ----------------------------
DROP TABLE IF EXISTS `tipo_receta`;
CREATE TABLE `tipo_receta`  (
  `id_tip` tinyint UNSIGNED NOT NULL AUTO_INCREMENT,
  `des_tip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for toma_inventario_detalles
-- ----------------------------
DROP TABLE IF EXISTS `toma_inventario_detalles`;
CREATE TABLE `toma_inventario_detalles`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `toma_inventario_encabezado_id` int UNSIGNED NOT NULL,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `lote` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `caducidad` date NULL DEFAULT NULL,
  `fisico` int NOT NULL,
  `sistema` int NOT NULL,
  `diferencia` int NOT NULL,
  `observaciones` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ampuleo` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `toma_inventari_detalles_ibfk_1`(`toma_inventario_encabezado_id`) USING BTREE,
  CONSTRAINT `toma_inventari_detalles_ibfk_1` FOREIGN KEY (`toma_inventario_encabezado_id`) REFERENCES `toma_inventario_encabezados` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 10113 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for toma_inventario_encabezados
-- ----------------------------
DROP TABLE IF EXISTS `toma_inventario_encabezados`;
CREATE TABLE `toma_inventario_encabezados`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `fecha` timestamp(0) NOT NULL DEFAULT current_timestamp(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `cla_uni` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `usuarios_id` int UNSIGNED NOT NULL,
  `estado` enum('Activo','Suspendido') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `toma_inventari_encabezado_ibfk_1`(`usuarios_id`) USING BTREE,
  INDEX `toma_inventari_encabezado_ibfk_2`(`cla_uni`) USING BTREE,
  CONSTRAINT `toma_inventari_encabezado_ibfk_1` FOREIGN KEY (`usuarios_id`) REFERENCES `usuarios` (`id_usu`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toma_inventari_encabezado_ibfk_2` FOREIGN KEY (`cla_uni`) REFERENCES `unidades` (`cla_uni`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for toma_inventario_temporal
-- ----------------------------
DROP TABLE IF EXISTS `toma_inventario_temporal`;
CREATE TABLE `toma_inventario_temporal`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `clave` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `lote` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `caducidad` date NULL DEFAULT NULL,
  `usuario` int UNSIGNED NOT NULL,
  `fisico` int NOT NULL,
  `sistema` int NOT NULL,
  `diferencia` int NOT NULL,
  `estatus_inventario` enum('Proceso','Finalizado') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ampuleo` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `toma_inventario_temporal_ibfk_1`(`usuario`) USING BTREE,
  CONSTRAINT `toma_inventario_temporal_ibfk_1` FOREIGN KEY (`usuario`) REFERENCES `usuarios` (`id_usu`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9675 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for traspasos
-- ----------------------------
DROP TABLE IF EXISTS `traspasos`;
CREATE TABLE `traspasos`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `folio` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `detalle_producto` int UNSIGNED NOT NULL,
  `codigo_barras` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `cantidad` int NULL DEFAULT NULL,
  `unidad_emisora` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `unidad_receptora` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `justificacion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `tipo_traspaso` enum('SALIDA','ENTRADA') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT curdate,
  `hora` time(0) NULL DEFAULT curtime,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_unidad_emisora`(`unidad_emisora`) USING BTREE,
  INDEX `fk_unidad_receptora`(`unidad_receptora`) USING BTREE,
  INDEX `fk_detalle_producto`(`detalle_producto`) USING BTREE,
  CONSTRAINT `fk_detalle_producto` FOREIGN KEY (`detalle_producto`) REFERENCES `detalle_productos` (`det_pro`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_unidad_emisora` FOREIGN KEY (`unidad_emisora`) REFERENCES `unidades` (`cla_uni`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_unidad_receptora` FOREIGN KEY (`unidad_receptora`) REFERENCES `unidades` (`cla_uni`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 696 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for unidades
-- ----------------------------
DROP TABLE IF EXISTS `unidades`;
CREATE TABLE `unidades`  (
  `cla_uni` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `des_uni` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cla_mun` int UNSIGNED NULL DEFAULT NULL,
  `nivel` int NULL DEFAULT NULL,
  `nivel_secretaria` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `claisem` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `jurisdiccion` smallint UNSIGNED NULL DEFAULT NULL,
  `domic` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `licencia` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `tip_uni` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `tip_sis` enum('UNIDOSIS','NO UNIDOSIS','-') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT 'NO UNIDOSIS',
  `frecuenciaDePaso` int NULL DEFAULT NULL,
  `clasificacion` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `localidad` varchar(65) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cla_uni`) USING BTREE,
  INDEX `cla_mun_fk`(`cla_mun`) USING BTREE,
  INDEX `clajur`(`jurisdiccion`) USING BTREE,
  CONSTRAINT `unidades_ibfk_1` FOREIGN KEY (`cla_mun`) REFERENCES `municipios` (`cla_mun`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `unidades_ibfk_2` FOREIGN KEY (`jurisdiccion`) REFERENCES `jurisdicciones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `id_usu` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NULL DEFAULT NULL,
  `pass` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `rol` int NULL DEFAULT NULL,
  `baja` int NULL DEFAULT NULL,
  `cla_uni` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cedula` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ape_pat` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `ape_mat` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '',
  `nombre_completo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_usu`) USING BTREE,
  UNIQUE INDEX `userIndex`(`user`) USING BTREE,
  INDEX `id_usu`(`id_usu`) USING BTREE,
  INDEX `claveUniIndex`(`cla_uni`) USING BTREE,
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`cla_uni`) REFERENCES `unidades` (`cla_uni`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 195 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'InnoDB free: 93184 kB; (`cla_uni`) REFER `receta_electronica' ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for catalogo_publica
-- ----------------------------
DROP VIEW IF EXISTS `catalogo_publica`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `catalogo_publica` AS select `pn`.`clave` AS `short_key`,`p`.`cla_lic` AS `medicine_key`,`p`.`des_pro` AS `description` from (`productosnivel` `pn` join `productos` `p` on(`pn`.`clave` = `p`.`cla_pro`)) where `pn`.`nivel` = (select `un`.`nivel` from (`usuarios` `u` join `unidades` `un` on(`u`.`cla_uni` = `un`.`cla_uni`)) where `u`.`id_usu` = 1) ;

-- ----------------------------
-- View structure for detalles_multiple_origen
-- ----------------------------
DROP VIEW IF EXISTS `detalles_multiple_origen`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `detalles_multiple_origen` AS select (select max(`detalle_productos`.`det_pro`) from `detalle_productos` where `detalle_productos`.`cla_pro` = `dp`.`cla_pro` and `detalle_productos`.`lot_pro` = `dp`.`lot_pro` and `detalle_productos`.`cad_pro` = `dp`.`cad_pro` group by `detalle_productos`.`cla_pro`) AS `det_pro_admon`,(select min(`detalle_productos`.`det_pro`) from `detalle_productos` where `detalle_productos`.`cla_pro` = `dp`.`cla_pro` and `detalle_productos`.`lot_pro` = `dp`.`lot_pro` and `detalle_productos`.`cad_pro` = `dp`.`cad_pro` group by `detalle_productos`.`cla_pro`) AS `det_pro_venta`,`dp`.`cla_pro` AS `cla_pro`,`dp`.`lot_pro` AS `lot_pro`,`dp`.`cad_pro` AS `cad_pro`,count(distinct `dp`.`det_pro`) AS `contador`,group_concat(distinct `dp`.`id_ori` separator ',') AS `origenes`,group_concat(distinct `dp`.`det_pro` separator ',') AS `detalles` from `detalle_productos` `dp` group by `dp`.`cla_pro`,`dp`.`lot_pro`,`dp`.`cad_pro` having `contador` > 1 ;

-- ----------------------------
-- View structure for detalles_origen
-- ----------------------------
DROP VIEW IF EXISTS `detalles_origen`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `detalles_origen` AS select (select `detalle_productos`.`det_pro` from `detalle_productos` where `detalle_productos`.`cla_pro` = `dp`.`cla_pro` and `detalle_productos`.`lot_pro` = `dp`.`lot_pro` and `detalle_productos`.`cad_pro` = `dp`.`cad_pro` and `detalle_productos`.`id_ori` = 0 and `detalle_productos`.`det_pro` = `dp`.`det_pro` group by `detalle_productos`.`det_pro`) AS `det_pro_admon`,(select `detalle_productos`.`det_pro` from `detalle_productos` where `detalle_productos`.`cla_pro` = `dp`.`cla_pro` and `detalle_productos`.`lot_pro` = `dp`.`lot_pro` and `detalle_productos`.`cad_pro` = `dp`.`cad_pro` and `detalle_productos`.`id_ori` = 2 group by `detalle_productos`.`cla_pro` limit 1) AS `det_pro_venta`,`dp`.`cla_pro` AS `cla_pro`,`dp`.`lot_pro` AS `lot_pro`,`dp`.`cad_pro` AS `cad_pro`,count(distinct `dp`.`id_ori`) AS `contador`,group_concat(distinct `dp`.`id_ori` separator ',') AS `origenes`,group_concat(distinct `dp`.`det_pro` separator ',') AS `detalles` from `detalle_productos` `dp` group by `dp`.`cla_pro`,`dp`.`lot_pro`,`dp`.`cad_pro` having `contador` > 1 ;

-- ----------------------------
-- View structure for existencias
-- ----------------------------
DROP VIEW IF EXISTS `existencias`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `existencias` AS select `p`.`cla_pro` AS `cla_pro`,`p`.`des_pro` AS `des_pro`,`dp`.`lot_pro` AS `lot_pro`,`dp`.`cad_pro` AS `cad_pro`,`dp`.`id_ori` AS `id_ori`,`i`.`cant` - ifnull(`a`.`apartado`,0) AS `cant`,`p`.`f_status` AS `f_status`,`i`.`cla_uni` AS `cla_uni`,`p`.`cos_pro` AS `cos_pro`,`dp`.`det_pro` AS `det_pro`,`i`.`id_inv` AS `id_inv`,ifnull(`a`.`apartado`,0) AS `apartado`,`p`.`clasificacion` AS `clasificacion`,`dp`.`ampuleo` AS `ampuleo`,`p`.`pres_pro` AS `presentacion` from (((`lodimed`.`productos` `p` join `lodimed`.`detalle_productos` `dp` on(`p`.`cla_pro` = `dp`.`cla_pro`)) join `lodimed`.`inventario` `i` on(`i`.`det_pro` = `dp`.`det_pro`)) left join (select `ap`.`detalle_producto` AS `producto`,sum(`ap`.`cantidad`) AS `apartado` from `lodimed`.`apartamiento` `ap` USE INDEX (`producto_status`) where `ap`.`status` = 1 group by `ap`.`detalle_producto`) `a` on(`a`.`producto` = `dp`.`det_pro`)) group by `i`.`id_inv` ;

-- ----------------------------
-- View structure for existencias_publica
-- ----------------------------
DROP VIEW IF EXISTS `existencias_publica`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `existencias_publica` AS select `dp`.`cla_pro` AS `short_key`,`p`.`cla_lic` AS `medicine_key`,floor((sum(`i`.`cant`) - sum(ifnull(`a`.`apartado`,0))) / `p`.`amp_pro`) AS `amount`,`u`.`claisem` AS `clues`,`i`.`cla_uni` AS `clues_interno` from ((((`lodimed`.`detalle_productos` `dp` join `lodimed`.`inventario` `i` on(`i`.`det_pro` = `dp`.`det_pro` and `i`.`cant` <> 0 and to_days(cast(`dp`.`cad_pro` as date)) - to_days(curdate()) > 0)) join `lodimed`.`productos` `p` on(`dp`.`cla_pro` = `p`.`cla_pro`)) join `lodimed`.`unidades` `u` on(`i`.`cla_uni` = `u`.`cla_uni`)) left join (select `ap`.`detalle_producto` AS `producto`,sum(`ap`.`cantidad`) AS `apartado` from `lodimed`.`apartamiento` `ap` USE INDEX (`producto_status`) where `ap`.`status` = 1 group by `ap`.`detalle_producto`) `a` on(`a`.`producto` = `dp`.`det_pro`)) group by `dp`.`cla_pro` order by NULL ;

-- ----------------------------
-- View structure for recetas
-- ----------------------------
DROP VIEW IF EXISTS `recetas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `recetas` AS select `dr`.`fol_det` AS `fol_det`,`r`.`fol_rec` AS `fol_rec`,`p`.`nom_com` AS `nom_com`,`r`.`fecha_hora` AS `fecha_hora`,`pr`.`cla_pro` AS `cla_pro`,`pr`.`des_pro` AS `des_pro`,`dr`.`can_sol` AS `can_sol`,`dr`.`cant_sur` AS `cant_sur`,`r`.`transito` AS `transito`,`r`.`id_rec` AS `id_rec`,`r`.`baja` AS `baja`,`r`.`tip_cons` AS `tip_cons`,`dr`.`indicaciones` AS `indicaciones`,`m`.`nom_com` AS `medico`,`dp`.`lot_pro` AS `lote`,`dp`.`cad_pro` AS `caducidad`,`dr`.`id_cau` AS `cause`,`m`.`cedulapro` AS `cedula`,`m`.`rfc` AS `rfc`,`p`.`expediente` AS `expe`,`p`.`num_afi` AS `afi`,`p`.`sexo` AS `sexo`,`p`.`tip_cob` AS `tip_cob`,year(curdate()) - year(`p`.`fec_nac`) AS `fechan`,`u`.`des_uni` AS `uni`,`u`.`claisem` AS `isem`,`u`.`jurisdiccion` AS `juris`,`u`.`cla_uni` AS `cla_uni`,`u`.`domic` AS `domic`,`u`.`licencia` AS `licencia`,`r`.`id_tip` AS `id_tip`,`dp`.`det_pro` AS `det_pro`,`dr`.`fec_sur` AS `fec_sur`,`dp`.`id_ori` AS `id_ori`,concat(`pr`.`cla_pro`,' - ',`pr`.`des_pro`) AS `clavepro`,concat('LOTE: ',`dp`.`lot_pro`,' - CADUCIDAD: ',`dp`.`cad_pro`) AS `lotepro`,`ser`.`nombre` AS `nom_ser`,`usu`.`nombre` AS `nombre`,`dr`.`id_cau2` AS `cause2`,`r`.`id_usu` AS `id_usu`,`pr`.`cos_pro` * `dr`.`cant_sur` AS `costo`,`pr`.`tip_pro` AS `tipo_medicamento`,`dr`.`status` AS `status`,`dr`.`baja` AS `baja_detalle`,`r`.`notificahl7` AS `esta_notificada`,`dr`.`hor_sur` AS `hora_surtido`,`dp`.`ampuleo` AS `ampuleo` from ((((((((`receta` `r` join `pacientes` `p`) join `detreceta` `dr`) join `detalle_productos` `dp`) join `productos` `pr`) join `medicos` `m`) join `unidades` `u`) join `servicios` `ser`) join `usuarios` `usu`) where `p`.`id_pac` = `r`.`id_pac` and `r`.`id_rec` = `dr`.`id_rec` and `dr`.`det_pro` = `dp`.`det_pro` and `dp`.`cla_pro` = `pr`.`cla_pro` and `r`.`cedula` = `m`.`cedula` and `r`.`id_usu` = `usu`.`id_usu` and `r`.`id_ser` = `ser`.`id` and `r`.`id_usu` = `usu`.`id_usu` and `usu`.`cla_uni` = `u`.`cla_uni` and `r`.`id_tip` not in (5,6) ;

-- ----------------------------
-- View structure for reporte_facturacion
-- ----------------------------
DROP VIEW IF EXISTS `reporte_facturacion`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reporte_facturacion` AS select 'Este reporte se genera desde UNIDOSIS' AS `folio`,'Este reporte se genera desde UNIDOSIS' AS `clave`,'Este reporte se genera desde UNIDOSIS' AS `clave_licitada`,'Este reporte se genera desde UNIDOSIS' AS `descripcion`,'Este reporte se genera desde UNIDOSIS' AS `tipo_producto`,'Este reporte se genera desde UNIDOSIS' AS `clasificacion`,'Este reporte se genera desde UNIDOSIS' AS `cobertura`,'Este reporte se genera desde UNIDOSIS' AS `lote`,'2020-01-01' AS `caducidad`,'2020-01-01' AS `fecha`,0 AS `tipo_receta`,0 AS `precio`,0 AS `solicitado`,0 AS `surtido`,0 AS `origen`,'Este reporte se genera desde UNIDOSIS' AS `origen_descripcion`,'Este reporte se genera desde UNIDOSIS' AS `padecimiento`,'Este reporte se genera desde UNIDOSIS' AS `padecimiento2`,'Este reporte se genera desde UNIDOSIS' AS `servicio`,'Este reporte se genera desde UNIDOSIS' AS `paciente`,'Este reporte se genera desde UNIDOSIS' AS `curp`,'Este reporte se genera desde UNIDOSIS' AS `medico`,0 AS `cedula` ;

-- ----------------------------
-- View structure for reporte_solicitado_vs_surtido
-- ----------------------------
DROP VIEW IF EXISTS `reporte_solicitado_vs_surtido`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reporte_solicitado_vs_surtido` AS select 'Este reporte se genera desde UNIDOSIS' AS `consecutivo`,'Este reporte se genera desde UNIDOSIS' AS `folio`,'Este reporte se genera desde UNIDOSIS' AS `clave`,'Este reporte se genera desde UNIDOSIS' AS `descripcion`,0 AS `total_solicitado`,0 AS `cajas_solicitado`,0 AS `restos_solicitado`,0 AS `total_surtido`,0 AS `cajas_surtido`,0 AS `restos_surtido`,'2020-01-01' AS `fecha` ;

-- ----------------------------
-- View structure for reporte_surtido
-- ----------------------------
DROP VIEW IF EXISTS `reporte_surtido`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reporte_surtido` AS select 'Este reporte se genera desde UNIDOSIS' AS `clave`,'Este reporte se genera desde UNIDOSIS' AS `des_pro`,0 AS `solicitado_suma`,0 AS `surtido_suma`,'2020-01-01' AS `fecha` ;

-- ----------------------------
-- View structure for tb_abastoweb
-- ----------------------------
DROP VIEW IF EXISTS `tb_abastoweb`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `tb_abastoweb` AS select `ase`.`folio` AS `F_ClaDoc`,`ase`.`unidad` AS `F_ClaCli`,`dp`.`cla_pro` AS `F_Clave`,`dp`.`lot_pro` AS `F_Lote`,date_format(`dp`.`cad_pro`,'%d/%m/%Y') AS `F_Caducidad`,`dp`.`id_ori` AS `F_Origen`,`cb`.`F_Cb` AS `F_Cb`,`ase`.`cantidad` AS `F_Cantidad`,`ase`.`estado_almacen` AS `F_Sts` from ((`abastos_servicio` `ase` join `detalle_productos` `dp` on(`ase`.`detalle_producto` = `dp`.`det_pro`)) join `tb_codigob` `cb` on(`ase`.`codigo_barras` = `cb`.`F_Id`)) ;

-- ----------------------------
-- View structure for tb_uniatn
-- ----------------------------
DROP VIEW IF EXISTS `tb_uniatn`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `tb_uniatn` AS select `unidades`.`cla_uni` AS `F_IdReporte`,`unidades`.`cla_uni` AS `F_ClaCli` from `unidades` where `unidades`.`tip_uni` = 'SERVICIO' ;

-- ----------------------------
-- View structure for ventradas
-- ----------------------------
DROP VIEW IF EXISTS `ventradas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ventradas` AS (select `dp`.`cla_pro` AS `cla_pro`,`dp`.`lot_pro` AS `lot_pro`,`dp`.`cad_pro` AS `cad_pro`,`dp`.`id_ori` AS `id_ori`,`k`.`cant` AS `cant`,`k`.`tipo_mov` AS `tipo_mov`,`k`.`fol_aba` AS `fol_aba`,`r`.`id_rec` AS `receta`,`k`.`id_rec` AS `kardex`,`r`.`fol_rec` AS `fol_rec`,`k`.`fecha` AS `fecha`,`k`.`obser` AS `obser` from ((`kardex` `k` join `detalle_productos` `dp`) join `receta` `r`) where `k`.`det_pro` = `dp`.`det_pro` and `k`.`id_rec` = `r`.`id_rec` and `k`.`cant` <> 0 and `k`.`tipo_mov` not in ('SALIDA RECETA','SALIDA POR AJUSTE','SALIDA POR TRASPASO') group by `k`.`id_kardex`) ;

-- ----------------------------
-- View structure for vsalidas
-- ----------------------------
DROP VIEW IF EXISTS `vsalidas`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vsalidas` AS (select `dp`.`cla_pro` AS `cla_pro`,`dp`.`lot_pro` AS `lot_pro`,`dp`.`cad_pro` AS `cad_pro`,`k`.`cant` AS `cant`,`dp`.`id_ori` AS `id_ori`,`k`.`tipo_mov` AS `tipo_mov`,`r`.`fol_rec` AS `fol_rec`,`p`.`nom_com` AS `paciente`,`m`.`nom_com` AS `medico`,`k`.`fecha` AS `fecha`,`k`.`obser` AS `obser` from ((((`kardex` `k` join `detalle_productos` `dp`) join `receta` `r`) join `pacientes` `p`) join `medicos` `m`) where `k`.`det_pro` = `dp`.`det_pro` and `k`.`id_rec` = `r`.`id_rec` and `r`.`id_pac` = `p`.`id_pac` and `r`.`cedula` = `m`.`cedula` and `k`.`cant` <> 0 and `k`.`tipo_mov` like '%SALIDA%' group by `k`.`id_kardex`) ;

-- ----------------------------
-- View structure for vsalidasajustes
-- ----------------------------
DROP VIEW IF EXISTS `vsalidasajustes`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `vsalidasajustes` AS (select `dp`.`cla_pro` AS `cla_pro`,`dp`.`lot_pro` AS `lot_pro`,`dp`.`cad_pro` AS `cad_pro`,`k`.`cant` AS `cant`,`dp`.`id_ori` AS `id_ori`,`k`.`tipo_mov` AS `tipo_mov`,'-' AS `fol_rec`,'-' AS `paciente`,'-' AS `medico`,`k`.`fecha` AS `fecha`,`k`.`obser` AS `obser` from (`kardex` `k` join `detalle_productos` `dp`) where `k`.`det_pro` = `dp`.`det_pro` and (`k`.`tipo_mov` = 'SALIDA POR AJUSTE' or `k`.`tipo_mov` = 'SALIDA POR TRASPASO')) ;

-- ----------------------------
-- Procedure structure for calcular_reabastecimiento
-- ----------------------------
DROP PROCEDURE IF EXISTS `calcular_reabastecimiento`;
delimiter ;;
CREATE PROCEDURE `calcular_reabastecimiento`(IN `usuario` int)
BEGIN  DECLARE `fecha_inicio` DATE; DECLARE `fecha_fin` DATE; DECLARE  `frecuencia_paso` INT; DECLARE  `minimo_catalogo` INT; DECLARE  `porcentaje_adicional` INT; SELECT i.comienzo_proyecto, DATE_FORMAT(CURDATE(), '%Y-%m-01') INTO  `fecha_inicio`, `fecha_fin` FROM indices AS i; SELECT u.frecuenciaDePaso AS frecuencia INTO `frecuencia_paso` FROM unidades AS u INNER JOIN usuarios AS us ON us.cla_uni = u.cla_uni LIMIT 1;  SELECT p.entero INTO `porcentaje_adicional` FROM parametros AS p  WHERE p.clave = 'porcentaje_adicional'; SELECT p.entero INTO `minimo_catalogo` FROM parametros AS p  WHERE p.clave = 'minimo_catalogo'; INSERT INTO `reabastecimiento_temporal`( `fecha`,`id_usuario`,`clave`, `presentacion`, `meses_consumidos`, `consumo_total`, `consumo_mensual`, `existencia`, `inventario_fijo_sugerido`, `estado`, `diagnostico`, `sugerido`,`tipo`,`cantidad`)  SELECT NOW(),`usuario` AS idUsuario,rep.producto,p.amp_pro AS presentacion,rep.meses,rep.consumo,rep.consumo_mensual,rep.existencia,rep.inventario_fijo_sugerido,IF (rep.existencia-rep.inventario_fijo_sugerido< 0,'DESABASTO',IF (rep.existencia-rep.inventario_fijo_sugerido> 0,'SOBREABASTO','NORMAL')) AS estado,(rep.existencia-rep.inventario_fijo_sugerido) AS diagnostico,IF (rep.inventario_fijo_sugerido-rep.existencia< 0,0,rep.inventario_fijo_sugerido-rep.existencia) AS sugerido,'sugerido' AS tipo,IF (rep.inventario_fijo_sugerido-rep.existencia< 0,0,rep.inventario_fijo_sugerido-rep.existencia) AS cantidad FROM ( SELECT pn.clave AS producto,pn.en_catalogo,IFNULL(inv.existencia,0) AS existencia,IFNULL(SUM(consumo.solicitado),0) AS consumo,IFNULL(COUNT(consumo.mes),0) AS meses,IFNULL(CEILING(AVG(consumo.solicitado)),0) AS consumo_mensual,IFNULL(CEILING(AVG(consumo.solicitado)*(`porcentaje_adicional`/`frecuencia_paso`)),IF (pn.en_catalogo='SI',`minimo_catalogo`,0)) AS inventario_fijo_sugerido FROM productosnivel AS pn LEFT JOIN ( SELECT inuni.producto,SUM(inuni.existencia) AS existencia FROM (( SELECT dp.cla_pro AS producto,SUM(IFNULL(i.inventario,0)-IFNULL(a.apartado,0)) AS existencia FROM detalle_productos AS dp INNER JOIN ( SELECT inv.det_pro AS producto,SUM(inv.cant) AS inventario FROM inventario AS inv WHERE inv.cant> 0 GROUP BY inv.det_pro) AS i ON i.producto=dp.det_pro AND DATEDIFF(DATE(dp.cad_pro),now())> 0 LEFT JOIN ( SELECT ap.detalle_producto AS producto,SUM(ap.cantidad) AS apartado FROM apartamiento AS ap USE INDEX (producto_status) WHERE ap.`status`=1 GROUP BY ap.detalle_producto) AS a ON a.producto=dp.det_pro GROUP BY dp.cla_pro) UNION ALL ( SELECT dp.cla_pro AS producto,SUM(IFNULL(i.inventario,0)-IFNULL(a.apartado,0)) AS existencia FROM lodimed_unidosis.detalle_productos AS dp INNER JOIN ( SELECT inv.det_pro AS producto,SUM(inv.cant) AS inventario FROM lodimed_unidosis.inventario AS inv WHERE inv.cant> 0 GROUP BY inv.det_pro) AS i ON i.producto=dp.det_pro AND DATEDIFF(DATE(dp.cad_pro),now())> 0 LEFT JOIN ( SELECT ap.detalle_producto AS producto,SUM(ap.cantidad) AS apartado FROM lodimed_unidosis.apartamiento AS ap USE INDEX (producto_status) WHERE ap.`status`=1 GROUP BY ap.detalle_producto) AS a ON a.producto=dp.det_pro GROUP BY dp.cla_pro)) AS inuni GROUP BY inuni.producto) AS inv ON pn.clave=inv.producto LEFT JOIN ( SELECT con.clave,SUM(con.solicitado) AS solicitado,con.mes FROM (( SELECT t.clave,t.solicitado,t.mes FROM (( SELECT dp.cla_pro AS clave,Sum(dr.can_sol) AS solicitado,DATE_FORMAT(r.fecha_hora,'%Y%m') AS mes FROM detreceta AS dr INNER JOIN detalle_productos AS dp ON dr.det_pro=dp.det_pro AND dr.baja=0 INNER JOIN receta AS r ON dr.id_rec=r.id_rec AND r.baja=0 AND r.id_tip IN (1,2,3) AND r.fecha_hora BETWEEN `fecha_inicio` AND `fecha_fin` GROUP BY dp.cla_pro,mes) UNION ALL ( SELECT se.clave AS clave,Sum(se.cantidad) AS solicitado,se.mes FROM solicitudes_existencia AS se WHERE se.fecha BETWEEN `fecha_inicio` AND `fecha_fin` GROUP BY clave,mes)) AS t) UNION ALL ( SELECT t.clave,t.solicitado,t.mes FROM (( SELECT dp.cla_pro AS clave,Sum(dr.can_sol) AS solicitado,DATE_FORMAT(r.fecha_hora,'%Y%m') AS mes FROM lodimed_unidosis.detreceta AS dr INNER JOIN lodimed_unidosis.detalle_productos AS dp ON dr.det_pro=dp.det_pro AND dr.baja=0 INNER JOIN lodimed_unidosis.receta AS r ON dr.id_rec=r.id_rec AND r.baja=0 AND r.id_tip=4 AND r.fecha_hora BETWEEN `fecha_inicio` AND `fecha_fin` GROUP BY dp.cla_pro,mes) UNION ALL ( SELECT se.clave AS clave,Sum(se.cantidad) AS solicitado,se.mes FROM lodimed_unidosis.solicitudes_existencia AS se WHERE se.fecha BETWEEN `fecha_inicio` AND `fecha_fin` GROUP BY clave,mes)) AS t)) AS con GROUP BY con.clave,con.mes) AS consumo ON pn.clave=consumo.clave WHERE pn.en_catalogo='SI' GROUP BY pn.clave) AS rep INNER JOIN productos AS p ON rep.producto=p.cla_pro FOR UPDATE;  END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for calcular_reabastecimiento_con_cdm
-- ----------------------------
DROP PROCEDURE IF EXISTS `calcular_reabastecimiento_con_cdm`;
delimiter ;;
CREATE PROCEDURE `calcular_reabastecimiento_con_cdm`(IN `usuario` int)
BEGIN  DECLARE `fecha_inicio` DATE; DECLARE `fecha_fin` DATE; DECLARE  `frecuencia_paso` INT; DECLARE  `minimo_catalogo` INT; DECLARE  `porcentaje_adicional` INT; SELECT i.comienzo_proyecto, DATE_FORMAT(CURDATE(), '%Y-%m-01') INTO  `fecha_inicio`, `fecha_fin` FROM indices AS i; SELECT u.frecuenciaDePaso AS frecuencia INTO `frecuencia_paso` FROM unidades AS u INNER JOIN usuarios AS us ON us.cla_uni = u.cla_uni LIMIT 1;  SELECT p.entero INTO `porcentaje_adicional` FROM parametros AS p  WHERE p.clave = 'porcentaje_adicional'; SELECT p.entero INTO `minimo_catalogo` FROM parametros AS p  WHERE p.clave = 'minimo_catalogo'; INSERT INTO `reabastecimiento_temporal` (  `fecha`,  `id_usuario`,  `clave`,  `presentacion`,  `meses_consumidos`,  `consumo_total`,  `consumo_mensual`,  `existencia`,  `inventario_fijo_sugerido`,  `estado`,  `diagnostico`,  `sugerido`,  `tipo`,  `cantidad`  ) SELECT CURDATE(),`usuario`,rep.clave,p.amp_pro AS presentacion,rep.meses,rep.consumo_total,rep.consumo_promedio,rep.existencia,rep.inventario_fijo_sugerido,IF (rep.existencia-rep.inventario_fijo_sugerido< 0,'DESABASTO',IF (rep.existencia-rep.inventario_fijo_sugerido> 0,'SOBREABASTO','NORMAL')) AS estado,(rep.existencia-rep.inventario_fijo_sugerido) AS diagnostico,IF (rep.inventario_fijo_sugerido-rep.existencia< 0,0,rep.inventario_fijo_sugerido-rep.existencia) AS sugerido,'sugerido' AS tipo,IF (rep.inventario_fijo_sugerido-rep.existencia< 0,0,rep.inventario_fijo_sugerido-rep.existencia) AS cantidad FROM ( SELECT pn.clave,0 AS meses,IFNULL(cdm.FCdm,0) AS consumo_total,IFNULL(cdm.FCdm,0) AS consumo_promedio,IFNULL(inv.existencia,0) AS existencia,IFNULL(CEILING(cdm.FCdm*(`porcentaje_adicional`/`frecuencia_paso`)),IF (pn.en_catalogo='SI',`minimo_catalogo`,0)) AS inventario_fijo_sugerido FROM productosnivel AS pn LEFT JOIN ( SELECT dtc.cla_pro,SUM(dtc.FCdm) AS FCdm,dtc.FFec FROM ( SELECT tc.cla_pro,tc.FCdm,tc.FFec FROM tbcdm AS tc UNION ALL SELECT tc.cla_pro,tc.FCdm,tc.FFec FROM lodimed_unidosis.tbcdm AS tc) AS dtc GROUP BY dtc.cla_pro) AS cdm ON cdm.cla_pro=pn.clave LEFT JOIN ( SELECT inuni.producto,SUM(inuni.existencia) AS existencia FROM (( SELECT dp.cla_pro AS producto,SUM(IFNULL(i.inventario,0)-IFNULL(a.apartado,0)) AS existencia FROM detalle_productos AS dp INNER JOIN ( SELECT inv.det_pro AS producto,SUM(inv.cant) AS inventario FROM inventario AS inv WHERE inv.cant> 0 GROUP BY inv.det_pro) AS i ON i.producto=dp.det_pro AND DATEDIFF(DATE(dp.cad_pro),now())> 0 LEFT JOIN ( SELECT ap.detalle_producto AS producto,SUM(ap.cantidad) AS apartado FROM apartamiento AS ap USE INDEX (producto_status) WHERE ap.`status`=1 GROUP BY ap.detalle_producto) AS a ON a.producto=dp.det_pro GROUP BY dp.cla_pro) UNION ALL ( SELECT dp.cla_pro AS producto,SUM(IFNULL(i.inventario,0)-IFNULL(a.apartado,0)) AS existencia FROM lodimed_unidosis.detalle_productos AS dp INNER JOIN ( SELECT inv.det_pro AS producto,SUM(inv.cant) AS inventario FROM lodimed_unidosis.inventario AS inv WHERE inv.cant> 0 GROUP BY inv.det_pro) AS i ON i.producto=dp.det_pro AND DATEDIFF(DATE(dp.cad_pro),now())> 0 LEFT JOIN ( SELECT ap.detalle_producto AS producto,SUM(ap.cantidad) AS apartado FROM lodimed_unidosis.apartamiento AS ap USE INDEX (producto_status) WHERE ap.`status`=1 GROUP BY ap.detalle_producto) AS a ON a.producto=dp.det_pro GROUP BY dp.cla_pro)) AS inuni GROUP BY inuni.producto) AS inv ON pn.clave=inv.producto WHERE pn.en_catalogo='SI') AS rep INNER JOIN productos AS p ON p.cla_pro=rep.clave FOR UPDATE;  END
;;
delimiter ;

-- ----------------------------
-- Function structure for CLEAR_PREFIXES
-- ----------------------------
DROP FUNCTION IF EXISTS `CLEAR_PREFIXES`;
delimiter ;;
CREATE FUNCTION `CLEAR_PREFIXES`(`prescription_number` VARCHAR ( 100 ))
 RETURNS varchar(100) CHARSET utf8mb3 COLLATE utf8mb3_unicode_ci
BEGIN  RETURN REPLACE ( REPLACE ( `prescription_number`, 'HL7_TEMPORAL_', '' ), 'HL7', '' ); END
;;
delimiter ;

-- ----------------------------
-- Function structure for GENERATE_FULLTEXT
-- ----------------------------
DROP FUNCTION IF EXISTS `GENERATE_FULLTEXT`;
delimiter ;;
CREATE FUNCTION `GENERATE_FULLTEXT`(`target_text` text)
 RETURNS text CHARSET utf8mb3 COLLATE utf8mb3_unicode_ci
  DETERMINISTIC
  COMMENT 'Genera una cadena de texto correcta para indexar para usar FULL-TEXT-SEARCH.'
BEGIN   DECLARE `result` text;      SET `result` = REGEXP_REPLACE(`target_text`, '[,:;\\("\\)\\*°]', ' ');   SET `result` = REGEXP_REPLACE(`result`, '(?<![0-9])/(?![0-9])', ' ');      SET `result` = REGEXP_REPLACE(`result`, '(?=[^0-9])\\.(?=[^0-9])', ' ');   SET `result` = REGEXP_REPLACE(`result`, '(?<=[A-Z])\\.', ' ');      SET `result` = REGEXP_REPLACE(`result`, '([0-9]+)\\.([0-9]+)', '\\1DOT\\2');   SET `result` = REGEXP_REPLACE(`result`, '(?<= )+([0-9]{1}/[0-9]{1})(?= )?', 'NUM\\1');   SET `result` = REGEXP_REPLACE(`result`, '(?<= )+([0-9]{3})(?= )', 'NUM\\1');   SET `result` = REGEXP_REPLACE(`result`, '(?<= )+([0-9]{2})(?= )', 'NUM\\1');   SET `result` = REGEXP_REPLACE(`result`, '(?<= )+([0-9]{1})(?= )', 'NUM\\1');      SET `result` = REGEXP_REPLACE(`result`, ' (.{1}) ', ' ');   SET `result` = REGEXP_REPLACE(`result`, ' (.{2}) ', ' ');   SET `result` = REGEXP_REPLACE(`result`, ' (.{3}) ', ' ');     SET `result` = REGEXP_REPLACE(`result`, '([[:space:]]){1,}', ' ');      RETURN TRIM(`result`); END
;;
delimiter ;

-- ----------------------------
-- Function structure for PREPARE_TERMS
-- ----------------------------
DROP FUNCTION IF EXISTS `PREPARE_TERMS`;
delimiter ;;
CREATE FUNCTION `PREPARE_TERMS`(`target_text` text)
 RETURNS text CHARSET utf8mb3 COLLATE utf8mb3_unicode_ci
  DETERMINISTIC
  COMMENT 'Prepara los terminos del FTS para ser separados por terminos.'
BEGIN   DECLARE `result` text;      SET `result` = REGEXP_REPLACE(`target_text`, ' (.{1,3}) ', ' ');      SET `result` = REGEXP_REPLACE(`result`, '([[:space:]]){1,}', ' ');   SET `result` = REGEXP_REPLACE(`result`, '(?<=[0-9])DOT(?=[0-9])', '\\.');   SET `result` = REGEXP_REPLACE(`result`, '(?<= )NUM(?=[0-9])', '');   SET `result` = REGEXP_REPLACE(`result`, ' (.{1,2}) ', ' ');   SET `result` = REGEXP_REPLACE(`result`, '([[:space:]]){1,}', ' ');   SET `result` = REGEXP_REPLACE(`result` COLLATE utf8_bin,'[Áá]','a');   SET `result` = REGEXP_REPLACE(`result`,'[Éé]','e');   SET `result` = REGEXP_REPLACE(`result`,'[Íí]','i');   SET `result` = REGEXP_REPLACE(`result`,'[Óó]','o');   SET `result` = REGEXP_REPLACE(`result`,'[ÚúÜü]','u');      RETURN TRIM(LOWER(CONVERT(`result` USING utf8) COLLATE utf8_unicode_ci)); END
;;
delimiter ;

-- ----------------------------
-- Function structure for SDATETIME_FORMAT
-- ----------------------------
DROP FUNCTION IF EXISTS `SDATETIME_FORMAT`;
delimiter ;;
CREATE FUNCTION `SDATETIME_FORMAT`(`custome_date` DATETIME)
 RETURNS varchar(19) CHARSET utf8mb3 COLLATE utf8mb3_unicode_ci
BEGIN  RETURN DATE_FORMAT(`custome_date`, '%d/%m/%Y %H:%i:%s'); END
;;
delimiter ;

-- ----------------------------
-- Function structure for SDATE_FORMAT
-- ----------------------------
DROP FUNCTION IF EXISTS `SDATE_FORMAT`;
delimiter ;;
CREATE FUNCTION `SDATE_FORMAT`(`custome_date` DATE)
 RETURNS varchar(10) CHARSET utf8mb3 COLLATE utf8mb3_unicode_ci
BEGIN  RETURN DATE_FORMAT(`custome_date`, '%d/%m/%Y'); END
;;
delimiter ;

-- ----------------------------
-- Function structure for TRUNCATE_DESCRIPTION
-- ----------------------------
DROP FUNCTION IF EXISTS `TRUNCATE_DESCRIPTION`;
delimiter ;;
CREATE FUNCTION `TRUNCATE_DESCRIPTION`(`description` TEXT)
 RETURNS varchar(83) CHARSET utf8mb3
BEGIN   RETURN CONCAT(SUBSTR(`description` FROM 1 FOR 80), '...'); END
;;
delimiter ;

-- ----------------------------
-- Event structure for clean_audit_records
-- ----------------------------
DROP EVENT IF EXISTS `clean_audit_records`;
delimiter ;;
CREATE EVENT `clean_audit_records`
ON SCHEDULE
EVERY '1' DAY STARTS '2019-08-20 09:00:00'
COMMENT 'Limpia las tablas de auditoria del sistema.'
DO BEGIN

DELETE
FROM
registro_entradas 
WHERE
fecha <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

DELETE
FROM
mensaje_hl7
WHERE
fecha <= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

DELETE
FROM
receta_hl7_log
WHERE
fecha <= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

DELETE
FROM
registros_auditoria
WHERE
fecha <= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

DELETE
FROM
apartamiento
WHERE
fecha_actualizacion <= DATE_SUB(CURDATE(), INTERVAL 4 MONTH);

END
;;
delimiter ;

-- ----------------------------
-- Event structure for release_separated_stock
-- ----------------------------
DROP EVENT IF EXISTS `release_separated_stock`;
delimiter ;;
CREATE EVENT `release_separated_stock`
ON SCHEDULE
EVERY '1' HOUR STARTS '2018-10-29 00:00:00'
DO BEGIN SET @limitDate := TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 1 DAY), CURTIME()); UPDATE apartamiento AS target JOIN( SELECT   dr.fol_det AS id FROM   receta AS r INNER JOIN detreceta AS dr ON dr.id_rec = r.id_rec AND r.fol_rec LIKE 'HL7%' AND r.baja = 0 AND r.transito = 2 AND r.fecha_hora <= @limitDate ) AS source ON target.detalle_receta = source.id AND target.`status` = 1 SET `status` = 2; UPDATE `detreceta` AS target JOIN (     SELECT       r.id_rec     FROM       receta AS r     WHERE       r.fol_rec LIKE 'HL7_TEMPORAL%'     AND r.baja = 0     AND r.fecha_hora <= @limitDate   ) AS source ON target.id_rec = source.id_rec SET `can_sol` = '0',  `cant_sur` = '0',  `baja` = '1' ; UPDATE receta AS target JOIN (     SELECT       r.id_rec     FROM       receta AS r     WHERE       r.fol_rec LIKE 'HL7_TEMPORAL%'     AND r.baja = 0     AND r.fecha_hora <= @limitDate   ) AS source ON target.id_rec = source.id_rec SET target.fol_rec = CONCAT(target.fol_rec,'-CP-', NOW()), target.transito = 3, target.baja = 1; END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table abastos_servicio
-- ----------------------------
DROP TRIGGER IF EXISTS `insert_status`;
delimiter ;;
CREATE TRIGGER `insert_status` BEFORE INSERT ON `abastos_servicio` FOR EACH ROW SET NEW.estado = NEW.estado_almacen + 1
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table abastos_servicio
-- ----------------------------
DROP TRIGGER IF EXISTS `update_status`;
delimiter ;;
CREATE TRIGGER `update_status` BEFORE UPDATE ON `abastos_servicio` FOR EACH ROW SET NEW.estado = NEW.estado_almacen + 1
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table inventario
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_existencias_insert`;
delimiter ;;
CREATE TRIGGER `trg_existencias_insert` AFTER INSERT ON `inventario` FOR EACH ROW BEGIN















	INSERT INTO actualizador_scr.existencias_trg (unidad, inventario, tipo, `status`)















VALUES















	(NEW.cla_uni, NEW.id_inv, 0, 0); END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table inventario
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_existencias_update`;
delimiter ;;
CREATE TRIGGER `trg_existencias_update` AFTER UPDATE ON `inventario` FOR EACH ROW BEGIN















	INSERT INTO actualizador_scr.existencias_trg (unidad, inventario, tipo, `status`)















VALUES















	(NEW.cla_uni, NEW.id_inv, 1, 0); END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table productos
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_update_description`;
delimiter ;;
CREATE TRIGGER `trg_update_description` BEFORE UPDATE ON `productos` FOR EACH ROW SET NEW.`descripcion_fulltext` = GENERATE_FULLTEXT(NEW.des_pro), NEW.`descripcion_terms` = PREPARE_TERMS(GENERATE_FULLTEXT(NEW.des_pro))
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table solicitudes_existencia
-- ----------------------------
DROP TRIGGER IF EXISTS `agregar_mes`;
delimiter ;;
CREATE TRIGGER `agregar_mes` BEFORE INSERT ON `solicitudes_existencia` FOR EACH ROW BEGIN
SET NEW.mes = DATE_FORMAT(NEW.fecha,'%Y%m');
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
