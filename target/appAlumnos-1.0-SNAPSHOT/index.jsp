<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Sistema Alumnos</title>
</head>
<body>
    <h1>SISTEMA ALUMNOS</h1>
    <nav>
        <a href="index.jsp">Inicio</a> |
        <a href="Listar">Alumnos</a> |
        <a href="ListarCarreras">Carreras</a> |
        <a href="ListarMaterias">Materias</a> |
        <a href="ListarDocentes">Docentes</a>
    </nav>
    <hr>

    <%-- Práctico 4 - Ejercicio 1: menú de facultades armado desde la BD.
         "facultades" lo cargó el Manejador en init() (scope application). --%>
    <h3>Facultades</h3>
    <ul>
        <c:forEach var="f" items="${applicationScope.facultades}">
            <li><a href="Facultad?id=${f.idfacultad}">${f.nombre}</a></li>
        </c:forEach>
    </ul>

    <%-- Práctico 4 - Ejercicio 6: consultas JPQL --%>
    <h3>Consultas</h3>
    <ul>
        <li><a href="TurnoJulio">Mesas de examen del turno de julio</a></li>
        <li><a href="AlumnosSinExamen">Alumnos que no rindieron en el año en curso</a></li>
        <li><a href="DocentesMasDeDos">Docentes que dictan más de dos materias</a></li>
    </ul>
</body>
</html>
