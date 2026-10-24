<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Docentes con más de dos materias</title>
</head>
<body>
    <%-- Práctico 4 - Ejercicio 6.3 --%>
    <h1>Docentes que dictan más de dos materias</h1>
    <a href="index.jsp">Inicio</a>
    <hr>
    <c:choose>
        <c:when test="${empty filas}">
            <p>Ningún docente dicta más de dos materias.</p>
        </c:when>
        <c:otherwise>
            <table border="1">
                <tr><th>Docente</th><th>Cargo</th><th>Cantidad de materias</th></tr>
                <%-- Cada fila es un Object[]: [0] nombre, [1] cargo, [2] cantidad --%>
                <c:forEach var="fila" items="${filas}">
                    <tr>
                        <td>${fila[0]}</td>
                        <td>${fila[1]}</td>
                        <td>${fila[2]}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
