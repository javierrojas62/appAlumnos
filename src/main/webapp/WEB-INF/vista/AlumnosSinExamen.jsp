<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Alumnos sin exámenes</title>
</head>
<body>
    <%-- Práctico 4 - Ejercicio 6.2 --%>
    <h1>Alumnos que no rindieron ninguna materia en ${anio}</h1>
    <a href="index.jsp">Inicio</a>
    <hr>
    <c:choose>
        <c:when test="${empty alumnos}">
            <p>Todos los alumnos rindieron al menos una materia en ${anio}.</p>
        </c:when>
        <c:otherwise>
            <table border="1">
                <tr><th>Registro</th><th>Nombre</th><th>Carrera</th></tr>
                <c:forEach var="a" items="${alumnos}">
                    <tr>
                        <td>${a.registro}</td>
                        <td>${a.nombre}</td>
                        <td>${a.carreraIdcarrera.nombre}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
