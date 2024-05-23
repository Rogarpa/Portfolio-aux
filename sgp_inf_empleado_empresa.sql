ALTER TABLE inf_empleado_empresa
ADD COLUMN `nu_cp` varchar(10);

ALTER TABLE inf_empleado_empresa
ADD COLUMN `st_sind` tinyint(1);

ALTER TABLE inf_empleado_empresa
ADD COLUMN `nu_salario_diario` decimal(10,2);

CREATE TABLE `cat_uso_cfdi` (
  `cd_uso_cfdi` varchar(5) NOT NULL,
  `nb_uso_cfdi` varchar(150) NOT NULL,
  PRIMARY KEY (`cd_uso_cfdi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cat_departamento` (
  `cd_depto` varchar(150) NOT NULL,
  `nb_depto` varchar(150) NOT NULL,
  PRIMARY KEY (`cd_depto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- CREATE TABLE `cat_riesgo_puesto` (
--   `cd_riesgo_puesto` varchar(5) NOT NULL,
--   `nb_riesgo_puesto` varchar(150) NOT NULL,
--   PRIMARY KEY (`cd_riesgo_puesto`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cat_periodicidad` (
  `cd_periodicidad` varchar(5) NOT NULL,
  `nb_periodicidad` varchar(150) NOT NULL,
  PRIMARY KEY (`cd_periodicidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `cat_ent_federal` (
  `cd_ent_fed` varchar(5) NOT NULL,
  `nb_ent_fed` varchar(150) NOT NULL,
  PRIMARY KEY (`cd_ent_fed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



ALTER TABLE inf_empleado_empresa
ADD COLUMN `cd_uso_cfdi` varchar(5);

ALTER TABLE inf_empleado_empresa
ADD KEY `FK_det_empleado_empresa__cat_uso_cfdi` (`cd_uso_cfdi`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `FK_det_empleado_empresa__cat_uso_cfdi` FOREIGN KEY (`cd_uso_cfdi`) REFERENCES `cat_uso_cfdi` (`cd_uso_cfdi`) ON DELETE RESTRICT ON UPDATE RESTRICT;



ALTER TABLE inf_empleado_empresa
ADD COLUMN `cd_depto` varchar(150);

ALTER TABLE inf_empleado_empresa
ADD KEY `FK_det_empleado_empresa__cat_departamento` (`cd_depto`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `FK_det_empleado_empresa__cat_departamento` FOREIGN KEY (`cd_depto`) REFERENCES `cat_departamento` (`cd_depto`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- Preexisiting table cat_riesgo_puesto 
ALTER TABLE cat_riesgo_puesto
ADD CONSTRAINT `PK_det_empleado_empresa__cat_riesgo_puesto` PRIMARY KEY (`cd_riesgo`);

ALTER TABLE inf_empleado_empresa
ADD COLUMN `cd_riesgo` int;

ALTER TABLE inf_empleado_empresa
ADD KEY `FK_det_empleado_empresa__cat_riesgo_puesto` (`cd_riesgo`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `FK_det_empleado_empresa__cat_riesgo_puesto` FOREIGN KEY (`cd_riesgo`) REFERENCES `cat_riesgo_puesto` (`cd_riesgo`) ON DELETE RESTRICT ON UPDATE RESTRICT;


ALTER TABLE inf_empleado_empresa
ADD COLUMN `cd_periodicidad` varchar(5);

ALTER TABLE inf_empleado_empresa
ADD KEY `FK_det_empleado_empresa__cat_periodicidad` (`cd_periodicidad`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `FK_det_empleado_empresa__cat_periodicidad` FOREIGN KEY (`cd_periodicidad`) REFERENCES `cat_periodicidad` (`cd_periodicidad`) ON DELETE RESTRICT ON UPDATE RESTRICT;



ALTER TABLE inf_empleado_empresa
ADD COLUMN `cd_ent_fed` varchar(5);

ALTER TABLE inf_empleado_empresa
ADD KEY `FK_det_empleado_empresa__cat_ent_federal` (`cd_ent_fed`);

ALTER TABLE inf_empleado_empresa
ADD CONSTRAINT `FK_det_empleado_empresa__cat_ent_federal` FOREIGN KEY (`cd_ent_fed`) REFERENCES `cat_ent_federal` (`cd_ent_fed`) ON DELETE RESTRICT ON UPDATE RESTRICT;
