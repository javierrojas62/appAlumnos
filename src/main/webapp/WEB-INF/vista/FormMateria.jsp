<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Materia</title>
</head>
<body>
    <h1>${empty materia ? 'Agregar materia' : 'Editar materia'}</h1>

    <form action="GuardarMateria" method="post">
        <c:if test="${not empty materia}">
            <input type="hidden" name="id" value="${materia.idmateria}">
        </c:if>

        <label>Nombre:</label>
        <input type="text" name="nombre" maxlength="45" required value="${materia.nombre}"><br><br>

        <button type="submit">Guardar</button>
    </form>
    <br><a href="ListarMaterias">Volver al listado</a>
</body>
</html>
