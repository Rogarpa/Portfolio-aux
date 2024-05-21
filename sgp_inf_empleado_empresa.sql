ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_cp` (`id_cp`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_empleado_cp` FOREIGN KEY (`id_cp`) REFERENCES `cat_cp` (`id_cp`);

ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_uso_cfdi` (`id_uso_cfdi`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_empleado_uso_cfdi` FOREIGN KEY (`id_uso_cfdi`) REFERENCES `cat_uso_cfdi` (`id_uso_cfdi`);


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_sind` (`id_sind`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_empleado_sind` FOREIGN KEY (`id_sind`) REFERENCES `cat_sind` (`id_sind`);


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_depto` (`id_depto`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_empleado_depto` FOREIGN KEY (`id_depto`) REFERENCES `cat_depto` (`id_depto`);


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_riesgo_puesto` (`id_riesgo_puesto`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_empleado_riesgo_puesto` FOREIGN KEY (`id_riesgo_puesto`) REFERENCES `cat_riesgo_puesto` (`id_riesgo_puesto`);


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_periodicidad` (`id_periodicidad`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_empleado_periodicidad` FOREIGN KEY (`id_periodicidad`) REFERENCES `cat_periodicidad` (`id_periodicidad`);


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_salario_diario` (`id_salario_diario`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_empleado_salario_diario` FOREIGN KEY (`id_salario_diario`) REFERENCES `cat_salario_diario` (`id_salario_diario`);


ALTER TABLE inf_empleado_empresa
KEY `fk_empleado_cat_ent_fed` (`id_ent_fed`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `fk_empleado_ent_fed` FOREIGN KEY (`id_ent_fed`) REFERENCES `cat_ent_fed` (`id_ent_fed`);

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
