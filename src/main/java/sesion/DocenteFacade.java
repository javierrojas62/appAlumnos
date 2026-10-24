package sesion;

import entidad.Docente;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 * Práctico 4 - Ejercicio 5: Session Bean de la entidad Docente.
 *
 * @author javierrojas
 */
@Stateless
public class DocenteFacade extends AbstractFacade<Docente> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DocenteFacade() {
        super(Docente.class);
    }

    /** Docentes con sus materias ya cargadas (JOIN FETCH), para mostrarlas en la vista. */
    public List<Docente> listarConMaterias() {
        return em.createQuery(
                "SELECT DISTINCT d FROM Docente d LEFT JOIN FETCH d.materiaCollection ORDER BY d.nombre",
                Docente.class)
                .getResultList();
    }

    /**
     * Ejercicio 6.3 (JPQL): docentes que dictan más de dos materias.
     * Cada fila: [0] nombre, [1] cargo, [2] cantidad de materias.
     */
    public List<Object[]> listarQueDictanMasDeDosMaterias() {
        return em.createQuery(
                "SELECT d.nombre, d.cargo, COUNT(m) "
                + "FROM Docente d JOIN d.materiaCollection m "
                + "GROUP BY d.iddocente, d.nombre, d.cargo "
                + "HAVING COUNT(m) > 2 "
                + "ORDER BY d.nombre", Object[].class)
                .getResultList();
    }
}
