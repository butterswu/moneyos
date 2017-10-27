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
    <link rel="stylesheet" href="pages/css/uniform.css" />
    <link rel="stylesheet" href="pages/css/select2.css" />
    <link rel="stylesheet" href="pages/css/matrix-style.css" />
    <link rel="stylesheet" href="pages/css/matrix-media.css" />
    <link href="pages/font-awesome/css/font-awesome.css" rel="stylesheet" />

    <link rel="stylesheet" href="pages/css/common.css" />
    <script src="pages/js/jquery.min.js"></script>
    <script src="pages/js/jquery.ui.custom.js"></script>
    <script src="pages/js/bootstrap.min.js"></script>
    <script src="pages/js/jquery.uniform.js"></script>
    <script src="pages/js/select2.min.js"></script>
    <script src="pages/js/jquery.dataTables.min.js"></script>
    <script src="pages/js/matrix.js"></script>
    <script src="pages/js/matrix.tables.js"></script>
    <script type="text/javascript">
        $(function (){
            var a =1
            var getAllSub=function (userList,prename) {
                $.each(userList,function (index,user) {
                    var name=prename+user.userCname;
                    $("#managertable").append("<tr><td>"+name+"</td></tr>")
                    getAllSub(user.subordinate,name)
                })
            }
            var getControlledParkList=function () {
                $.ajax({
                    type: "POST",
                    url:"<%=basePath%>business/getControlledParkList",
                    dataType: "json",
                    success:function (result) {
                        var tableinf="";
                        var parkList=$.parseJSON(result);

                        $.each(parkList,function (index,item) {
                            tableinf+="<tr><td>"+item.parkName+"</td></tr>"

                        })
                        $("#parktable").html(tableinf);
                    }
                })

            }
            var getSubList=function () {
                $.ajax({
                    type: "POST",
                    url:"<%=basePath%>business/getSalesmanSubList",
                    dataType: "json",
                    success:function (result) {
                        if (result=="none"){
                        }
                        else {
                            var userList=$.parseJSON(result);
                            var name=""
                            getAllSub(userList,name);
                        }
                    }
                })
            }

            $(document).ready(function(){
                getControlledParkList();
                getSubList();

            });

        })
    </script>


</head>
<body>
<!--头部导航-->
<div class="header">
    <a class="header_logo" href="/"></a>
</div>
<!--侧导航-->
<div class="sidemenu">
    <ul class="control_sidemenu">
        <li class="main_menu icon_a"><a href="pages/index.jsp">总览</a></li>
        <li class="main_menu icon_b"><a href="<%=basePath%>client/managerlist">客户管理</a></li>
        <li class="main_menu icon_b"><a href="<%=basePath%>park/parklist">园区管理</a></li>
        <li class="active_main_menu main_menu icon_c"><a>权限管理</a></li>
            <ul class="sub_menu_box sub_menu_box_s">
                <li class="sub_menu"><a href="#">人员管理</a></li>
                <li class="active_sub_menu sub_menu"><a href="<%=basePath%>business/parkAllocation">园区分配</a></li>
            </ul>
    </ul>
</div>
<div id="content">
    <!--breadcrumbs-->
    <div id="content-header">
        <div id="breadcrumb"> <a href="pages/index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>总览</a> <a href="<%=basePath%>business/parkAllocation" class="icon-home">园区分配</a> </div>
        <h1>园区分配</h1>
    </div>
    <!--End-breadcrumbs-->
    <div class="widget-content nopadding">
        <h2>可管理园区</h2>
        <table class="table table-bordered ">
            <thead>
            <tr>
                <th>园区名称</th>
                <th>园区详细</th>
            </tr>
            </thead>
            <tbody id="parktable">
            </tbody>
        </table><button type="button">分配园区</button>
    </div>
    <div class="widget-content nopadding">
        <h2>可管理人员</h2>
        <table class="table table-bordered ">
            <thead>
            <tr>
                <th>人员姓名</th>
                <th>所管理园区</th>
                <th>下级信息</th>
                <th>分配园区</th>
            </tr>
            </thead>
            <tbody id="managertable">
            </tbody>
        </table>
    </div>
</div>

<script src="pages/js/common.js"></script>
</body>
</html>
