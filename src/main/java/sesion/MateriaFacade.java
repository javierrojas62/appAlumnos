package sesion;

import entidad.Materia;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

/**
 *
 * @author javierrojas
 */
@Stateless
public class MateriaFacade extends AbstractFacade<Materia> {

    @PersistenceContext(unitName = "AppAlumnosPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MateriaFacade() {
        super(Materia.class);
    }

    /** Cantidad de docentes asignados a la materia (consulta JPQL). */
    public long cantidadDocentes(Integer idmateria) {
        return em.createQuery(
                "SELECT COUNT(d) FROM Docente d JOIN d.materiaCollection m WHERE m.idmateria = :id", Long.class)
                .setParameter("id", idmateria)
                .getSingleResult();
    }
}
