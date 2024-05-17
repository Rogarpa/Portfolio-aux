-- Fotos a migrar con update
(SELECT  FOTOGRAFIAS_EMPLEADOS.id_empleado_foto, FOTOGRAFIAS_EMPLEADOS.fotografia
	FROM 
		(SELECT id_empleado_foto, fotografia FROM det_empleado) AS FOTOGRAFIAS_EMPLEADOS
		INNER JOIN det_empleado_foto ON FOTOGRAFIAS_EMPLEADOS.id_empleado_foto = det_empleado_foto.id_empleado_foto);
-- Update Fotos
-- UPDATE det_empleado_foto 
-- 	FROM 
-- 		(SELECT  FOTOGRAFIAS_EMPLEADOS.id_empleado_foto, FOTOGRAFIAS_EMPLEADOS.fotografia
-- 			FROM 
-- 			(SELECT id_empleado_foto, fotografia FROM det_empleado) AS FOTOGRAFIAS_EMPLEADOS
-- 			INNER JOIN det_empleado_foto ON FOTOGRAFIAS_EMPLEADOS.id_empleado_foto = det_empleado_foto.id_empleado_foto);
WITH
EMPLEADOS_CON_ID_EMPLEADO_FOTO AS 
(
	SELECT  FOTOGRAFIAS_EMPLEADOS.id_empleado_foto, FOTOGRAFIAS_EMPLEADOS.fotografia
	FROM 
		(SELECT id_empleado_foto, fotografia FROM det_empleado) AS FOTOGRAFIAS_EMPLEADOS
	INNER JOIN det_empleado_foto ON FOTOGRAFIAS_EMPLEADOS.id_empleado_foto = det_empleado_foto.id_empleado_foto
)
UPDATE det_empleado_foto 
JOIN EMPLEADOS_CON_ID_EMPLEADO_FOTO ON det_empleado_foto.id_empleado_foto = EMPLEADOS_CON_ID_EMPLEADO_FOTO.id_empleado_foto
SET det_empleado_foto.nb_fotografia = EMPLEADOS_CON_ID_EMPLEADO_FOTO.fotografia;

-- -- Test update multiple 
-- UPDATE det_empleado_foto 
-- JOIN (SELECT  FOTOGRAFIAS_EMPLEADOS.id_empleado_foto, FOTOGRAFIAS_EMPLEADOS.fotografia
-- 			FROM 
-- 			(SELECT id_empleado_foto, fotografia FROM det_empleado) AS FOTOGRAFIAS_EMPLEADOS
-- 			INNER JOIN det_empleado_foto ON FOTOGRAFIAS_EMPLEADOS.id_empleado_foto = det_empleado_foto.id_empleado_foto) AS norepeated
-- ON id_empleado_foto 
-- SET norepeated;

-- Clonacion de fotos existentes en det_empleado_foto
INSERT INTO det_empleado_foto (
	SELECT det_empleado.id_empleado_foto, det_empleado.fotografia
	FROM det_empleado
	WHERE (id_empleado_foto IS NULL) OR (id_empleado_foto NOT IN (SELECT id_empleado_foto  FROM det_empleado_foto def))
);

-- Update relacion llaves det_empleado con det_empleado_foto
WITH LLAVES_FOTOS_INSERTADAS_DET_EMPLEADO_FOTO AS (SELECT  * FROM det_empleado_foto),
RELACION_LLAVES_DET_EMPLEADO_DET_EMPLEADO_FOTO AS
(
	SELECT det_empleado.id_empleado, LLAVES_FOTOS_INSERTADAS_DET_EMPLEADO_FOTO.id_empleado_foto FROM LLAVES_FOTOS_INSERTADAS_DET_EMPLEADO_FOTO
	JOIN det_empleado
	ON det_empleado.fotografia = LLAVES_FOTOS_INSERTADAS_DET_EMPLEADO_FOTO.nb_fotografia
)
SELECT * FROM RELACION_LLAVES_DET_EMPLEADO_DET_EMPLEADO_FOTO;

WITH LLAVES_FOTOS_INSERTADAS_DET_EMPLEADO_FOTO AS (SELECT  * FROM det_empleado_foto),
RELACION_LLAVES_DET_EMPLEADO_DET_EMPLEADO_FOTO AS
(
	SELECT det_empleado.id_empleado, LLAVES_FOTOS_INSERTADAS_DET_EMPLEADO_FOTO.id_empleado_foto FROM LLAVES_FOTOS_INSERTADAS_DET_EMPLEADO_FOTO
	JOIN det_empleado
	ON det_empleado.fotografia = LLAVES_FOTOS_INSERTADAS_DET_EMPLEADO_FOTO.nb_fotografia
)
UPDATE det_empleado
JOIN RELACION_LLAVES_DET_EMPLEADO_DET_EMPLEADO_FOTO ON det_empleado.id_empleado = RELACION_LLAVES_DET_EMPLEADO_DET_EMPLEADO_FOTO.id_empleado
SET det_empleado.id_empleado_foto = RELACION_LLAVES_DET_EMPLEADO_DET_EMPLEADO_FOTO.id_empleado_foto;

-- Insertion tests
ALTER TABLE det_empleado_foto AUTO_INCREMENT=1;
DELETE FROM det_empleado_foto WHERE id_empleado_foto <> 1;
UPDATE det_empleado SET det_empleado.id_empleado_foto = NULL WHERE id_empleado <> 1;
