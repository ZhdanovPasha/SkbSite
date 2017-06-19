<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!doctype html>
<html lang="ru">

<head>
    <meta charset="utf-8" />
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="icon" href="${contextPath}/resources/images/logo.png">

    <title>СКБ</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/equipment-table.css">

</head>

<body>

<main class="container-fluid">
    <H1>Таблица устройств модели ${equipmentType.name}</H1>
    <c:if test="${empty equipmentSet}">
        <h2>Не добавлено ни одно устройство.</h2>
    </c:if>
    <c:if test="${!empty equipmentSet}">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>UN устройства</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${equipmentSet}" var="item">
                    <tr>
                        <td>${item.id}</td>
                        <td>${item.uniqueNumber}</td>
                        <td>
                            <input type="button" class="btn btn-default" onClick="self.location.href='/equipment-table-${equipmentType.id}';" value="Редактировать UN"/>
                        </td>
                        <td>
                            <input type="button" class="btn btn-default"  onClick="self.location.href='/equipment-table-${equipmentType.id}';" value="Удалить"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>


        <form:form method="POST" modelAttribute="equipment" class="form-inline">

            <div class="form-group">
                <label for="equipmentNumber">UN нового устройства</label>
                <spring:bind path="uniqueNumber">
                        <form:input type = "text" path="uniqueNumber" placeholder="идентификационый номер модели" class="form-control" id="equipmentNumber"></form:input>
                        <form:errors path="uniqueNumber"></form:errors>
                </spring:bind>
                <button type="submit" class="btn btn-success green">Добавить новое устройство</button>
            </div>

        </form:form>

    <div class="row">
        <div class="col-xs-2">
            <button type="button" class="btn btn-default" >
                Назад
            </button>
        </div>
    </div>
</main>

<script src="../../resources/js/jquery.min.js"></script>
<script src="../../resources/js/jquery-3.1.1.slim.min.js"></script>
<script>window.jQuery</script>
<script src="../../resources/bootstrap/js/bootstrap.js"></script>



</body>

</html>
