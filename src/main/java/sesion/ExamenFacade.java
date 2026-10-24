package sesion;

import entidad.Examen;
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
public class ExamenFacade extends AbstractFacade<Examen> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ExamenFacade() {
        super(Examen.class);
    }

    /**
     * Ejercicio 6.1 (JPQL): mesas de examen del turno de julio del año indicado,
     * con el nombre del alumno y la nota obtenida.
     * Turno de julio = fechas desde el 1 de julio (inclusive) hasta el 1 de agosto (exclusive).
     */
    public List<Examen> listarTurnoJulio(int anio) {
        return em.createQuery(
                "SELECT e FROM Examen e "
                + "WHERE e.examenPK.fecha >= :desde AND e.examenPK.fecha < :hasta "
                + "ORDER BY e.materia.nombre, e.examenPK.fecha, e.alumno.nombre", Examen.class)
                .setParameter("desde", Timestamp.valueOf(LocalDateTime.of(anio, 7, 1, 0, 0)))
                .setParameter("hasta", Timestamp.valueOf(LocalDateTime.of(anio, 8, 1, 0, 0)))
                .getResultList();
    }
}
