-- =====================================================================
-- Práctico 4 - Ejercicio 4
-- Agrega la entidad Docente a la base bdalumnos EXISTENTE,
-- sin borrar ni modificar los datos que ya están cargados.
-- =====================================================================
USE bdalumnos;

CREATE TABLE IF NOT EXISTS docente (
  iddocente INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre    VARCHAR(45) NOT NULL,
  cargo     ENUM('TITULAR', 'ADJUNTO', 'JTP') NOT NULL,
  PRIMARY KEY (iddocente)
) ENGINE = InnoDB;

-- Un docente dicta varias materias y una materia está a cargo de
-- varios docentes: relación N:M con tabla intermedia.
CREATE TABLE IF NOT EXISTS docente_has_materia (
  docente_iddocente INT UNSIGNED NOT NULL,
  materia_idmateria INT UNSIGNED NOT NULL,
  PRIMARY KEY (docente_iddocente, materia_idmateria),
  INDEX fk_dhm_materia_idx (materia_idmateria),
  CONSTRAINT fk_dhm_docente
    FOREIGN KEY (docente_iddocente) REFERENCES docente (iddocente),
  CONSTRAINT fk_dhm_materia
    FOREIGN KEY (materia_idmateria) REFERENCES materia (idmateria)
) ENGINE = InnoDB;
