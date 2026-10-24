package sesion;

import entidad.Carrera;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

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
}
