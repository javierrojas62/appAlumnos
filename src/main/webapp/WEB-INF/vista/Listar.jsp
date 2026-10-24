<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Alumnos</title>
</head>
<body>
    <h1>Listado de alumnos</h1>
    <a href="index.jsp">Inicio</a> | <a href="SolicitarDatos">Agregar alumno</a>
    <hr>
    <table border="1">
        <tr>
            <th>Registro</th><th>Nombre</th><th>Carrera</th><th>Facultad</th><th>Acciones</th>
        </tr>
        <c:forEach var="a" items="${lista}">
            <tr>
                <td>${a.registro}</td>
                <td>${a.nombre}</td>
                <td>${a.carreraIdcarrera.nombre}</td>
                <td>${a.carreraIdcarrera.facultadIdfacultad.nombre}</td>
                <td>
                    <a href="EditarAlumno?id=${a.idalumno}">Editar</a>
                    <form action="EliminarAlumno" method="post" style="display:inline"
                          onsubmit="return confirm('¿Eliminar este alumno? También se borran sus exámenes.');">
                        <input type="hidden" name="id" value="${a.idalumno}">
                        <button type="submit">Eliminar</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
