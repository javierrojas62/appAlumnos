<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Materias</title>
</head>
<body>
    <h1>Materias</h1>
    <a href="index.jsp">Inicio</a> | <a href="NuevaMateria">Agregar materia</a>
    <hr>
    <table border="1">
        <tr><th>ID</th><th>Nombre</th><th>Acciones</th></tr>
        <c:forEach var="m" items="${materias}">
            <tr>
                <td>${m.idmateria}</td>
                <td>${m.nombre}</td>
                <td>
                    <a href="EditarMateria?id=${m.idmateria}">Editar</a>
                    <form action="EliminarMateria" method="post" style="display:inline"
                          onsubmit="return confirm('¿Eliminar esta materia? También se borran sus exámenes.');">
                        <input type="hidden" name="id" value="${m.idmateria}">
                        <button type="submit">Eliminar</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
