-- =====================================================================
-- Sistema Alumnos - bdalumnos
-- Script completo: crea el esquema desde cero y carga datos de prueba.
-- ATENCION: borra el esquema bdalumnos si existe.
-- Para agregar Docente a una base existente SIN perder datos,
-- usar 02_agregar_docente.sql
-- =====================================================================
DROP SCHEMA IF EXISTS bdalumnos;
CREATE SCHEMA bdalumnos DEFAULT CHARACTER SET utf8mb4;
USE bdalumnos;

CREATE TABLE facultad (
  idfacultad INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre     VARCHAR(45) NOT NULL,
  PRIMARY KEY (idfacultad)
) ENGINE = InnoDB;

CREATE TABLE carrera (
  idcarrera           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre              VARCHAR(45) NOT NULL,
  facultad_idfacultad INT UNSIGNED NOT NULL,
  PRIMARY KEY (idcarrera),
  INDEX fk_carrera_facultad_idx (facultad_idfacultad),
  CONSTRAINT fk_carrera_facultad
    FOREIGN KEY (facultad_idfacultad) REFERENCES facultad (idfacultad)
) ENGINE = InnoDB;

CREATE TABLE alumno (
  idalumno          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre            VARCHAR(45) NOT NULL,
  registro          VARCHAR(10) NOT NULL,
  carrera_idcarrera INT UNSIGNED NOT NULL,
  PRIMARY KEY (idalumno),
  INDEX fk_alumno_carrera_idx (carrera_idcarrera),
  CONSTRAINT fk_alumno_carrera
    FOREIGN KEY (carrera_idcarrera) REFERENCES carrera (idcarrera)
) ENGINE = InnoDB;

CREATE TABLE materia (
  idmateria INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre    VARCHAR(45) NOT NULL,
  PRIMARY KEY (idmateria)
) ENGINE = InnoDB;

-- Relación N:M alumno-materia (materias rendidas).
-- La fecha forma parte de la PK porque un alumno puede rendir
-- la misma materia más de una vez.
CREATE TABLE examen (
  alumno_idalumno   INT UNSIGNED NOT NULL,
  materia_idmateria INT UNSIGNED NOT NULL,
  fecha             TIMESTAMP(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  nota              INT NULL,
  PRIMARY KEY (alumno_idalumno, materia_idmateria, fecha),
  INDEX fk_examen_materia_idx (materia_idmateria),
  CONSTRAINT fk_examen_alumno
    FOREIGN KEY (alumno_idalumno) REFERENCES alumno (idalumno),
  CONSTRAINT fk_examen_materia
    FOREIGN KEY (materia_idmateria) REFERENCES materia (idmateria)
) ENGINE = InnoDB;

-- Práctico 4 - Ejercicio 4: entidad Docente
CREATE TABLE docente (
  iddocente INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre    VARCHAR(45) NOT NULL,
  cargo     ENUM('TITULAR', 'ADJUNTO', 'JTP') NOT NULL,
  PRIMARY KEY (iddocente)
) ENGINE = InnoDB;

-- Relación N:M docente-materia (equipo de cátedra)
CREATE TABLE docente_has_materia (
  docente_iddocente INT UNSIGNED NOT NULL,
  materia_idmateria INT UNSIGNED NOT NULL,
  PRIMARY KEY (docente_iddocente, materia_idmateria),
  INDEX fk_dhm_materia_idx (materia_idmateria),
  CONSTRAINT fk_dhm_docente
    FOREIGN KEY (docente_iddocente) REFERENCES docente (iddocente),
  CONSTRAINT fk_dhm_materia
    FOREIGN KEY (materia_idmateria) REFERENCES materia (idmateria)
) ENGINE = InnoDB;

-- ------------------------- Datos de prueba ---------------------------
INSERT INTO facultad (nombre) VALUES
  ('FCEFN'),
  ('Facultad de Ingeniería'),
  ('Facultad de Filosofía');

INSERT INTO carrera (nombre, facultad_idfacultad) VALUES
  ('Lic. en Sistemas de Información', 1),
  ('Lic. en Geofísica', 1),
  ('Ing. Informática', 2),
  ('Ing. Electrónica', 2),
  ('Prof. en Historia', 3);

INSERT INTO alumno (nombre, registro, carrera_idcarrera) VALUES
  ('Javier Rojas', 'E01234', 1),
  ('Ana Pérez',    'E05678', 3),
  ('Lucas Gómez',  'E09012', 1),
  ('Sofía Díaz',   'E03456', 4),
  ('Martín Ruiz',  'E07890', 5);

INSERT INTO materia (nombre) VALUES
  ('Desarrollo Backend III'),
  ('Base de Datos'),
  ('Programación II'),
  ('Redes'),
  ('Sistemas Operativos');

-- Exámenes: turno de julio 2026, otro turno 2026 y años anteriores.
-- Lucas (3) y Martín (5) no rindieron nada en 2026.
INSERT INTO examen (alumno_idalumno, materia_idmateria, fecha, nota) VALUES
  (1, 1, '2026-07-14 09:00:00', 8),
  (2, 1, '2026-07-14 09:00:00', 6),
  (1, 2, '2026-07-21 09:00:00', 9),
  (4, 2, '2026-07-21 09:00:00', 4),
  (2, 3, '2026-02-18 09:00:00', 7),
  (1, 3, '2025-07-15 09:00:00', 2),
  (3, 2, '2025-12-10 09:00:00', 5),
  (5, 4, '2024-07-16 09:00:00', 8);

INSERT INTO docente (nombre, cargo) VALUES
  ('María López',   'TITULAR'),
  ('Carlos Sánchez','ADJUNTO'),
  ('Laura Torres',  'JTP'),
  ('Pedro Álvarez', 'TITULAR');

INSERT INTO docente_has_materia (docente_iddocente, materia_idmateria) VALUES
  (1, 1), (1, 2), (1, 3),         -- María: 3 materias
  (2, 1), (2, 4),                 -- Carlos: 2 materias
  (3, 2), (3, 3), (3, 4), (3, 5), -- Laura: 4 materias
  (4, 5);                         -- Pedro: 1 materia
