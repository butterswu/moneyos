<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: wuenze
  Date: 2017/7/25
  Time: 下午4:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    <script src="pages/js/jquery.min.js"></script>
    <script src="pages/js/jquery.ui.custom.js"></script>
    <script src="pages/js/bootstrap.min.js"></script>
    <script src="pages/js/jquery.uniform.js"></script>
    <script src="pages/js/select2.min.js"></script>
    <script src="pages/js/jquery.dataTables.min.js"></script>
    <script src="pages/js/matrix.js"></script>
    <script src="pages/js/matrix.tables.js"></script>
    <script type="text/javascript">
        $(function () {

            $(document).ready(function(){
                getcompanybypage()
            });
            var getcompanybypage = function (pagenow) {

                $.ajax({
                    type:"POST",
                    url:"<%=basePath%>client/ajaxgetCompanyByPage",
                    dataType:"json",
                    data:{"pageNow":pagenow},

                    success:function (result) {


                        var page = $.parseJSON(result);
                        var url2="<%=basePath%>client/companyinf";
                        var pinf="";
                        var table="";
                        $.each(page.list ,function (i,item) {
                            var parklist=""
                            var url="<%=basePath%>park/parkinf"
                            $.each(item.companyParkList,function (p,pitem) {
                                parklist+="<form action='"+url+"'><span>"+pitem.parkName+"</span><input type='hidden' name='id' value='"+pitem.id+"'/><button type='submit'>查看</button></form>"

                            })
                            table+="<tr class=\" gradeX\"><td>"+item.comName+"</td><td>"+parklist+"</td><td>"+item.comCount+"</td><td><form action='"+url2+"'><input type='hidden' name='id' value='"+item.id+"'><button type='submit' class='btn btn-danger '>查看</button> </form></td></tr>";

                        })
                        $("#companytable").html(table);
                        pinf+="<font size='2'>共"+page.totalPageCount+"页</font><font size='2'>第"+page.pageNow+"页</font>"

                        if (page.pageNow==1){
                            if (page.totalPageCount==2){
                                pinf+="<button class='pagenum' pagenow='2'>尾页</button>";
                            }
                            else if(page.totalPageCount==1){}
                            else {
                                pinf+="<button class='pagenum' pagenow='2'>下一页</button><button class='pagenum' pagenow='"+page.totalPageCount+"'>尾页</button> ";
                            }
                        }
                        else if(page.totalPageCount==page.pageNow&&page.pageNow==2){
                            pinf+="<button class='pagenum' pagenow='1'>首页</button>"
                        }
                        else if(page.totalPageCount==page.pageNow){
                            var pagebefore=parseInt(page.pageNow)-1;
                            pinf+="<button class='pagenum' pagenow='1'>首页</button><button class='pagenum' pagenow='"+pagebefore+"'>上一页</button> "
                        }
                        else if(page.pageNow+1==page.totalPageCount){
                            var pagebefore=parseInt(page.pageNow)-1;
                            pinf+="<button class='pagenum' pagenow='1'>首页</button><button class='pagenum' pagenow='"+pagebefore+"'>上一页</button><button class='pagenum' pagenow='"+page.totalPageCount+"'>尾页</button> "
                        }
                        else {
                            var pageafter=parseInt(page.pageNow)+1;
                            var pagebefore=parseInt(page.pageNow)-1;
                            pinf+="<button class='pagenum' pagenow='1'>首页</button><button class='pagenum' pagenow='"+pagebefore+"'>上一页</button><button class='pagenum' pagenow='"+pageafter+"'>下一页</button> <button class='pagenum' pagenow='"+page.totalPageCount+"'>尾页</button> "

                        }
                        $("#choosepage").html(pinf);
                    }

                    }


                )
            }
            var page = function () {
                getcompanybypage($(this).attr("pagenow"));
            }
            $(".pagenum " ).live('click ',page);
            $("#createbt").click(function () {
                $("#create").show();
            })
            $("#save").click(function () {
                $.ajax({
                    type:"post",
                    url:"<%=basePath%>client/newcompany",
                    data:$("#newcompany").serialize(),
                    success: function () {

                        $("#newcompanysuccess").show();
                    }
                })

            })

        })

    </script>
</head>
<body>

<!--Header-part-->
<div id="header">
    <h1><a href="dashboard.html">MoneyOS_2</a></h1></div>

<!--close-Header-part-->

<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
    <ul class="nav">
        <ul class="dropdown-menu">
        </ul>
    </ul>
</div>

<!--start-top-serch-->

<!--close-top-serch-->

<!--sidebar-menu-->

<div id="sidebar"> <a href="#" class="visible-phone"><i class="icon icon-th"></i>Tables</a>
    <ul>
        <li><a href="pages/index.jsp"><i class="icon icon-home"></i> <span>总览</span></a> </li>

        <li class="active"><a href="<%=basePath%>client/managerlist"><i class="icon icon-th"></i> <span>客户管理</span></a></li>
        <li> <a href="<%=basePath%>park/parklist"><i class="icon icon-signal"></i> <span>园区管理</span></a> </li>
 </ul>
</div>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb"> <a href="pages/index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>总览</a> <a href="<%=basePath%>client/managerlist" class="icon-home">客户管理</a> </div>
        <h1>客户管理</h1>
    </div>
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">


                    <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                        <h5>按公司检索</h5><form action="<%=basePath%>client/managerlist"> <button type="submit" class="btn btn-primary" >切换为按联系人检索</button></form>
                    </div>




                    <div class="widget-content nopadding">
                        <table class="table table-bordered ">
                            <thead>
                            <tr>
                                <th>公司全称</th>
                                <th>公司所在园区</th>
                                <th>公司人数</th>
                                <th>公司详细信息</th>

                            </tr>
                            </thead>
                            <tbody id="companytable">
                            </tbody>
                        </table>
                    </div>
                    <div align="center" id="choosepage" >
                        <p>原本</p>
                    </div>
                    <button type="button" class="btn btn-primary" id="createbt">
                        添加公司
                    </button>
                    <div id="myModal" >
                        <div class=" clearfix visible-md-block visible-lg-block" hidden id="create">
                            <div class="widget-content nopadding">
                                <h4 id="newcompanysuccess" align="center" hidden >添加成功</h4>
                                <form id="newcompany">

                                    <div class="control-group">
                                        <label class="control-label">公司全称 :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="公司名称" name="comName"/>
                                        </div>
                                    </div>
                                    <div class="control-group" id="company">
                                        <label class="control-label">公司人数 :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="公司人数"  name="comCount"/>
                                           
                                        </div>

                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">企业编号 :</label>
                                        <div class="controls">
                                            <input type="text"  class="span11" placeholder="企业编号" name="comNum" />
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label">公司信息:</label>
                                        <textarea class="span4" name="comInf"></textarea>
                                    </div>
                                    <input type="hidden" class="span11"  name="comInf"/>

                                    <div class="form-actions">
                                        <button type="button" class="btn btn-success" id="save" aria-checked="">保存</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--Footer-part-->
<div class="row-fluid">
    <div id="footer" class="span12"> 2017 &copy; MoneyOS. Brought to you by <a href="http://www.kindsaving.cn/">kindsaving.cn</a> </div>
</div>
<!--end-Footer-part-->


</body>
</html>

