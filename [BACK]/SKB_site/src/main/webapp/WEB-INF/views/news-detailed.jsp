<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page pageEncoding="UTF-8"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="title" value="Новость '${news.name}'"/>

<!doctype html>
<html lang="ru">

<head>
  <meta charset="utf-8" />
  <meta name="description" content="">
  <meta name="author" content="">
  <meta name="_csrf_parameter" content="_csrf" />
  <meta name="_csrf_header" content="X-CSRF-TOKEN" />
  <meta name="_csrf" content="${_csrf.token}" />

    <link rel="icon" href="${contextPath}/resources/images/logo.png">
  <script src="${contextPath}/resources/js/jquery-3.2.1.min.js"></script>
  <title>${title}</title>
  <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/news-detailed.css">
</head>

<body>

  <div id="leftSide">
  </div>
  <div id="rightSide">
  </div>

  <!--Функция для появления формы с комментарием и кнопки,
  с помощью которых можно изменить комментарий -->
  <script type="text/javascript">
      function prepareForEdit(id) {
          var comment = document.getElementById("textComment" + id.toString());
          comment.style.display = 'none';
          var text = comment.innerHTML;
          var inputForm = document.getElementById("editTextComment" + id.toString());
          inputForm.style.display = 'block';
          inputForm.value = text;
          var inputButton = document.getElementById("editBtnComment" + id.toString());
          inputButton.style.display = 'block';
      }
  </script>
  <!--Функция для динамического изменения комментария и
   сохранения его в базу данных-->
  <script type="text/javascript">
      function changeComment(idComment){
          var formData = {
              id : idComment,
              content : $("#editTextComment" + idComment.toString()).val()
              };
          var data = new FormData();
          data.append("id", idComment);
          <%--data.append("news", ${news});--%>
          data.append("content", $("#editTextComment" + idComment.toString()).val());
          alert(data);
          alert(idComment);
          alert($("#editTextComment" + idComment.toString()).val());
          $.ajax({
              headers: {'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')},
              type: "POST",
              url: "/news-detailed/edit-comment",
              data: JSON.stringify(formData),
              dataType : 'json',
              processData : false,
              success: function (result) {
                  document.getElementById("#infoMessage"+idComment.toString()).val = result;
                  var comment = document.getElementById("textComment" + idComment.toString());
                  comment.style.display = 'inline';
                  var inputForm = document.getElementById("editTextComment" + idComment.toString());
                  inputForm.style.display = 'none';
                  var inputButton = document.getElementById("editBtnComment" + idComment.toString());
                  inputButton.style.display = 'none';
              }
          });
//          $.ajax({
//              type: 'POST',
//              url: "/news-detailed/edit-comment",
//              data: formData,
//              dataType: 'json',
//              success: function (result) {
//                  document.getElementById("#infoMessage"+idComment.toString()).val = result;
//              }
//          });
      }


  </script>


  <%@include file="header.jsp" %>

  <div class="container content">
    <!--Новости и проекты-->
    <div class="row">
      <!--Новости раздел-->
      <div class="col-md-8">
        <ul class="titleHead">
          <li>
            <div class="smallBlueBox"></div>
          </li>
          <li>
            <h3>${title}</h3></li>
        </ul>
      </div>
    </div>
    <!--IIMAGE 1-->
    <c:if test = "${!empty news}">
        <sec:authorize access="hasRole('ROLE_ADMIN') or '${logUser.username == news.author.username}'">
            <div class="form-group">
                <input type="button" class="btn btn-back btn-lg" onClick="self.location.href='/edit-news?newsId=${news.id}';" value="Редактировать">
                <form method="POST" action="/delete-news" class="btn">
                    <input type="hidden" value="${news.id}" name="newsId"/>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-back btn-lg" onClick="(confirm('Вы уверены что хотите удалить новость?'))">Удалить</button>
                </form>
            </div>
        </sec:authorize>
        <c:set var="newsProject" value="${news.project}"/>
        <div class="row">
            <div class="col-xs-12 image"><img src="${news.photoPath}" alt="${news.name} Картинка" width="100%"></div></div>
        <div class="row ">
            <div class="col-xs-12">

                <div class="new">

                    <p class="title">
                            ${news.name}
                    </p>
                    <p>
                        <c:if test="${newsProject != null}">
                            Проект:
                            <a href="/project-detailed?projectId=${newsProject.id}">${newsProject.name}</a>
                        </c:if>
                    </p>
                    <p class="article">
                            ${news.content}
                    </p>


                    <p class="description">
                        Автор: <a href="/id${news.author.id}">${news.author.username}</a><br>
                        <c:if test="${news.timeOfCreation == news.timeOfLastUpdate}">
                            ${news.timeOfCreation}
                        </c:if>
                        <c:if test="${news.timeOfCreation != news.timeOfLastUpdate}">
                            <c:if test="${news.editor.username!= news.author.username}">
                                Редактор: <a href="/id${news.author.id}">${news.editor.username}</a> <br>
                            </c:if>
                            <span class="glyphicon glyphicon-pencil"></span> Изменено ${news.timeOfLastUpdate}
                        </c:if>
                    </p>
                </div>
            </div>

        </div>
      <div class="row">
        <div class="col-md-12">
          <h3>Комментарии(${commentsForCurrentNews.size()})</h3>
        </div>
      </div>
      <%--<c:if test="${!empty comments}">--%>
      <c:forEach items="${commentsForCurrentNews}" var="item">
        <div class="row">
          <div class="col-sm-1">
            <div class="thumbnail">
              <img class="img-responsive user-photo" src="${contextPath}/resources/images/${item.author.photoPath}">
            </div>
            <!-- /thumbnail -->
          </div>
          <!-- /col-sm-1 -->

          <div class="col-sm-8">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong><a href="/id${item.author.id}">${item.author.username}</a></strong>
                    <span class="text-muted">добавлено ${item.timeOfCreation}</span>
                </div>
                <sec:authorize access="hasRole('ROLE_ADMIN') or '${logUser.id == item.author.id}'">
                    <div class="form-group">
                        <form method="POST" action="/delete-comment" class="btn">
                            <input type="hidden" value="${news.id}" name="newsId"/>
                            <input type="hidden" value="${item.id}" name="commentId"/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-back" onClick="(confirm('Вы уверены что хотите удалить комментарий?'))">Удалить</button>
                        </form>
                        <button type="submit" class="btn btn-back" onClick="prepareForEdit('${item.id}')">Редактировать</button>
                    </div>
                </sec:authorize>
              <div class="row">
                  <p id="infoMassage${item.id}" class="text-success"></p>
              </div>
              <div class="panel-body">
                  <p id="textComment${item.id}">${item.content}</p>
                  <div class="row-fluid">
                      <div class="form-group">
                          <textarea id="editTextComment${item.id}" class="form-control editText"></textarea>
                      </div>
                      <div class="text-right">
                        <button type="submit" id="editBtnComment${item.id}" class="btn-md btn-back btn text-center editBtn" onClick="changeComment(${item.id})">Изменить</button>
                      </div>
                  </div>
              </div>
                <!-- /panel-body -->
            </div>
            <!-- /panel panel-default -->
          </div>
          <!-- /col-sm-5 -->
        </div>
      </c:forEach>

    <sec:authorize access="isAuthenticated()">
        <div class="col-md-9">
          <div class="widget-area no-padding blank">
            <div class="status-upload">
              <form:form method="POST" modelAttribute="commentForm" class="form-horizontal">
                <spring:bind path="content">
                  <form:textarea path="content" placeholder="Ваш комментарий"/>
                  <form:errors path="content"/>
                </spring:bind>
                <spring:bind path="news.id">
                    <form:input path="news.id" value="${news.id}" cssStyle="visibility: hidden"/>
                </spring:bind>
                <button class="btn btn-success green"><i class="fa fa-share"></i> Комментировать</button>
              </form:form>
            </div><!-- Status Upload  -->
          </div><!-- Widget Area -->
        </div>
    </sec:authorize>

    </c:if>
  </div>
<!-- /container -->

  <%@include file="footer.jsp" %>

  <%--<script src="../../resources/js/jquery.min.js"></script>--%>
  <%--<script src="../../resources/js/jquery-3.1.1.slim.min.js"></script>--%>
  <%--<script>window.jQuery</script>--%>
  <script src="../../resources/js/tether.min.js"></script>
  <script src="../../resources/bootstrap/js/bootstrap.js"></script>


</body>

</html>
