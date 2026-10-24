<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Docentes</title>
</head>
<body>
    <%-- Práctico 4 - Ejercicio 5: docentes y sus materias (relación N:M) --%>
    <h1>Docentes</h1>
    <a href="index.jsp">Inicio</a>
    <hr>
    <table border="1">
        <tr><th>Nombre</th><th>Cargo</th><th>Materias que dicta</th></tr>
        <c:forEach var="d" items="${docentes}">
            <tr>
                <td>${d.nombre}</td>
                <td>${d.cargo}</td>
                <td>
                    <c:forEach var="m" items="${d.materiaCollection}" varStatus="st">
                        ${m.nombre}<c:if test="${not st.last}">, </c:if>
                    </c:forEach>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
