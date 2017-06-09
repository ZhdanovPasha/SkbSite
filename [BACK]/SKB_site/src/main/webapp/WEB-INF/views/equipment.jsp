<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!doctype html>
<html lang="ru">
<head>
    <meta charset="utf-8"/>
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${contextPath}/resources/images/logo.png">

    <title>СКБ</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/equipment.css">
</head>
<body>

  <div id="leftSide">
  </div>
  <div id="rightSide">
  </div>


  <%@include file="header.jsp" %>

<!-- main-->
<div class="container">

  <div class="row">
    <div class="col-xs-9" >
      <ul class="titleHead">
        <li><div class="smallBlueBox"></div></li>
        <li><h3>Оборудование</h3></li>
      </ul>
    </div>
    <div class="col-xs-3">
        <input type="button" class="btn btn-back btn-lg" onClick="self.location.href='/add-equipment-type';" value="Добавить модель">
    </div>
  </div>

  <c:if test="${empty equipmentTypeList}">
    <h1>
      К сожалению на данный момент оборудования нет<br>
      :(</h1>
  </c:if>

  <c:if test="${!empty equipmentTypeList}">
    <c:forEach items="equipmentTypeList" var="item">
  <div class="row">
    <div class="col-xs-4" >
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/1.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino Titan</p>
          </div>

          <div class="col-xs-12 visible-xs">
            <p>Ardruino Titan</p>
          </div>
        </a>
      </div>
    </div>
  </div>
  </c:forEach>
  </c:if>


  <div class="row">
    <div class="col-xs-4" >
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/1.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino Titan</p>
          </div>

          <div class="col-xs-12 visible-xs">
            <p>Ardruino Titan</p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-xs-4">
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/2.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino MKR1000</p>
          </div>
          <div class="col-xs-12 visible-xs">
            <p>
            Ardruino MKR1000
            </p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-xs-4">
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/3.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino MKRFOX1200</p>
          </div>
          <div class="col-xs-12 visible-xs">
            <p>Ardruino MKRFOX1200</p>
          </div>
        </a>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-4" >
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/1.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino Titan</p>
          </div>

          <div class="col-xs-12 visible-xs">
            <p>Ardruino Titan</p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-xs-4">
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/2.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino MKR1000</p>
          </div>
          <div class="col-xs-12 visible-xs">
            <p>
            Ardruino MKR1000
            </p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-xs-4">
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/3.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino MKRFOX1200</p>
          </div>
          <div class="col-xs-12 visible-xs">
            <p>Ardruino MKRFOX1200</p>
          </div>
        </a>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-4" >
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/1.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino Titan</p>
          </div>

          <div class="col-xs-12 visible-xs">
            <p>Ardruino Titan</p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-xs-4">
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/2.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino MKR1000</p>
          </div>
          <div class="col-xs-12 visible-xs">
            <p>
            Ardruino MKR1000
            </p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-xs-4">
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/3.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino MKRFOX1200</p>
          </div>
          <div class="col-xs-12 visible-xs">
            <p>Ardruino MKRFOX1200</p>
          </div>
        </a>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-xs-4" >
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/1.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino Titan</p>
          </div>

          <div class="col-xs-12 visible-xs">
            <p>Ardruino Titan</p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-xs-4">
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/2.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino MKR1000</p>
          </div>
          <div class="col-xs-12 visible-xs">
            <p>
            Ardruino MKR1000
            </p>
          </div>
        </a>
      </div>
    </div>
    <div class="col-xs-4">
      <div class="item">
        <a href="#">
          <div class="col-xs-6 hidden-xs"><img src="${contextPath}/resources/images/microcontrollers/3.jpg" alt="" width=100%></div>
          <div class="col-xs-6 hidden-xs">
            <p>Ardruino MKRFOX1200</p>
          </div>
          <div class="col-xs-12 visible-xs">
            <p>Ardruino MKRFOX1200</p>
          </div>
        </a>
      </div>
    </div>
  </div>



</div>






<!--end main-->

  <%@include file="footer.jsp" %>

    <script src="../../resources/js/jquery.min.js"></script>
    <script src="../../resources/js/jquery-3.1.1.slim.min.js"></script>
    <script>window.jQuery</script>
    <script src="../../resources/js/tether.min.js"></script>
    <script src="../../resources/bootstrap/js/bootstrap.js"></script>

</body>

</html>
