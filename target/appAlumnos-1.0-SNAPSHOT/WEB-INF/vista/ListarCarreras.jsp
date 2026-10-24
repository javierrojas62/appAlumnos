<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carreras</title>
</head>
<body>
    <h1>Carreras</h1>
    <a href="index.jsp">Inicio</a> | <a href="NuevaCarrera">Agregar carrera</a>
    <hr>

    <%-- Mensaje de error (por ejemplo, al intentar borrar una carrera con alumnos) --%>
    <c:if test="${not empty sessionScope.error}">
        <p style="color:red"><b>${sessionScope.error}</b></p>
        <c:remove var="error" scope="session"/>
    </c:if>

    <table border="1">
        <tr><th>ID</th><th>Nombre</th><th>Facultad</th><th>Acciones</th></tr>
        <c:forEach var="c" items="${carreras}">
            <tr>
                <td>${c.idcarrera}</td>
                <td>${c.nombre}</td>
                <td>${c.facultadIdfacultad.nombre}</td>
                <td>
                    <a href="EditarCarrera?id=${c.idcarrera}">Editar</a>
                    <form action="EliminarCarrera" method="post" style="display:inline"
                          onsubmit="return confirm('¿Eliminar esta carrera?');">
                        <input type="hidden" name="id" value="${c.idcarrera}">
                        <button type="submit">Eliminar</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
