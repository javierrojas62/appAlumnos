-- =====================================================================
-- Datos de prueba para el Práctico 4 (solo AGREGA datos, no borra nada).
-- Ejecutar después de 02_agregar_docente.sql
-- =====================================================================
USE bdalumnos;

-- Materias de prueba (solo se agregan si no existen)
INSERT INTO materia (nombre) SELECT 'Programación II'     FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM materia WHERE nombre = 'Programación II');
INSERT INTO materia (nombre) SELECT 'Redes'               FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM materia WHERE nombre = 'Redes');
INSERT INTO materia (nombre) SELECT 'Sistemas Operativos' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM materia WHERE nombre = 'Sistemas Operativos');

-- Docentes
INSERT INTO docente (nombre, cargo) VALUES
  ('María López',    'TITULAR'),
  ('Carlos Sánchez', 'ADJUNTO'),
  ('Laura Torres',   'JTP');

-- Equipos de cátedra:
--   María dicta 3 materias, Laura 4, Carlos 1
INSERT IGNORE INTO docente_has_materia (docente_iddocente, materia_idmateria)
SELECT d.iddocente, m.idmateria FROM docente d, materia m
WHERE d.nombre = 'María López'
  AND m.nombre IN ('Programación II', 'Redes', 'Sistemas Operativos');

INSERT IGNORE INTO docente_has_materia (docente_iddocente, materia_idmateria)
SELECT d.iddocente, m.idmateria FROM docente d, materia m
WHERE d.nombre = 'Laura Torres';

INSERT IGNORE INTO docente_has_materia (docente_iddocente, materia_idmateria)
SELECT d.iddocente, m.idmateria FROM docente d, materia m
WHERE d.nombre = 'Carlos Sánchez' AND m.nombre = 'Redes';

-- Exámenes del turno de julio 2026 para los dos primeros alumnos
INSERT IGNORE INTO examen (alumno_idalumno, materia_idmateria, fecha, nota)
SELECT a.idalumno, m.idmateria, '2026-07-14 09:00:00', 8
FROM alumno a, materia m
WHERE m.nombre = 'Redes'
  AND a.idalumno IN (SELECT idalumno FROM (SELECT idalumno FROM alumno ORDER BY idalumno LIMIT 2) t);

INSERT IGNORE INTO examen (alumno_idalumno, materia_idmateria, fecha, nota)
SELECT a.idalumno, m.idmateria, '2026-07-21 09:00:00', 6
FROM alumno a, materia m
WHERE m.nombre = 'Programación II'
  AND a.idalumno = (SELECT MIN(idalumno) FROM alumno);

-- Un alumno sin exámenes en el año en curso (para la consulta 6.2)
INSERT INTO alumno (nombre, registro, carrera_idcarrera)
SELECT 'Lucas Gómez', 'E09012', MIN(idcarrera) FROM carrera
HAVING NOT EXISTS (SELECT 1 FROM alumno WHERE registro = 'E09012');
