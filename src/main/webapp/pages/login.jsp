<%--
  Created by IntelliJ IDEA.
  User: wuenze
  Date: 2017/7/24
  Time: 下午9:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <base href="<%=basePath%>">
    <title>login</title><meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="pages/css/bootstrap.min.css" />
    <link rel="stylesheet" href="pages/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="pages/css/matrix-login.css" />
    <link href="pages/font-awesome/css/font-awesome.css" rel="stylesheet" />


</head>
<body>
<div id="loginbox">
    <form  class="form-vertical" action="<%=basePath%>user/login" method="post">
        <div class="control-group normal_text"> <h3><img src="pages/img/logo.png" alt="Logo" /></h3></div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_lg"><i class="icon-user"></i></span><input type="text" placeholder="用户名" name="userName" />
                </div>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <div class="main_input_box">
                    <span class="add-on bg_ly"><i class="icon-lock"></i></span><input type="password" placeholder="密码" name="userPwd"/>
                </div>
            </div>
        </div>
        <div class="form-actions">

            <span class="pull-right"><input   class="btn btn-success" type="submit" value="登陆"/> </span>
        </div>
    </form>
    <form id="recoverform" action="#" class="form-vertical">
        <p class="normal_text">Enter your e-mail address below and we will send you instructions how to recover a password.</p>

        <div class="controls">
            <div class="main_input_box">
                <span class="add-on bg_lo"><i class="icon-envelope"></i></span><input type="text" placeholder="E-mail address" />
            </div>
        </div>

        <div class="form-actions">
            <span class="pull-left"><a href="#" class="flip-link btn btn-success" id="to-login">&laquo; Back to login</a></span>

        </div>
    </form>
</div>

<script src="pages/js/jquery.min.js"></script>
<script src="pages/js/matrix.login.js"></script>
</body>

</html>

