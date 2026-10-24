<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Alumno</title>
</head>
<body>
    <%-- Mismo formulario para agregar (sin alumno) y editar (con alumno) --%>
    <h1>${empty alumno ? 'Agregar alumno' : 'Editar alumno'}</h1>

    <form action="${empty alumno ? 'AgregarAlumno' : 'ActualizarAlumno'}" method="post">
        <c:if test="${not empty alumno}">
            <input type="hidden" name="id" value="${alumno.idalumno}">
        </c:if>

        <label>Registro:</label>
        <input type="text" name="registro" maxlength="10" required value="${alumno.registro}"><br><br>

        <label>Nombre:</label>
        <input type="text" name="nombre" maxlength="45" required value="${alumno.nombre}"><br><br>

        <label>Carrera:</label>
        <select name="carrera" required>
            <c:forEach var="c" items="${carreras}">
                <option value="${c.idcarrera}"
                    <c:if test="${c.idcarrera == alumno.carreraIdcarrera.idcarrera}">selected</c:if>>
                    ${c.nombre}
                </option>
            </c:forEach>
        </select><br><br>

        <button type="submit">Guardar</button>
    </form>
    <br><a href="Listar">Volver al listado</a>
</body>
</html>
