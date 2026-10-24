package sesion;

import entidad.Carrera;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

/**
 *
 * @author javierrojas
 */
@Stateless
public class CarreraFacade extends AbstractFacade<Carrera> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CarreraFacade() {
        super(Carrera.class);
    }

    /** Cantidad de alumnos inscriptos en la carrera (consulta JPQL). */
    public long cantidadAlumnos(Integer idcarrera) {
        return em.createQuery(
                "SELECT COUNT(a) FROM Alumno a WHERE a.carreraIdcarrera.idcarrera = :id", Long.class)
                .setParameter("id", idcarrera)
                .getSingleResult();
    }

    /** Práctico 4 - Ejercicio 2: carreras de la facultad elegida. */
    public List<Carrera> listarPorFacultad(Integer idfacultad) {
        return em.createQuery(
                "SELECT c FROM Carrera c WHERE c.facultadIdfacultad.idfacultad = :id ORDER BY c.nombre",
                Carrera.class)
                .setParameter("id", idfacultad)
                .getResultList();
    }
}
