-- sgp.cat_area definition

CREATE TABLE `cat_area` (
  `id_area` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_area`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_articulo definition

CREATE TABLE `cat_articulo` (
  `id_articulo` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `cantidadMax` int DEFAULT NULL,
  `unidad` varchar(45) DEFAULT NULL,
  `detalle` varchar(150) DEFAULT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_banco definition

CREATE TABLE `cat_banco` (
  `cod_banco` varchar(4) NOT NULL,
  `nb_descripcion` varchar(40) DEFAULT NULL,
  `nb_razon_social` varchar(120) DEFAULT NULL,
  `fh_vigencia_ini` date DEFAULT NULL,
  `fh_vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`cod_banco`),
  UNIQUE KEY `cod_banco` (`cod_banco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_cuota_imss definition

CREATE TABLE `cat_cuota_imss` (
  `clave` varchar(5) NOT NULL,
  `no_clave` tinyint NOT NULL DEFAULT '0',
  `descripcion` varchar(100) NOT NULL,
  `base_salarial` varchar(5) NOT NULL,
  `base_min` decimal(12,2) NOT NULL,
  `base_max` decimal(12,2) NOT NULL,
  `cuota` decimal(8,6) NOT NULL,
  `tipo_cuota` varchar(1) NOT NULL DEFAULT 'T',
  `vigencia` date NOT NULL,
  PRIMARY KEY (`clave`,`no_clave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_estatus_incidencia definition

CREATE TABLE `cat_estatus_incidencia` (
  `id_estatus` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_estatus`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_estatus_registro definition

CREATE TABLE `cat_estatus_registro` (
  `id_estatus` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `codigo` varchar(1) DEFAULT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_estatus`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_imss_cuotas definition

CREATE TABLE `cat_imss_cuotas` (
  `id_imss_cuotas` int unsigned NOT NULL AUTO_INCREMENT,
  `riesgo_trabajo` float unsigned NOT NULL,
  `enf_mat_esp_ct_fija` float unsigned NOT NULL,
  `enf_mat_esp_ct_ad` float unsigned NOT NULL,
  `enf_mat_gastos_med` float unsigned NOT NULL,
  `enf_mat_dinero` float unsigned NOT NULL,
  `inv_vida` float unsigned NOT NULL,
  `ret_cesantia_vejez_retiro` float unsigned NOT NULL,
  `ret_cesantia_vejez_ceav` float unsigned NOT NULL,
  `guarderia` float unsigned NOT NULL,
  `infonavit` float unsigned NOT NULL,
  `cuota` varchar(10) NOT NULL,
  `fecha_cap` datetime NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_imss_cuotas`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_orig_recurso definition

CREATE TABLE `cat_orig_recurso` (
  `cd_orig_recurso` varchar(2) NOT NULL,
  `nb_descripcion` varchar(25) DEFAULT NULL,
  `fh_vigencia_ini` date DEFAULT NULL,
  `fh_vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`cd_orig_recurso`),
  UNIQUE KEY `cd_orig_recurso` (`cd_orig_recurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_pais definition

CREATE TABLE `cat_pais` (
  `cd_pais` varchar(5) NOT NULL,
  `nb_pais` varchar(250) NOT NULL,
  PRIMARY KEY (`cd_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_percepciones definition

CREATE TABLE `cat_percepciones` (
  `id_percepciones` int NOT NULL AUTO_INCREMENT,
  `dias_aguinaldo` int NOT NULL,
  `dias_vacaciones` int NOT NULL,
  `prima_vacacional` float NOT NULL,
  `bono_puntualidad` float NOT NULL,
  `vale_despensa` float NOT NULL,
  `uma` float NOT NULL,
  `fecha_cap` datetime DEFAULT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_percepciones`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_perfil definition

CREATE TABLE `cat_perfil` (
  `id_perfil` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `activo` tinyint DEFAULT '1',
  PRIMARY KEY (`id_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_periodicidad_pago definition

CREATE TABLE `cat_periodicidad_pago` (
  `periodicidad` varchar(3) NOT NULL,
  `descripcion` varchar(30) NOT NULL,
  `vigencia_ini` date NOT NULL,
  `vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`periodicidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_prenda definition

CREATE TABLE `cat_prenda` (
  `id_prenda` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `precio` decimal(5,2) DEFAULT NULL,
  `cantidadMax` int DEFAULT NULL,
  `detalle` varchar(150) DEFAULT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_prenda`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_puesto definition

CREATE TABLE `cat_puesto` (
  `id_puesto` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_puesto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_razon_social definition

CREATE TABLE `cat_razon_social` (
  `id_razon_social` int unsigned NOT NULL AUTO_INCREMENT,
  `razon_socal` varchar(45) NOT NULL,
  `rfc` varchar(45) NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  `fecha_creacion` datetime NOT NULL,
  `fecha_mod` datetime DEFAULT NULL,
  PRIMARY KEY (`id_razon_social`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_regimen_fiscal definition

CREATE TABLE `cat_regimen_fiscal` (
  `cd_regimen` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `nb_regimen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `st_per_fisica` bit(1) NOT NULL,
  `st_per_moral` bit(1) NOT NULL,
  `fh_vigencia_ini` date NOT NULL,
  `fh_vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`cd_regimen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_riesgo_puesto definition

CREATE TABLE `cat_riesgo_puesto` (
  `cd_riesgo` int NOT NULL,
  `nb_riesgo` varchar(150) NOT NULL,
  `fh_vigencia_ini` date NOT NULL,
  `fh_vigencia_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_salario_minimo definition

CREATE TABLE `cat_salario_minimo` (
  `id_salario_minimo` int NOT NULL AUTO_INCREMENT,
  `vigencia` date NOT NULL,
  `zona_g` decimal(8,2) NOT NULL,
  `zona_lfn` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_salario_minimo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_subsidio definition

CREATE TABLE `cat_subsidio` (
  `id_subsidio` int NOT NULL AUTO_INCREMENT,
  `para_ingresos_de` decimal(10,2) NOT NULL,
  `hasta_ingresos_de` decimal(10,2) NOT NULL,
  `cantidad_subsidio` decimal(10,2) NOT NULL,
  `periodo` varchar(45) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_subsidio`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_talla definition

CREATE TABLE `cat_talla` (
  `id_talla` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_talla`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tarifa_isr definition

CREATE TABLE `cat_tarifa_isr` (
  `id_isr` int NOT NULL AUTO_INCREMENT,
  `limite_inferior` decimal(10,2) NOT NULL,
  `limite_superior` decimal(10,2) NOT NULL,
  `cuota_fija` decimal(10,2) NOT NULL,
  `porc_apl_exce_lim_inf` decimal(10,2) NOT NULL,
  `tipo` varchar(45) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_isr`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_bitacora definition

CREATE TABLE `cat_tipo_bitacora` (
  `id_tipo` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_contrato definition

CREATE TABLE `cat_tipo_contrato` (
  `cd_contrato` varchar(5) NOT NULL,
  `nb_contrato` varchar(150) NOT NULL,
  PRIMARY KEY (`cd_contrato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_deduccion definition

CREATE TABLE `cat_tipo_deduccion` (
  `cd_tipo_deduccion` varchar(4) NOT NULL,
  `nb_descripcion` varchar(180) DEFAULT NULL,
  `fh_vigencia_ini` date DEFAULT NULL,
  `fh_vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`cd_tipo_deduccion`),
  UNIQUE KEY `cd_tipo_deduccion` (`cd_tipo_deduccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_horas definition

CREATE TABLE `cat_tipo_horas` (
  `cd_tipo_hora` varchar(4) NOT NULL,
  `nb_descripcion` varchar(10) DEFAULT NULL,
  `fh_vigencia_ini` date DEFAULT NULL,
  `fh_vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`cd_tipo_hora`),
  UNIQUE KEY `cd_tipo_hora` (`cd_tipo_hora`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_incapacidad definition

CREATE TABLE `cat_tipo_incapacidad` (
  `cd_tipo_incapacidad` varchar(4) NOT NULL,
  `nb_descripcion` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`cd_tipo_incapacidad`),
  UNIQUE KEY `cd_tipo_incapacidad` (`cd_tipo_incapacidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_incidencia definition

CREATE TABLE `cat_tipo_incidencia` (
  `id_tipo` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_jornada definition

CREATE TABLE `cat_tipo_jornada` (
  `cd_jornada` varchar(5) NOT NULL,
  `nb_jornada` varchar(150) NOT NULL,
  PRIMARY KEY (`cd_jornada`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_nomina definition

CREATE TABLE `cat_tipo_nomina` (
  `cd_tipo_nomina` varchar(2) NOT NULL,
  `nb_descripcion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`cd_tipo_nomina`),
  UNIQUE KEY `cd_tipo_nomina` (`cd_tipo_nomina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_otro_pago definition

CREATE TABLE `cat_tipo_otro_pago` (
  `cd_tipo_otro_pago` varchar(3) NOT NULL,
  `nb_descripcion` varchar(180) DEFAULT NULL,
  `fh_vigencia_ini` date DEFAULT NULL,
  `fh_vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`cd_tipo_otro_pago`),
  UNIQUE KEY `cd_tipo_otro_pago` (`cd_tipo_otro_pago`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_percepcion definition

CREATE TABLE `cat_tipo_percepcion` (
  `cd_tipo_percepcion` varchar(3) NOT NULL,
  `nb_descripcion` varchar(160) DEFAULT NULL,
  `fh_vigencia_ini` date DEFAULT NULL,
  `fh_vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`cd_tipo_percepcion`),
  UNIQUE KEY `cd_tipo_percepcion` (`cd_tipo_percepcion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_prestamo definition

CREATE TABLE `cat_tipo_prestamo` (
  `tp_prestamo` varchar(5) NOT NULL,
  `descripcion` varchar(30) NOT NULL,
  PRIMARY KEY (`tp_prestamo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_regimen definition

CREATE TABLE `cat_tipo_regimen` (
  `cd_tp_regimen` varchar(5) NOT NULL,
  `nb_tp_regimen` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fh_vigencia_ini` date NOT NULL,
  `fh_vigencia_fin` date DEFAULT NULL,
  PRIMARY KEY (`cd_tp_regimen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_tipo_solicitud definition

CREATE TABLE `cat_tipo_solicitud` (
  `id_tipo_solicitud` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) NOT NULL,
  `activo` tinyint DEFAULT '1',
  PRIMARY KEY (`id_tipo_solicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_empleado_foto definition

CREATE TABLE `det_empleado_foto` (
  `id_empleado_foto` int NOT NULL AUTO_INCREMENT,
  `nb_fotografia` longtext,
  PRIMARY KEY (`id_empleado_foto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_fp_client definition

CREATE TABLE `det_fp_client` (
  `id_fp_client` int NOT NULL AUTO_INCREMENT,
  `nb_password` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_fp_client`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_nomina definition

CREATE TABLE `det_nomina` (
  `id_nomina` int NOT NULL AUTO_INCREMENT,
  `cd_moneda` varchar(5) NOT NULL,
  `fh_emision` datetime NOT NULL,
  `nu_certificado` varchar(50) NOT NULL,
  `fh_timbrado` datetime NOT NULL,
  `cd_uuid` varchar(100) NOT NULL,
  `cd_id_pac` varchar(100) NOT NULL,
  `cd_tp_comp` varchar(2) NOT NULL,
  `cd_exportacion` varchar(3) NOT NULL,
  `cd_metodo_pago` varchar(5) NOT NULL,
  `nb_serie` varchar(10) NOT NULL,
  `nb_folio` varchar(10) NOT NULL,
  `nu_subtotal` decimal(12,2) NOT NULL,
  `nu_descuento` decimal(12,2) NOT NULL,
  `nu_total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_nomina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_dia_no_laboral definition

CREATE TABLE `cat_dia_no_laboral` (
  `id_fecha` int NOT NULL AUTO_INCREMENT,
  `fh_fecha` date NOT NULL,
  `nb_descripcion` varchar(150) NOT NULL,
  `cd_pais` varchar(5) NOT NULL,
  PRIMARY KEY (`id_fecha`),
  KEY `FK_DIA_NO_LABORAL` (`cd_pais`),
  CONSTRAINT `cat_dia_no_laboral_ibfk_1` FOREIGN KEY (`cd_pais`) REFERENCES `cat_pais` (`cd_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_empresa definition

CREATE TABLE `cat_empresa` (
  `id_empresa` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `nb_razon_social` varchar(150) DEFAULT NULL,
  `tp_persona` varchar(1) NOT NULL DEFAULT 'M',
  `nb_regimen_capital` varchar(150) DEFAULT NULL,
  `nb_rfc` varchar(20) DEFAULT NULL,
  `fh_inicio_op` date DEFAULT NULL,
  `fh_ult_cambio` date DEFAULT NULL,
  `st_padron` varchar(1) DEFAULT NULL,
  `cd_regimen` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_empresa`),
  KEY `cat_empresa_cat_regimen_fiscal_FK` (`cd_regimen`),
  CONSTRAINT `cat_empresa_cat_regimen_fiscal_FK` FOREIGN KEY (`cd_regimen`) REFERENCES `cat_regimen_fiscal` (`cd_regimen`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.cat_planta definition

CREATE TABLE `cat_planta` (
  `id_planta` int unsigned NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_razon_social` int unsigned DEFAULT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_planta`),
  KEY `fk_planta_razon_idx` (`id_razon_social`),
  CONSTRAINT `fk_planta_razon` FOREIGN KEY (`id_razon_social`) REFERENCES `cat_razon_social` (`id_razon_social`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_inventario definition

CREATE TABLE `det_inventario` (
  `id_inventario` int unsigned NOT NULL AUTO_INCREMENT,
  `id_prenda` int unsigned DEFAULT NULL,
  `id_articulo` int unsigned DEFAULT NULL,
  `cantidad` int unsigned NOT NULL DEFAULT '0',
  `activo` tinyint NOT NULL DEFAULT '1',
  `visible` tinyint NOT NULL DEFAULT '1',
  `fecha_captura` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_inventario`),
  KEY `fk_inventario_prenda_idx` (`id_prenda`),
  KEY `fk_inventario_articulo_idx` (`id_articulo`),
  CONSTRAINT `fk_inventario_articulo` FOREIGN KEY (`id_articulo`) REFERENCES `cat_articulo` (`id_articulo`),
  CONSTRAINT `fk_inventario_prenda` FOREIGN KEY (`id_prenda`) REFERENCES `cat_prenda` (`id_prenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_nom_concepto definition

CREATE TABLE `det_nom_concepto` (
  `id_nomina` int NOT NULL,
  `id_concepto` int NOT NULL,
  `cd_concepto` varchar(10) NOT NULL,
  `nu_cantidad` int NOT NULL,
  `cd_unidad` varchar(5) NOT NULL,
  `nb_concepto` varchar(150) NOT NULL,
  `cd_obj_imp` varchar(5) NOT NULL,
  `nu_valor_unitario` decimal(12,2) NOT NULL,
  `nu_importe` decimal(12,2) NOT NULL,
  `nu_descuento` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_nomina`,`id_concepto`),
  CONSTRAINT `FK_CONCEPTO_NOMINA` FOREIGN KEY (`id_nomina`) REFERENCES `det_nomina` (`id_nomina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_nom_deduccion definition

CREATE TABLE `det_nom_deduccion` (
  `id_nomina` int NOT NULL,
  `id_deduccion` int NOT NULL,
  `tp_deduccion` varchar(5) NOT NULL,
  `cd_deduccion` varchar(5) NOT NULL,
  `nb_deduccion` varchar(150) NOT NULL,
  `nu_importe` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_nomina`,`id_deduccion`),
  CONSTRAINT `FK_DEDUCCION_NOMINA` FOREIGN KEY (`id_nomina`) REFERENCES `det_nomina` (`id_nomina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_nom_emisor definition

CREATE TABLE `det_nom_emisor` (
  `id_nomina` int NOT NULL,
  `id_emisor` int NOT NULL,
  `nb_nombre` varchar(150) NOT NULL,
  `nb_rfc` varchar(20) NOT NULL,
  `cd_regimen` varchar(5) NOT NULL,
  `nu_cp` varchar(10) NOT NULL,
  `nu_reg_pat` varchar(20) NOT NULL,
  PRIMARY KEY (`id_nomina`,`id_emisor`),
  CONSTRAINT `FK_NOM_EMISOR_NOMINA` FOREIGN KEY (`id_nomina`) REFERENCES `det_nomina` (`id_nomina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_nom_otro_pago definition

CREATE TABLE `det_nom_otro_pago` (
  `id_nomina` int NOT NULL,
  `id_otro_pago` int NOT NULL,
  `tp_otro_pago` varchar(5) NOT NULL,
  `cd_otro_pago` varchar(5) NOT NULL,
  `nb_otro_pago` varchar(150) NOT NULL,
  `nu_importe` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_nomina`,`id_otro_pago`),
  CONSTRAINT `FK_OTRO_PAGO_NOMINA` FOREIGN KEY (`id_nomina`) REFERENCES `det_nomina` (`id_nomina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_nom_percepcion definition

CREATE TABLE `det_nom_percepcion` (
  `id_nomina` int NOT NULL,
  `id_percepcion` int NOT NULL,
  `tp_percepcion` varchar(5) NOT NULL,
  `cd_percepcion` varchar(5) NOT NULL,
  `nb_percepcion` varchar(150) NOT NULL,
  `nu_imp_gravado` decimal(12,2) NOT NULL,
  `nu_imp_exento` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id_nomina`,`id_percepcion`),
  CONSTRAINT `FK_PERCEPCION_NOMINA` FOREIGN KEY (`id_nomina`) REFERENCES `det_nomina` (`id_nomina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_nom_receptor definition

CREATE TABLE `det_nom_receptor` (
  `id_nomina` int NOT NULL,
  `id_receptor` int NOT NULL,
  `nb_nombre` varchar(150) DEFAULT NULL,
  `nb_rfc` varchar(20) NOT NULL,
  `nu_cp` varchar(10) NOT NULL,
  `cd_regimen` varchar(5) NOT NULL,
  `cd_uso_cfdi` varchar(5) NOT NULL,
  `nb_curp` varchar(20) NOT NULL,
  `nu_nss` varchar(20) NOT NULL,
  `fh_ini_rec_lab` date NOT NULL,
  `nb_antiguedad` varchar(20) NOT NULL,
  `cd_tp_contrato` varchar(5) NOT NULL,
  `st_sind` tinyint(1) NOT NULL,
  `cd_tp_jornada` varchar(5) NOT NULL,
  `cd_tp_regimen` varchar(5) NOT NULL,
  `nu_empleado` varchar(5) NOT NULL,
  `cd_depto` varchar(150) NOT NULL,
  `cd_puesto` varchar(150) NOT NULL,
  `cd_riesgo_puesto` varchar(5) NOT NULL,
  `cd_periodicidad` varchar(5) NOT NULL,
  `nu_sd` decimal(12,2) NOT NULL,
  `nu_sdi` decimal(12,2) NOT NULL,
  `cd_ent_fed` varchar(5) NOT NULL,
  PRIMARY KEY (`id_nomina`,`id_receptor`),
  CONSTRAINT `FK_NOM_RECEPTOR_NOMINA` FOREIGN KEY (`id_nomina`) REFERENCES `det_nomina` (`id_nomina`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_prestamo definition

CREATE TABLE `det_prestamo` (
  `id_prestamo` int NOT NULL AUTO_INCREMENT,
  `id_empleado` int NOT NULL,
  `fh_inicio` date NOT NULL,
  `fh_fin` date NOT NULL,
  `nu_acumulado` decimal(10,2) NOT NULL,
  `nu_importe` decimal(10,2) NOT NULL,
  `nu_total` decimal(10,2) NOT NULL,
  `periodicidad` varchar(3) NOT NULL,
  `tp_prestamo` varchar(5) NOT NULL,
  PRIMARY KEY (`id_prestamo`),
  KEY `fk_prestamo_cat_periodicidad` (`periodicidad`),
  KEY `fk_prestamo_cat_tipo_prestamo` (`tp_prestamo`),
  CONSTRAINT `fk_prestamo_cat_periodicidad` FOREIGN KEY (`periodicidad`) REFERENCES `cat_periodicidad_pago` (`periodicidad`),
  CONSTRAINT `fk_prestamo_cat_tipo_prestamo` FOREIGN KEY (`tp_prestamo`) REFERENCES `cat_tipo_prestamo` (`tp_prestamo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.inf_empleado_empresa definition

CREATE TABLE `inf_empleado_empresa` (
  `id_empleado_empresa` int NOT NULL AUTO_INCREMENT,
  `id_perfil` int unsigned DEFAULT NULL,
  `id_empresa` int unsigned DEFAULT NULL,
  `id_planta` int unsigned DEFAULT NULL,
  `id_area` int unsigned DEFAULT NULL,
  `id_puesto` int unsigned DEFAULT NULL,
  `cd_contrato` varchar(5) DEFAULT NULL,
  `cd_jornada` varchar(5) DEFAULT NULL,
  `cd_tp_regimen` varchar(5) DEFAULT NULL,
  `fh_ingreso` date NOT NULL,
  `nu_nss` varchar(45) DEFAULT NULL,
  `nb_rfc` varchar(15) DEFAULT NULL,
  `nu_salario_diario` decimal(10,2) DEFAULT NULL,
  `tm_entrada` time DEFAULT NULL,
  `nu_tolerancia` int DEFAULT NULL,
  PRIMARY KEY (`id_empleado_empresa`),
  KEY `FK_det_empleado_empresa__cat_perfil` (`id_perfil`),
  KEY `FK_det_empleado_empresa__cat_empresa` (`id_empresa`),
  KEY `FK_det_empleado_empresa__cat_planta` (`id_planta`),
  KEY `FK_det_empleado_empresa__cat_area` (`id_area`),
  KEY `FK_det_empleado_empresa__cat_puesto` (`id_puesto`),
  KEY `FK_det_empleado_empresa__cat_tipo_contrato` (`cd_contrato`),
  KEY `FK_det_empleado_empresa__cat_tipo_jornada` (`cd_jornada`),
  KEY `FK_det_empleado_empresa__cat_tipo_regimen` (`cd_tp_regimen`),
  CONSTRAINT `FK_det_empleado_empresa__cat_area` FOREIGN KEY (`id_area`) REFERENCES `cat_area` (`id_area`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_det_empleado_empresa__cat_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `cat_empresa` (`id_empresa`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_det_empleado_empresa__cat_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `cat_perfil` (`id_perfil`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_det_empleado_empresa__cat_planta` FOREIGN KEY (`id_planta`) REFERENCES `cat_planta` (`id_planta`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_det_empleado_empresa__cat_puesto` FOREIGN KEY (`id_puesto`) REFERENCES `cat_puesto` (`id_puesto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_det_empleado_empresa__cat_tipo_contrato` FOREIGN KEY (`cd_contrato`) REFERENCES `cat_tipo_contrato` (`cd_contrato`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_det_empleado_empresa__cat_tipo_jornada` FOREIGN KEY (`cd_jornada`) REFERENCES `cat_tipo_jornada` (`cd_jornada`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_det_empleado_empresa__cat_tipo_regimen` FOREIGN KEY (`cd_tp_regimen`) REFERENCES `cat_tipo_regimen` (`cd_tp_regimen`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_empleado definition

CREATE TABLE `det_empleado` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `num_empleado` varchar(10) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `primer_ap` varchar(45) NOT NULL,
  `segundo_ap` varchar(45) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `fecha_registro` datetime NOT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `id_perfil` int unsigned NOT NULL,
  `id_puesto` int unsigned NOT NULL,
  `curp` varchar(18) DEFAULT NULL,
  `rfc` varchar(45) NOT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `fecha_ingreso` datetime NOT NULL,
  `nss` varchar(45) DEFAULT NULL,
  `id_empresa` int unsigned NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  `id_planta` int unsigned DEFAULT NULL,
  `id_area` int unsigned DEFAULT NULL,
  `fotografia` longtext,
  `sueldo_diario` decimal(10,2) NOT NULL,
  `id_empleado_empresa` int DEFAULT NULL,
  `id_empleado_foto` int DEFAULT NULL,
  PRIMARY KEY (`id_empleado`),
  KEY `fk_empleado_perfil_idx` (`id_perfil`),
  KEY `fk_empleado_puesto_idx` (`id_puesto`),
  KEY `fk_empleado_empresa_idx` (`id_empresa`),
  KEY `fk_empleado_planta_idx` (`id_planta`),
  KEY `fk_empleado_area_idx` (`id_area`),
  KEY `FK_det_empleado__det_empleado_empresa` (`id_empleado_empresa`),
  KEY `fk_det_empleado__det_empleado_foto` (`id_empleado_foto`),
  CONSTRAINT `FK_det_empleado__det_empleado_empresa` FOREIGN KEY (`id_empleado_empresa`) REFERENCES `inf_empleado_empresa` (`id_empleado_empresa`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_det_empleado__det_empleado_foto` FOREIGN KEY (`id_empleado_foto`) REFERENCES `det_empleado_foto` (`id_empleado_foto`),
  CONSTRAINT `fk_empleado_area` FOREIGN KEY (`id_area`) REFERENCES `cat_area` (`id_area`),
  CONSTRAINT `fk_empleado_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `cat_empresa` (`id_empresa`),
  CONSTRAINT `fk_empleado_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `cat_perfil` (`id_perfil`),
  CONSTRAINT `fk_empleado_planta` FOREIGN KEY (`id_planta`) REFERENCES `cat_planta` (`id_planta`),
  CONSTRAINT `fk_empleado_puesto` FOREIGN KEY (`id_puesto`) REFERENCES `cat_puesto` (`id_puesto`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_registro definition

CREATE TABLE `det_registro` (
  `id_registro` int NOT NULL AUTO_INCREMENT,
  `id_empleado` int DEFAULT NULL,
  `fecha_entrada` datetime DEFAULT NULL,
  `fecha_salida` datetime DEFAULT NULL,
  `id_estatus` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_registro`),
  KEY `id_registro_empleado_idx` (`id_empleado`),
  KEY `fk_registro_estatus_idx` (`id_estatus`),
  CONSTRAINT `fk_registro_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_registro_estatus` FOREIGN KEY (`id_estatus`) REFERENCES `cat_estatus_registro` (`id_estatus`)
) ENGINE=InnoDB AUTO_INCREMENT=589 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_solicitud_articulo definition

CREATE TABLE `det_solicitud_articulo` (
  `id_solicitud` int unsigned NOT NULL AUTO_INCREMENT,
  `id_articulo` int unsigned NOT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `aprobada` tinyint DEFAULT NULL,
  `fecha_cap` datetime NOT NULL,
  `fecha_mod` datetime DEFAULT NULL,
  `id_empleado_sol` int DEFAULT NULL,
  `id_empleado_rev` int DEFAULT NULL,
  `descripcion_rechazo` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  KEY `fk_sol_material_idx` (`id_articulo`),
  KEY `fk_emp_sol_articulo_idx` (`id_empleado_sol`),
  KEY `fk_emp_revl_articulo_idx` (`id_empleado_rev`),
  CONSTRAINT `fk_emp_rev_articulo` FOREIGN KEY (`id_empleado_rev`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_emp_sol_articulo` FOREIGN KEY (`id_empleado_sol`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_sol_articulo` FOREIGN KEY (`id_articulo`) REFERENCES `cat_articulo` (`id_articulo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_solicitud_permiso definition

CREATE TABLE `det_solicitud_permiso` (
  `id_solicitud` int unsigned NOT NULL AUTO_INCREMENT,
  `fecha_cap` datetime NOT NULL,
  `fecha_mod` datetime DEFAULT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `aprobada` tinyint DEFAULT NULL,
  `id_empleado_sol` int DEFAULT NULL,
  `id_tipo_solicitud` int unsigned NOT NULL,
  `id_empleado_rev` int DEFAULT NULL,
  `descripcion_rechazo` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  KEY `fk_emp_rev_vacaciones_idx` (`id_empleado_sol`),
  KEY `fk_emp_sol_vacaciones_idx` (`id_empleado_rev`),
  KEY `fk_sol_tipo_sol_idx` (`id_tipo_solicitud`),
  CONSTRAINT `fk_emp_rev_vacaciones` FOREIGN KEY (`id_empleado_sol`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_emp_sol_vacaciones` FOREIGN KEY (`id_empleado_rev`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_sol_tipo_sol` FOREIGN KEY (`id_tipo_solicitud`) REFERENCES `cat_tipo_solicitud` (`id_tipo_solicitud`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_solicitud_prenda definition

CREATE TABLE `det_solicitud_prenda` (
  `id_solicitud` int unsigned NOT NULL AUTO_INCREMENT,
  `id_prenda` int unsigned NOT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `aprobada` tinyint DEFAULT NULL,
  `fecha_cap` datetime NOT NULL,
  `fecha_mod` datetime DEFAULT NULL,
  `id_empleado_sol` int DEFAULT NULL,
  `id_talla` int unsigned NOT NULL,
  `id_empleado_rev` int DEFAULT NULL,
  `descripcion_rechazo` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  KEY `fk_sol_prenda_idx` (`id_prenda`),
  KEY `fk_sol_emp_idx` (`id_empleado_sol`),
  KEY `fk_sol_talla_idx` (`id_talla`),
  KEY `fk_emp_revisor_idx` (`id_empleado_rev`),
  CONSTRAINT `fk_emp_rev_prenda` FOREIGN KEY (`id_empleado_rev`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_emp_sol_prenda` FOREIGN KEY (`id_empleado_sol`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_sol_prenda` FOREIGN KEY (`id_prenda`) REFERENCES `cat_prenda` (`id_prenda`),
  CONSTRAINT `fk_sol_talla` FOREIGN KEY (`id_talla`) REFERENCES `cat_talla` (`id_talla`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_token_empleado definition

CREATE TABLE `det_token_empleado` (
  `id_token` int NOT NULL AUTO_INCREMENT,
  `id_empleado` int DEFAULT NULL,
  `nb_token` varchar(50) DEFAULT NULL,
  `caducidad` datetime DEFAULT NULL,
  `valido` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id_token`),
  KEY `fk_id_empleado` (`id_empleado`),
  CONSTRAINT `fk_id_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `det_empleado` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=1151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.bitacora_cat_perfil definition

CREATE TABLE `bitacora_cat_perfil` (
  `id_bitacora` int unsigned NOT NULL AUTO_INCREMENT,
  `fecha_captura` datetime DEFAULT NULL,
  `modificacion` tinyint DEFAULT NULL,
  `id_perfil` int unsigned DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  PRIMARY KEY (`id_bitacora`),
  KEY `fk_bitacora_perfil_idx` (`id_perfil`),
  KEY `fk_bitacora_empleado` (`id_empleado`),
  CONSTRAINT `fk_bitacora_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_bitacora_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `cat_perfil` (`id_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.bitacora_inventario definition

CREATE TABLE `bitacora_inventario` (
  `id_bitacora` int unsigned NOT NULL AUTO_INCREMENT,
  `id_inventario` int unsigned NOT NULL,
  `id_empleado` int DEFAULT NULL,
  `fecha_captura` datetime NOT NULL,
  `id_tipo` int unsigned NOT NULL,
  PRIMARY KEY (`id_bitacora`),
  KEY `fk_bitacora_inventario_inventario_idx` (`id_inventario`),
  KEY `fk_bitacora_inventario_empleado_idx` (`id_empleado`),
  KEY `fk_bitacora_inventario_tipo_idx` (`id_tipo`),
  CONSTRAINT `fk_bitacora_inventario_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_bitacora_inventario_inventario` FOREIGN KEY (`id_inventario`) REFERENCES `det_inventario` (`id_inventario`),
  CONSTRAINT `fk_bitacora_inventario_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `cat_tipo_bitacora` (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_biometrico definition

CREATE TABLE `det_biometrico` (
  `id_biometrico` int unsigned NOT NULL AUTO_INCREMENT,
  `id_empleado` int DEFAULT NULL,
  `fecha_captura` datetime NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '1',
  `huella` text NOT NULL,
  `huella2` text NOT NULL,
  PRIMARY KEY (`id_biometrico`),
  KEY `fk_biometrico_empleado_idx` (`id_empleado`),
  CONSTRAINT `fk_biometrico_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `det_empleado` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- sgp.det_incidencia definition

CREATE TABLE `det_incidencia` (
  `id_incidencia` int unsigned NOT NULL AUTO_INCREMENT,
  `id_tipo` int unsigned DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  `id_estatus` int unsigned DEFAULT NULL,
  `visible` tinyint DEFAULT NULL,
  `id_sol_articulo` int unsigned DEFAULT NULL,
  `id_sol_prenda` int unsigned DEFAULT NULL,
  `id_sol_permiso` int unsigned DEFAULT NULL,
  `fecha_cap` datetime NOT NULL,
  `fecha_mod` datetime DEFAULT NULL,
  `id_empleado_rev` int DEFAULT NULL,
  PRIMARY KEY (`id_incidencia`),
  KEY `fk_incidencia_sol_prenda_idx` (`id_sol_prenda`),
  KEY `fk_incidencia_sol_articulo_idx` (`id_sol_articulo`),
  KEY `fk_incidencia_estatus_idx` (`id_estatus`),
  KEY `fk_incidencia_tipo_idx` (`id_tipo`),
  KEY `fk_incidencia_sol_permiso_idx` (`id_sol_permiso`),
  KEY `fk_incidencia_empleado_idx` (`id_empleado`),
  KEY `fk_incidencia_empleado_rev_idx` (`id_empleado_rev`),
  CONSTRAINT `fk_incidencia_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_incidencia_empleado_rev` FOREIGN KEY (`id_empleado_rev`) REFERENCES `det_empleado` (`id_empleado`),
  CONSTRAINT `fk_incidencia_estatus` FOREIGN KEY (`id_estatus`) REFERENCES `cat_estatus_incidencia` (`id_estatus`),
  CONSTRAINT `fk_incidencia_sol_articulo` FOREIGN KEY (`id_sol_articulo`) REFERENCES `det_solicitud_articulo` (`id_solicitud`),
  CONSTRAINT `fk_incidencia_sol_permiso` FOREIGN KEY (`id_sol_permiso`) REFERENCES `det_solicitud_permiso` (`id_solicitud`),
  CONSTRAINT `fk_incidencia_sol_prenda` FOREIGN KEY (`id_sol_prenda`) REFERENCES `det_solicitud_prenda` (`id_solicitud`),
  CONSTRAINT `fk_incidencia_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `cat_tipo_incidencia` (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
