package sesion;

import entidad.Alumno;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author javierrojas
 */
@Stateless
public class AlumnoFacade extends AbstractFacade<Alumno> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AlumnoFacade() {
        super(Alumno.class);
    }

    /**
     * Ejercicio 6.2 (JPQL): alumnos que no rindieron ninguna materia en el año indicado.
     * Usa una subconsulta con NOT EXISTS.
     */
    public List<Alumno> listarSinExamenesEnAnio(int anio) {
        return em.createQuery(
                "SELECT a FROM Alumno a "
                + "WHERE NOT EXISTS ("
                + "    SELECT e FROM Examen e "
                + "    WHERE e.alumno = a "
                + "      AND e.examenPK.fecha >= :desde AND e.examenPK.fecha < :hasta) "
                + "ORDER BY a.nombre", Alumno.class)
                .setParameter("desde", Timestamp.valueOf(LocalDateTime.of(anio, 1, 1, 0, 0)))
                .setParameter("hasta", Timestamp.valueOf(LocalDateTime.of(anio + 1, 1, 1, 0, 0)))
                .getResultList();
    }
}
