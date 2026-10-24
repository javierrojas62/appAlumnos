# AppAlumnos – Sistema de Gestión de Alumnos

Trabajo práctico de **Desarrollo Backend III** – Universidad Nacional de San Juan.
Aplicación web Jakarta EE con persistencia JPA sobre MySQL.

**Autor:** Javier Rojas

## Contenido

### Práctico Persistencia 1
- Modelo entidad-relación `bdalumnos` (facultad, carrera, alumno, materia, examen).
- Entidades JPA generadas desde la base (paquete `entidad`).
- CRUD completo de **Alumno**, **Materia** y **Carrera**.

### Práctico 4 – EJB
| Ejercicio | Implementación |
|---|---|
| 1. Menú de facultades dinámico | `Manejador.init()` guarda las facultades en el contexto del servlet; `index.jsp` arma el menú |
| 2. Carreras de la facultad elegida | URL `/Facultad?id=` → `CarrerasFacultad.jsp` |
| 3. Alta de alumno con lista de carreras | `<select>` con `c:forEach` en `SolicitarDatos.jsp` |
| 4. Entidad Docente en la BD | `bd/02_agregar_docente.sql` (tablas `docente` y `docente_has_materia`, relación N:M) |
| 5. Entidad y bean | `entidad.Docente` (`@ManyToMany`) y `sesion.DocenteFacade` |
| 6.1 Turno de julio | `ExamenFacade.listarTurnoJulio()` → `/TurnoJulio` |
| 6.2 Alumnos sin exámenes en el año | `AlumnoFacade.listarSinExamenesEnAnio()` (`NOT EXISTS`) → `/AlumnosSinExamen` |
| 6.3 Docentes con más de dos materias | `DocenteFacade.listarQueDictanMasDeDosMaterias()` (`GROUP BY` / `HAVING`) → `/DocentesMasDeDos` |

## Arquitectura (MVC + Session Facade)

```
Navegador → Manejador (Servlet / controlador)
               │ @EJB
               ▼
            *Facade (@Stateless)  ── CRUD heredado de AbstractFacade + consultas JPQL
               │ @PersistenceContext(unitName = "AppAlumnosPU")
               ▼
            Entidades JPA → jdbc/bdalumnos (BDAlumnosPool) → MySQL

Manejador ──forward──► JSP en /WEB-INF/vista (JSTL + EL)
```

## Tecnologías

- JDK 21
- Eclipse GlassFish 8.0.0 (Jakarta EE 11)
- MySQL 8.0 + driver `mysql-connector-j-8.4.0`
- JPA (EclipseLink), EJB, Servlets, JSP, JSTL
- Maven / NetBeans

## Cómo ejecutarlo

### 1. Base de datos
Base nueva, con datos de prueba (**borra `bdalumnos` si existe**):
```bash
mysql -u root -p < bd/bdalumnos.sql
```
Sobre una base existente del Práctico 1, sin perder datos:
```bash
mysql -u root -p < bd/02_agregar_docente.sql
mysql -u root -p < bd/03_datos_prueba_practico4.sql
```

### 2. Driver JDBC y pool de conexiones en GlassFish
```bash
asadmin add-library mysql-connector-j-8.4.0.jar
asadmin restart-domain

asadmin create-jdbc-connection-pool \
  --datasourceclassname com.mysql.cj.jdbc.MysqlDataSource \
  --restype javax.sql.ConnectionPoolDataSource \
  --property user=root:password=root:serverName=localhost:portNumber=3306:databaseName=bdalumnos:useSSL=false:allowPublicKeyRetrieval=true:serverTimezone=UTC \
  BDAlumnosPool

asadmin ping-connection-pool BDAlumnosPool
asadmin create-jdbc-resource --connectionpoolid BDAlumnosPool jdbc/bdalumnos
```
(Ajustar usuario y contraseña de MySQL.)

### 3. Desplegar
Abrir el proyecto en NetBeans, seleccionar GlassFish como servidor y ejecutar **Run**.

Abrir: `http://localhost:8080/appAlumnos/`
