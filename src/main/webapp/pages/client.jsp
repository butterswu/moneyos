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
        $(function(){
            var i0=false;
            var i1=false;
            var i2=false;
            var i3=false;
            var i4=false;
            var manager="";
            var company="";
            $("#b1").click(function(){
                var intention = $('#manIntent input:radio:checked').val();
                $("input[name='manIntention']").val(intention)
                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"<%=basePath%>client/ajaxnewmanager",
                    data:$('#newmanager').serialize(),// 你的formid
                    async: false,
                    error: function(request) {
                        alert("Connection error");
                    },
                    success: function(data) {
                        $("#commonLayout_appcreshi").parent().html(data);

                        $("#newmanagersuccess").show();
                    }
                })
            });

            $("#companyname").on('input propertychange',function () {
                var value = $(this).val();
                if (value!="") {
                    $.ajax({
                        type: "POST",
                        url: "<%=basePath%>client/ajaxgetcompanybyname",
                        dataType: "json",
                        data: {"comName": value},
                        success: function (result) {
                            var companyList = $.parseJSON(result);

                            $("#checkresult").show();
                            con = "";
                            $.each(companyList, function (index, item) {
                                con += "<li>公司全名：" + item.comName + "<button type=\"button\" class=\"b2\" value=\""+item.id+" \" name=\""+item.comName+"\">选择</button></li> ";
                            });
                            $("#checkresult").html(con);
                        }
                    })
                }
                else {$("#checkresult").html("");}
            });


            var onBtnClick = function() {
                var id=$(this).val();
                var name = $(this).attr("name");
                $("#companyname").val(name);
                $("#companyid").val(id);
            }
            $(".b2").live('click',onBtnClick);
            $(".i").change(function () {
                if($(this).attr("id")=="i0") {
                    if (i0) {i0 = false} else {i0 = true}
                }
                else if($(this).attr("id")=="i1"){
                    if (i1) {i1 = false} else {i1 = true}
                }
                else if($(this).attr("id")=="i2"){
                    if (i2) {i2 = false} else {i2 = true}
                }
                else if($(this).attr("id")=="i3"){
                    if (i3) {i3 = false} else {i3 = true}
                }
                else {
                    if (i4) {i4 = false} else {i4 = true}
                }
                getmanagerbypage();
            });
            var getmanagerbypage =function (pagenow) {

                $.ajax({
                    type: "POST",
                    url:"<%=basePath%>client/ajaxgetmanager",
                    dataType: "json",
                    data:{"pageNow":pagenow,"i0":i0,"i1":i1,"i2":i2,"i3":i3,"i4":i4,"manager":manager,"company":company},
                    success: function(result) {



                        var page = $.parseJSON(result);

                        var con="";
                        var i="";
                        var url1="<%=basePath%>client/managerinf";
                        var url2="<%=basePath%>client/companyinf";
                        var pinf="";
                        $.each(page.list ,function (i,item) {

                            if(item.manIntention=="0"){i ="已签约";}
                            else if (item.manIntention=="4"){i="试用中"}
                            else if(item.manIntention=="1"){i="A";}
                            else if(item.manIntention=="2"){i="B";}
                            else {i="C";}
                            con+="<tr class=\" gradeX\"><td>"+item.manName+"</td><td>"+item.comName+"</td><td>"+i+"</td><td>"+item.manTel+"</td><td><form action='"+url1+"'><input type='hidden' name='id' value='"+item.id+"'><button type='submit' class='btn btn-info '>查看</button> </form></td><td><form action='"+url2+"'><input type='hidden' name='id' value='"+item.manComId+"'><button type='submit' class='btn btn-danger '>查看</button> </form></td></tr>";
                        })
                       $("#mananagertable").html(con);
                        pinf+="<font size='2'>共"+page.totalPageCount+"页</font><font>共"+page.totalCount+"条记录</font><font size='2'>第"+page.pageNow+"页</font>"

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
                })
            }
            $(document).ready(function(){
                getmanagerbypage();
            });
            var page = function () {
                getmanagerbypage($(this).attr("pagenow"));
            }
            $(".pagenum " ).live('click ',page);
            $("#createbt").click(function () {
                $("#create").show();
            })




            $("#selectByManager").on('input propertychange',function () {
                manager=$(this).val();
                getmanagerbypage();
            });
            $("#selectByCompany").on('input propertychange',function () {

                company=$(this).val();
                getmanagerbypage();
            });



        });
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

        <li class="submenu"> <a href="#"><i class="icon icon-th-list"></i> <span>权限管理</span> <span class="label label-important">2</span></a>
            <ul>
                <li><a href="#">人员管理</a></li>
                <li><a href="<%=basePath%>business/parkAllocation">园区分配</a></li>

            </ul>
        </li>
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
                        <h5>按联系人检索</h5><form action="<%=basePath%>client/companyList"> <button type="submit" class="btn btn-primary" >切换为按公司检索</button></form>
                    </div>

                    <div  data-toggle="buttons">
                        <span>按意向</span>
                        <label class="btn btn-default " >
                            <input type="checkbox" id="i0" class="i">已签约
                        </label>
                        <label class="btn btn-default">
                            <input type="checkbox" id="i4" class="i"> 试用中
                        </label>
                        <label class="btn btn-default">
                            <input type="checkbox" id="i1" class="i"> A
                        </label>
                        <label class="btn btn-default">
                            <input type="checkbox" id="i2" class="i"> B
                        </label>
                        <label class="btn btn-default">
                            <input type="checkbox" id="i3" class="i"> C
                        </label>
                    </div>
                    <span>按联系人</span><input type="text" id="selectByManager"><br>
                    <span>按公司名</span><input type="text" id="selectByCompany">


                    <div class="widget-content nopadding">
                        <table class="table table-bordered ">
                            <thead>
                            <tr>
                                <th>姓名</th>
                                <th>公司</th>
                                <th>意向</th>
                                <th>电话</th>
                                <th>联系人详细</th>
                                <th>公司详细</th>
                            </tr>
                            </thead>
                            <tbody id="mananagertable">
                            </tbody>
                        </table>
                    </div>
                    <div align="center" id="choosepage" >
                        <p>原本</p>
                    </div>
                    <button type="button" class="btn btn-primary" id="createbt">
                        添加联系人
                    </button>
                    <div id="myModal" >
                        <div class=" clearfix visible-md-block visible-lg-block" hidden id="create">
                            <div class="widget-content nopadding">
                                <h4 id="newmanagersuccess" align="center" hidden >添加成功</h4>
                                <form id="newmanager">

                                    <div class="control-group">
                                        <label class="control-label">姓名 :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="姓名" name="manName"/>
                                        </div>
                                    </div>
                                    <div class="control-group" id="company">
                                        <label class="control-label">公司 :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="公司"  id="companyname"/>
                                            <input type="hidden" name="manComId" value="" id="companyid">
                                        </div>
                                        <div id="checkresult" hidden></div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">邮箱 :</label>
                                        <div class="controls">
                                            <input type="text"  class="span11" placeholder="邮箱" name="manEmail" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">电话 :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="电话" name="manTel"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">意向:</label>
                                    </div>
                                        <input type="hidden" class="span11"  name="manIntention"/>
                                        <div class="btn-group" id="manIntent" data-toggle="buttons" >
                                            <label class="btn btn-default">
                                                <input type="radio" class="toggle" value="0"> 签约
                                            </label>
                                            <label class="btn btn-default">
                                                <input type="radio" class="toggle" value="4"> 试用中
                                            </label>
                                            <label class="btn btn-default">
                                                <input type="radio" class="toggle" value="1"> A
                                            </label>
                                            <label class="btn btn-default">
                                                <input type="radio" class="toggle" value="2"> B
                                            </label>
                                            <label class="btn btn-default">
                                                <input type="radio" class="toggle" value="3"> C
                                            </label>
                                        </div>
                                    <div class="form-actions">
                                        <button type="button" class="btn btn-success" id="b1" aria-checked="">保存</button>
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

