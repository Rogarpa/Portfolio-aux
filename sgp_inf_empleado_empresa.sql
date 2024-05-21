ALTER TABLE `inf_empleado_empresa`
ADD COLUMN;


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