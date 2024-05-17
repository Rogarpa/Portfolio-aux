-- Tomar id_empleado y foto 
(SELECT id_empleado as id_empleado_foto, fotografia FROM det_empleado);


-- Fotos a migrar con update
(SELECT  fotografias_empleados.id_empleado_foto, fotografias_empleados.fotografia
	FROM 
		(SELECT id_empleado_foto, fotografia FROM det_empleado) AS fotografias_empleados
		INNER JOIN det_empleado_foto ON fotografias_empleados.id_empleado_foto = det_empleado_foto.id_empleado_foto);

UPDATE det_empleado_foto SET (SELECT  fotografias_empleados.id_empleado_foto, fotografias_empleados.fotografia
	FROM 
		(SELECT id_empleado_foto, fotografia FROM det_empleado) AS fotografias_empleados
		INNER JOIN det_empleado_foto ON fotografias_empleados.id_empleado_foto = det_empleado_foto.id_empleado_foto);
	
	-- Fotos a migrar con insert
SELECT *
FROM det_empleado
WHERE (id_empleado_foto IS NULL) OR (id_empleado_foto NOT IN (SELECT id_empleado_foto  FROM det_empleado_foto def));


	
	

-- Insertion tests
DELETE FROM det_empleado_foto WHERE id_empleado_foto = 2;
INSERT INTO det_empleado_foto (id_empleado_foto, nb_fotografia) VALUES (3, "asdf");
INSERT INTO det_empleado_foto (id_empleado_foto, nb_fotografia) VALUES (4, "asdf");

START TRANSACTION;
INSERT INTO det_empleado_foto (id_empleado_foto, nb_fotografia) VALUES (2, "asdf"); 
SELECT LAST_INSERT_ID();
COMMIT;
 