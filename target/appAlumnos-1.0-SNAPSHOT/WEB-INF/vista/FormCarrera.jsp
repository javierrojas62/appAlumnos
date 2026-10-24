<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrera</title>
</head>
<body>
    <h1>${empty carrera ? 'Agregar carrera' : 'Editar carrera'}</h1>

    <form action="GuardarCarrera" method="post">
        <c:if test="${not empty carrera}">
            <input type="hidden" name="id" value="${carrera.idcarrera}">
        </c:if>

        <label>Nombre:</label>
        <input type="text" name="nombre" maxlength="45" required value="${carrera.nombre}"><br><br>

        <label>Facultad:</label>
        <select name="facultad" required>
            <c:forEach var="f" items="${facultades}">
                <option value="${f.idfacultad}"
                    <c:if test="${f.idfacultad == carrera.facultadIdfacultad.idfacultad}">selected</c:if>>
                    ${f.nombre}
                </option>
            </c:forEach>
        </select><br><br>

        <button type="submit">Guardar</button>
    </form>
    <br><a href="ListarCarreras">Volver al listado</a>
</body>
</html>
