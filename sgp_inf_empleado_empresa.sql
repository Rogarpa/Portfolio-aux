ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_cp` (`id_cp`),

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_det_empleado__category` FOREIGN KEY (`id_tabla`) REFERENCES `category` (`id_tabla`),;

ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_uso_cfdi` (`id_uso_cfdi`),

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_det_empleado__category` FOREIGN KEY (`id_tabla`) REFERENCES `category` (`id_tabla`),;


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_sind` (`id_sind`),

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_det_empleado__category` FOREIGN KEY (`id_tabla`) REFERENCES `category` (`id_tabla`),;


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_depto` (`id_depto`),

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_det_empleado__category` FOREIGN KEY (`id_tabla`) REFERENCES `category` (`id_tabla`),;


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_riesgo_puesto` (`id_riesgo_puesto`),

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_det_empleado__category` FOREIGN KEY (`id_tabla`) REFERENCES `category` (`id_tabla`),;


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_periodicidad` (`id_periodicidad`),

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_det_empleado__category` FOREIGN KEY (`id_tabla`) REFERENCES `category` (`id_tabla`),;


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_salario_diario` (`id_salario_diario`),

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_det_empleado__category` FOREIGN KEY (`id_tabla`) REFERENCES `category` (`id_tabla`),;


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_ent_fed` (`id_ent_fed`),

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_det_empleado__category` FOREIGN KEY (`id_tabla`) REFERENCES `category` (`id_tabla`),;

-- Columnas faltantes de det_empleado==inf_empleado_empresa
`nu_cp` varchar(10) NOT NULL,
`cd_uso_cfdi` varchar(5) NOT NULL,
-- Columnas faltantes de inf_empleado_empresa
`st_sind` tinyint(1) NOT NULL,
`cd_depto` varchar(150) NOT NULL,
`cd_riesgo_puesto` varchar(5) NOT NULL,
`cd_periodicidad` varchar(5) NOT NULL,
-- salario base cotizacion?
`nu_salario_diario` decimal(10,2) DEFAULT NULL,
`cd_ent_fed` varchar(5) NOT NULL,
