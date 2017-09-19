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
    <title>MoneyOS</title><meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" user-scalable=no/>
    <meta http-equiv="Cache-Control" content="no-cache">
    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">
    <link rel="stylesheet" href="pages/css/login.css" />
</head>
<body>
<div class="headerbox">
    <div class="header">
        <a href="/" class="header_logo"></a>
    </div>
</div>
<div id="loginbox" class="loginbox">
    <form  class="form-vertical formbox" action="<%=basePath%>user/shiro-login" method="post">
        <h1 class="login_intrduce">登录MoneyOS系统</h1>
        <div class="control-group btn_margin">
            <div class="controls">
                <div class="main_input_box">
                    <input class="btn_username" type="text" placeholder="用户名" name="userName" />
                </div>
            </div>
        </div>
        <div class="control-group btn_margin">
            <div class="controls">
                <div class="main_input_box">
                    <input class="btn_password" type="password" placeholder="密码" name="userPwd"/>
                </div>
            </div>
        </div>
        <div class="form-actions btn_margin">
            <input class="btn btn-success btn_login" type="submit" value="登 录"/>
        </div>
    </form>
    <!-- <form id="recoverform" action="#" class="form-vertical">
        <p class="normal_text">Enter your e-mail address below and we will send you instructions how to recover a password.</p>

        <div class="controls">
            <div class="main_input_box">
                <span class="add-on bg_lo"><i class="icon-envelope"></i></span><input type="text" placeholder="E-mail address" />
            </div>
        </div>

        <div class="form-actions">
            <span class="pull-left"><a href="#" class="flip-link btn btn-success" id="to-login">&laquo; Back to login</a></span>

        </div>
    </form> -->
</div>
<div class="copyright">© 2017 Kindsaving Inc. All Rights Reserved.</div>
<script src="pages/js/jquery.min.js"></script>
<script src="pages/js/matrix.login.js"></script>
</body>

</html>