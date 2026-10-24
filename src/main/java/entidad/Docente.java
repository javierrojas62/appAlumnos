package entidad;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import java.io.Serializable;
import java.util.Collection;

/**
 * Práctico 4 - Ejercicios 4 y 5.
 * Un docente dicta varias materias y una materia está a cargo de varios
 * docentes: relación N:M mediante la tabla docente_has_materia.
 *
 * @author javierrojas
 */
@Entity
@Table(name = "docente", catalog = "bdalumnos", schema = "")
@NamedQueries({
    @NamedQuery(name = "Docente.findAll", query = "SELECT d FROM Docente d"),
    @NamedQuery(name = "Docente.findByIddocente", query = "SELECT d FROM Docente d WHERE d.iddocente = :iddocente"),
    @NamedQuery(name = "Docente.findByNombre", query = "SELECT d FROM Docente d WHERE d.nombre = :nombre"),
    @NamedQuery(name = "Docente.findByCargo", query = "SELECT d FROM Docente d WHERE d.cargo = :cargo")})
public class Docente implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "iddocente", nullable = false)
    private Integer iddocente;
    @Basic(optional = false)
    @Size(min = 1, max = 45)
    @Column(name = "nombre", nullable = false, length = 45)
    private String nombre;
    // Columna ENUM('TITULAR','ADJUNTO','JTP') en MySQL
    @Basic(optional = false)
    @Size(min = 1, max = 7)
    @Column(name = "cargo", nullable = false, length = 7)
    private String cargo;
    // Lado "dueño" de la relación N:M: es el que maneja la tabla docente_has_materia
    @JoinTable(name = "docente_has_materia", catalog = "bdalumnos", schema = "",
            joinColumns = @JoinColumn(name = "docente_iddocente", referencedColumnName = "iddocente", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "materia_idmateria", referencedColumnName = "idmateria", nullable = false))
    @ManyToMany
    private Collection<Materia> materiaCollection;

    public Docente() {
    }

    public Docente(Integer iddocente) {
        this.iddocente = iddocente;
    }

    public Integer getIddocente() {
        return iddocente;
    }

    public void setIddocente(Integer iddocente) {
        this.iddocente = iddocente;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public Collection<Materia> getMateriaCollection() {
        return materiaCollection;
    }

    public void setMateriaCollection(Collection<Materia> materiaCollection) {
        this.materiaCollection = materiaCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iddocente != null ? iddocente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Docente)) {
            return false;
        }
        Docente other = (Docente) object;
        if ((this.iddocente == null && other.iddocente != null) || (this.iddocente != null && !this.iddocente.equals(other.iddocente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entidad.Docente[ iddocente=" + iddocente + " ]";
    }

}
