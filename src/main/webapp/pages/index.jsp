<%--
  Created by IntelliJ IDEA.
  User: wuenze
  Date: 2017/7/25
  Time: 下午3:29
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>">
<head>
    <title>MoneyOS</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="pages/css/bootstrap.min.css" />
    <link rel="stylesheet" href="pages/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="pages/css/fullcalendar.css" />
    <link rel="stylesheet" href="pages/css/matrix-style.css" />
    <link rel="stylesheet" href="pages/css/matrix-media.css" />
    <link href="pages/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" href="pages/css/jquery.gritter.css" />

</head>
<body>

<!--Header-part-->
<div id="header">
    <h1><a href="dashboard.html">MoneyOS</a></h1>
</div>
<!--close-Header-part-->


<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
    <ul class="nav">

            <ul class="dropdown-menu">

            </ul>
        </li>

            <ul class="dropdown-menu">

            </ul>
        </li>

    </ul>
</div>
<!--close-top-Header-menu-->
<!--start-top-serch-->
<div id="search">

</div>
<!--close-top-serch-->
<!--sidebar-menu-->
<div id="sidebar"><a href="pages/index.jsp" class="visible-phone"><i class="icon icon-home"></i>总览</a>
    <ul>

        <li class="active"><a href="pages/index.jsp"><i class="icon icon-home"></i> <span>总览</span></a> </li>

        <li><a href="<%=basePath%>client/managerlist"><i class="icon icon-th"></i> <span>客户管理</span></a></li>
        <li> <a href="<%=basePath%>park/parklist"><i class="icon icon-signal"></i> <span>园区管理</span></a> </li>


        <li><a href="<%=basePath%>user/user"><i class="icon icon-pencil"></i> <span>用户管理</span></a></li>


    </ul>
</div>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="pages/index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> 总览</a></div>
    </div>
    <!--End-breadcrumbs-->

    <!--Action boxes-->
    <div class="container-fluid">
        <div class="quick-actions_homepage">
            <ul class="quick-actions">
                <li class="bg_lb"> <a href="pages/index.jsp"> <i class="icon-dashboard"></i> <span class="label label-important">20</span> 总览 </a> </li>

                <li class="bg_lo"> <a href="<%=basePath%>client/managerlist"> <i class="icon-th"></i> 客户管理</a> </li>
                <li class="bg_ls"> <a href="<%=basePath%>park/parklist"> <i class="icon-tint"></i> 园区管理</a> </li>
                <li class="bg_lo"> <a href="<%=basePath%>user/account"> <i class="icon-th"></i>用户管理</a> </li>


            </ul>
            <shiro:hasRole name="salesman">
                <shiro:principal></shiro:principal>
            </shiro:hasRole>
        </div>
        <!--End-Action boxes-->

        <!--Chart-box-->
        <!--End-Chart-box-->
        <hr/>

    </div>
</div>

<!--end-main-container-part-->

<!--Footer-part-->

<div class="row-fluid">
    <div id="footer" class="span12"> 2017 &copy; MoneyOS Brought to you by <a href="http://www.kindsaving.cn/"></a>kindsaving.cn</div>
</div>

<!--end-Footer-part-->

<script src="pages/js/excanvas.min.js"></script>
<script src="pages/js/jquery.min.js"></script>
<script src="pages/js/jquery.ui.custom.js"></script>
<script src="pages/js/bootstrap.min.js"></script>
<script src="pages/js/jquery.flot.min.js"></script>
<script src="pages/js/jquery.flot.resize.min.js"></script>
<script src="pages/js/jquery.peity.min.js"></script>
<script src="pages/js/fullcalendar.min.js"></script>
<script src="pages/js/matrix.js"></script>
<script src="pages/js/matrix.dashboard.js"></script>
<script src="pages/js/jquery.gritter.min.js"></script>
<script src="pages/js/matrix.interface.js"></script>
<script src="pages/js/matrix.chat.js"></script>
<script src="pages/js/jquery.validate.js"></script>
<script src="pages/js/matrix.form_validation.js"></script>
<script src="pages/js/jquery.wizard.js"></script>
<script src="pages/js/jquery.uniform.js"></script>
<script src="pages/js/select2.min.js"></script>
<script src="pages/js/matrix.popover.js"></script>
<script src="pages/js/jquery.dataTables.min.js"></script>
<script src="pages/js/matrix.tables.js"></script>

<script type="text/javascript">
    // This function is called from the pop-up menus to transfer to
    // a different page. Ignore if the value returned is a null string:
    function goPage (newURL) {

        // if url is empty, skip the menu dividers and reset the menu selection to default
        if (newURL != "") {

            // if url is "-", it is this page -- reset the menu:
            if (newURL == "-" ) {
                resetMenu();
            }
            // else, send page to designated URL
            else {
                document.location.href = newURL;
            }
        }
    }

    // resets the menu selection upon entry to this page:
    function resetMenu() {
        document.gomenu.selector.selectedIndex = 2;
    }
</script>
</body>
</html>
