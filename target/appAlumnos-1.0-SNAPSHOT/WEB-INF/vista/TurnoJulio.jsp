<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Turno de julio</title>
</head>
<body>
    <%-- Práctico 4 - Ejercicio 6.1 --%>
    <h1>Mesas de examen - Turno de julio ${anio}</h1>
    <a href="index.jsp">Inicio</a>
    <hr>
    <form action="TurnoJulio" method="get">
        <label>Año:</label>
        <input type="number" name="anio" value="${anio}" min="2000" max="2100">
        <button type="submit">Consultar</button>
    </form>
    <br>
    <c:choose>
        <c:when test="${empty examenes}">
            <p>No hay exámenes en el turno de julio de ${anio}.</p>
        </c:when>
        <c:otherwise>
            <table border="1">
                <tr><th>Materia</th><th>Fecha</th><th>Alumno</th><th>Nota</th></tr>
                <c:forEach var="e" items="${examenes}">
                    <tr>
                        <td>${e.materia.nombre}</td>
                        <td><fmt:formatDate value="${e.examenPK.fecha}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>${e.alumno.nombre}</td>
                        <td>${e.nota}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
