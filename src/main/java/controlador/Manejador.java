package controlador;

import entidad.Alumno;
import entidad.Carrera;
import entidad.Facultad;
import entidad.Materia;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import sesion.AlumnoFacade;
import sesion.CarreraFacade;
import sesion.FacultadFacade;
import sesion.MateriaFacade;

/**
 * Controlador (MVC). Atiende todas las URLs de la aplicación,
 * usa los Session Beans (Facades) y reenvía a las vistas JSP.
 */
@WebServlet(name = "Manejador",
        loadOnStartup = 1,
        urlPatterns = {
            // Alumno
            "/Listar", "/SolicitarDatos", "/AgregarAlumno",
            "/EditarAlumno", "/ActualizarAlumno", "/EliminarAlumno",
            // Materia
            "/ListarMaterias", "/NuevaMateria", "/EditarMateria",
            "/GuardarMateria", "/EliminarMateria",
            // Carrera
            "/ListarCarreras", "/NuevaCarrera", "/EditarCarrera",
            "/GuardarCarrera", "/EliminarCarrera"})
public class Manejador extends HttpServlet {

    @EJB
    private AlumnoFacade alumnoF;

    @EJB
    private CarreraFacade carreraF;

    @EJB
    private MateriaFacade materiaF;

    @EJB
    private FacultadFacade facultadF;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String pathUsuario = request.getServletPath();
        String url = null;

        switch (pathUsuario) {

            // ============================ ALUMNO ============================
            case "/Listar": {
                request.setAttribute("lista", alumnoF.findAll());
                url = "/WEB-INF/vista/Listar.jsp";
                break;
            }

            case "/SolicitarDatos": {
                // Formulario vacío: solo necesita las carreras para el <select>
                request.setAttribute("carreras", carreraF.findAll());
                url = "/WEB-INF/vista/SolicitarDatos.jsp";
                break;
            }

            case "/AgregarAlumno": {
                Alumno a = new Alumno();
                a.setRegistro(request.getParameter("registro"));
                a.setNombre(request.getParameter("nombre"));
                Carrera c = carreraF.find(Integer.valueOf(request.getParameter("carrera")));
                a.setCarreraIdcarrera(c);
                alumnoF.create(a);                                    // INSERT
                response.sendRedirect(request.getContextPath() + "/Listar");
                return;
            }

            case "/EditarAlumno": {
                Integer id = Integer.valueOf(request.getParameter("id"));
                request.setAttribute("alumno", alumnoF.find(id));     // datos a mostrar
                request.setAttribute("carreras", carreraF.findAll());
                url = "/WEB-INF/vista/SolicitarDatos.jsp";            // mismo formulario
                break;
            }

            case "/ActualizarAlumno": {
                Alumno alumno = alumnoF.find(Integer.valueOf(request.getParameter("id")));
                if (alumno != null) {
                    alumno.setRegistro(request.getParameter("registro"));
                    alumno.setNombre(request.getParameter("nombre"));
                    Carrera carrera = carreraF.find(Integer.valueOf(request.getParameter("carrera")));
                    alumno.setCarreraIdcarrera(carrera);
                    alumnoF.edit(alumno);                             // UPDATE
                }
                response.sendRedirect(request.getContextPath() + "/Listar");
                return;
            }

            case "/EliminarAlumno": {
                Alumno alumno = alumnoF.find(Integer.valueOf(request.getParameter("id")));
                if (alumno != null) {
                    alumnoF.remove(alumno);   // DELETE (por el cascade también borra sus exámenes)
                }
                response.sendRedirect(request.getContextPath() + "/Listar");
                return;
            }

            // ============================ MATERIA ===========================
            case "/ListarMaterias": {
                request.setAttribute("materias", materiaF.findAll());
                url = "/WEB-INF/vista/ListarMaterias.jsp";
                break;
            }

            case "/NuevaMateria": {
                url = "/WEB-INF/vista/FormMateria.jsp";               // formulario vacío
                break;
            }

            case "/EditarMateria": {
                Integer id = Integer.valueOf(request.getParameter("id"));
                request.setAttribute("materia", materiaF.find(id));   // formulario con datos
                url = "/WEB-INF/vista/FormMateria.jsp";
                break;
            }

            case "/GuardarMateria": {
                // Sin id → crear. Con id → actualizar.
                String idParam = request.getParameter("id");
                String nombre = request.getParameter("nombre");
                if (idParam == null || idParam.isEmpty()) {
                    Materia m = new Materia();
                    m.setNombre(nombre);
                    materiaF.create(m);                               // INSERT
                } else {
                    Materia m = materiaF.find(Integer.valueOf(idParam));
                    if (m != null) {
                        m.setNombre(nombre);
                        materiaF.edit(m);                             // UPDATE
                    }
                }
                response.sendRedirect(request.getContextPath() + "/ListarMaterias");
                return;
            }

            case "/EliminarMateria": {
                Materia m = materiaF.find(Integer.valueOf(request.getParameter("id")));
                if (m != null) {
                    materiaF.remove(m);       // DELETE (por el cascade también borra sus exámenes)
                }
                response.sendRedirect(request.getContextPath() + "/ListarMaterias");
                return;
            }

            // ============================ CARRERA ===========================
            case "/ListarCarreras": {
                request.setAttribute("carreras", carreraF.findAll());
                url = "/WEB-INF/vista/ListarCarreras.jsp";
                break;
            }

            case "/NuevaCarrera": {
                request.setAttribute("facultades", facultadF.findAll()); // para el <select>
                url = "/WEB-INF/vista/FormCarrera.jsp";
                break;
            }

            case "/EditarCarrera": {
                Integer id = Integer.valueOf(request.getParameter("id"));
                request.setAttribute("carrera", carreraF.find(id));
                request.setAttribute("facultades", facultadF.findAll());
                url = "/WEB-INF/vista/FormCarrera.jsp";
                break;
            }

            case "/GuardarCarrera": {
                String idParam = request.getParameter("id");
                String nombre = request.getParameter("nombre");
                Facultad f = facultadF.find(Integer.valueOf(request.getParameter("facultad")));
                if (idParam == null || idParam.isEmpty()) {
                    Carrera c = new Carrera();
                    c.setNombre(nombre);
                    c.setFacultadIdfacultad(f);
                    carreraF.create(c);                               // INSERT
                } else {
                    Carrera c = carreraF.find(Integer.valueOf(idParam));
                    if (c != null) {
                        c.setNombre(nombre);
                        c.setFacultadIdfacultad(f);
                        carreraF.edit(c);                             // UPDATE
                    }
                }
                response.sendRedirect(request.getContextPath() + "/ListarCarreras");
                return;
            }

            case "/EliminarCarrera": {
                Integer id = Integer.valueOf(request.getParameter("id"));
                // Por el CascadeType.ALL, borrar una carrera borraría TODOS sus alumnos.
                // Para no perder datos, solo se permite si la carrera no tiene alumnos.
                if (carreraF.cantidadAlumnos(id) > 0) {
                    request.getSession().setAttribute("error",
                            "No se puede eliminar la carrera porque tiene alumnos inscriptos.");
                } else {
                    Carrera c = carreraF.find(id);
                    if (c != null) {
                        carreraF.remove(c);                           // DELETE
                    }
                }
                response.sendRedirect(request.getContextPath() + "/ListarCarreras");
                return;
            }

            default: {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
        }

        request.getRequestDispatcher(url).forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
