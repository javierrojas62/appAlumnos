<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carreras de ${facultad.nombre}</title>
</head>
<body>
    <%-- Práctico 4 - Ejercicio 2 --%>
    <h1>Carreras de ${facultad.nombre}</h1>
    <a href="index.jsp">Inicio</a>
    <hr>
    <c:choose>
        <c:when test="${empty carreras}">
            <p>Esta facultad no tiene carreras cargadas.</p>
        </c:when>
        <c:otherwise>
            <table border="1">
                <tr><th>ID</th><th>Carrera</th></tr>
                <c:forEach var="c" items="${carreras}">
                    <tr>
                        <td>${c.idcarrera}</td>
                        <td>${c.nombre}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
