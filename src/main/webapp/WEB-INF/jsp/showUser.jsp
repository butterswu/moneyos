<%--
  Created by IntelliJ IDEA.
  User: wuenze
  Date: 2017/7/23
  Time: 下午8:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>用户信息列表</title>
</head>
<body>
<c:if test="${!empty userList}">
    <c:forEach var="user" items="${userList}">
        姓名：${user.userName} <br>
    </c:forEach>
</c:if>
</body>
</html>
