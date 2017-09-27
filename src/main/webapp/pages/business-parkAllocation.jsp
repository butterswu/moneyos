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
            var oriPark=new Array();
            var nowPark=new Array();
            var addPark=new Array();
            var cutPark=new Array();
            var userid;
            var getAllSub=function (userList,prename) {
                $.each(userList,function (index,user) {
                    var name=prename+user.userCname;
                    $("#managertable").append("<tr><td>"+name+"</td><td><input type='radio' name='chose' value='"+user.id+"' user_name='"+name+"'></td></tr>")
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
            $("#allocatebutton").click(function () {
                var obj=document.getElementsByName("checkedpark");
                var s="";
                var a=new Array();
                for(var i=0; i<obj.length; i++){
                    if(obj[i].checked) a.push(obj[i].id); //如果选中，将value添加到变量s中
                }
                alert(a)

            })
            var allocateWindow=function () {
                var id=$("input[name='chose']:checked").val();
                userid=id;
                var chosedName=$("input[name='chose']:checked").attr("user_name");
                if(id==null){
                    alert("请选择要进行操作的对象")
                }
                else {
                    $.ajax({
                        type: "POST",
                        url:"<%=basePath%>business/getAllocateWindow",
                        dataType: "json",
                        data:{"id":id},
                        success:function (result) {

                            $("#chosedname").html(chosedName)
                            var parks=$.parseJSON(result)
                            var str1=""
                            var str2=""
                            oriPark=[]
                            $.each(parks.supPark,function (index,sup) {
                                str1+="<tr><td>"+sup.parkName+"</td><td><input type='checkbox' name='avaliablePark' parkid='"+sup.id+"' parkname='"+sup.parkName+"'></td></tr>"
                            })
                            $("#available").html(str1);
                            $.each(parks.thisPark,function (index,item) {
                                oriPark.push(item.id)
                                str2+="<tr><td>"+item.parkName+"</td><td><input type='checkbox' name='chosenPark' parkid='"+item.id+"' parkname='"+item.parkName+"'></td></tr>"
                            })
                            $("#get").html(str2);

                        },
                        error:function () {
                            $("#chosedname").html(chosedName)
                            alert("该对象上级可分配园区为空")
                        }
                    })
                    $("#myModal").modal("show");
                }

            }
            $("#start_allocate").click(function () {
                $("#available").html("");
                $("#get").html("")
                allocateWindow();
            })
            $("#down").click(function () {
                var str=""
                $('input[type="checkbox"][name="avaliablePark"]:checked').each(
                    function() {
                        str+="<tr><td>"+$(this).attr("parkname")+"</td><td><input type='checkbox' name='chosenPark' parkid='"+$(this).attr("parkid")+"' parkname='"+$(this).attr("parkname")+"'></td></tr>"
                        $(this).parent().parent().remove();
                    }
                );
                $("#get").append(str)

            })
            $("#up").click(function () {
                var str=""
                $('input[type="checkbox"][name="chosenPark"]:checked').each(function () {
                    str+="<tr><td>"+$(this).attr("parkname")+"</td><td><input type='checkbox' name='avaliablePark' parkid='"+$(this).attr("parkid")+"' parkname='"+$(this).attr("parkname")+"'></td></tr>"
                    $(this).parent().parent().remove();
                });
                $("#available").append(str)

            })
            $("#saveAllocate").click(function () {
                nowPark=[]
                var a=-1
                $('input[type="checkbox"][name="chosenPark"]').each(function () {
                    nowPark.push(parseInt($(this).attr("parkid")));
                })
                $(nowPark).each(function (index1,now) {
                    if($.inArray(now,oriPark)==a){
                        addPark.push(now)
                    }
                })
                $(oriPark).each(function (index2,ori) {
                    if($.inArray(ori,nowPark)==a){
                        cutPark.push(ori)
                    }
                })
                var addParkJson=JSON.stringify(addPark)
                var cutParkJson=JSON.stringify(cutPark)


                $.ajax({
                    type: "POST",
                    url:"<%=basePath%>business/allocatePark",
                    dataType:"json",
                    data:{"addPark":addParkJson,"cutPark":cutParkJson,"userid":userid},
                    success:function () {
                        alert("修改成功")
                    }
                })
                addPark=[]
                cutPark=[]


            })
        })
    </script>


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

        <li ><a href="pages/index.jsp"><i class="icon icon-home"></i> <span>总览</span></a> </li>

        <li><a href="<%=basePath%>client/managerlist"><i class="icon icon-th"></i> <span>客户管理</span></a></li>
        <li> <a href="<%=basePath%>park/parklist"><i class="icon icon-signal"></i> <span>园区管理</span></a> </li>
        <li class="submenu active"> <a href="#"><i class="icon icon-th-list"></i> <span>权限管理</span> <span class="label label-important"></span></a>
            <ul>
                <li><a href="#">人员管理</a></li>
                <li class="active"><a href="<%=basePath%>business/parkAllocation">园区分配</a></li>
            </ul>
        </li>


    </ul>
</div>
<!--sidebar-menu-->

<!--main-container-part-->
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
            </tr>
            </thead>
            <tbody id="parktable">
            </tbody>
        </table>
    </div>
    <div class="widget-content nopadding">
        <h2>可管理人员</h2>
        <table class="table table-bordered ">
            <thead>
            <tr>
                <th>人员姓名</th>
                <th>选择</th>
            </tr>
            </thead>
            <tbody id="managertable">
            </tbody>
        </table>
    </div>
    <button type="button" class="btn btn-primary" <%--data-toggle="modal" data-target="#myModal"--%> id="start_allocate">
         分配园区
    </button>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">园区分配</h4>
                      </div>

                      <div class="modal-body">
            <div class="row pre-scrollable">
                操作对象:<div id="chosedname">????</div>
            <table class="table table-bordered ">
                <thead>
                <tr>
                    <th>可分配园区</th>
                    <th>选择</th>

                </tr>
                </thead>
                <tbody id="available">
                </tbody>
            </table>
            </div>
            <div>
                <button id="down">↓</button>
                <button id="up">↑</button>
            </div>
            <div class="row pre-scrollable">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>已分配园区</th>
                        <th>选择</th>
                    </tr>
                    </thead>
                    <tbody id="get">
                    </tbody>
                </table>
            </div>
               
                      </div>
                      <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                        <button class="btn btn-primary" type="button" id="saveAllocate">提交</button>
                      </div>
                    </div><!-- /.modal-content -->
                  </div><!-- /.modal-dialog -->
    </div>
</div>
<!--end-main-container-part-->
<!--Footer-part-->
<div class="row-fluid">
    <div id="footer" class="span12"> 2017 &copy; MoneyOS Brought to you by <a href="http://www.kindsaving.cn/"></a>kindsaving.cn</div>
</div>
<!--end-Footer-part-->
</body>
</html>
