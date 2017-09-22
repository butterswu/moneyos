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
        $(function () {
            var provinceID;
            var cityID;
            var areaID;
            $(document).ready(function () {
                getparklist()



            })
            var getparklist = function (pageNow) {
                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/ajaxParkList",
                    data:{"pageNow":pageNow},
                    dataType:"json",
                    success:function (result) {
                        var page =$.parseJSON(result)
                        var table="";
                        var pagenun="";
                        var pinf="";

                        var url="<%=basePath%>park/parkinf"
                        $.each(page.list,function (i,item) {
                            var location=""
                            location+=""+item.province+""+item.city+""+item.area+"";
                            table+="<tr class=\" gradeX\"><td>"+item.parkName+"</td><td>"+location+"</td><td>"+item.parkLocation+"</td><td><form action='"+url+"'><input type='hidden' name='id' value='"+item.id+"'><button type='submit' class='btn btn-danger '>查看</button> </form></td></tr>";


                        })
                        $("#parktable").html(table)
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
                })
            }

            $(".pagenum").live('click',function () {
                getparklist($(this).attr("pagenow"))

            })
            $("#createbt").click(function () {
                $("#create").show();
                $.ajax({
                    type:"POST",
                    url:"<%=basePath%>park/ajaxGetAllProvince",
                    dataType:"json",
                    success:function (result) {
                        var provincetable="<option >选择省</option>"
                        var provincelist =$.parseJSON(result)
                        $.each(provincelist,function (i,item) {
                            provincetable+="<option p='"+item.provinceID+"'>"+item.province+"</option>"

                        })
                        $("#ptable").html(provincetable)
                    }
                })

            })
            function provincechange() {
                provinceID = $('select  option:selected').attr("p");
                $.ajax({
                    type:"POST",
                    data:{"father":provinceID},
                    url:"<%=basePath%>park/ajaxGetCityListByProvinceID",
                    dataType:"json",
                    success:function (result) {
                        var citytable="<option>选择城市</option>";
                        var citylist=$.parseJSON(result)
                        $.each(citylist,function (i,item) {

                            citytable+="<option name='"+item.cityID+"'>"+item.city+"</option>"

                        })
                        $("#ctable").html(citytable);
                    }
                })

            }
            $("#ptable").change(provincechange)
            function citychange() {
                cityID= $("#ctable").find("option:selected").attr("name");
                $.ajax({
                    type:"POST",
                    data:{"father":cityID},
                    url:"<%=basePath%>park/ajaxGetAreaListByCityID",
                    dataType:"json",
                    success:function (result) {

                        var areatable="<option >选择区县</option>";
                        var arealist=$.parseJSON(result)
                        $.each(arealist,function (i,item) {

                            areatable+="<option name='"+item.areaID+"'>"+item.area+"</option>"

                        })
                        $("#atable").html(areatable);
                    }
                })


            }
            $("#ctable").change(citychange);
            function areachange() {
                areaID=$("#atable").find("option:selected").attr("name");
                $("#parkAreaID").val(areaID);

            }
            $("#atable").change(areachange)
            $("#save").click(function () {
                var str =$('#newpark').serialize();
                $.ajax({
                    type:"POST",
                    url:"<%=basePath%>park/ajaxNewPark",
                    data:$('#newpark').serialize(),
                    success:function () {
                        $("#newparksuccess").show();
                        $("#pname").val("")
                        $("#plocation").val("")



                    }
                })


            })


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
        <li class="active_main_menu main_menu icon_b"><a href="<%=basePath%>park/parklist">园区管理</a></li>
        <li class="main_menu icon_c"><a>权限管理</a></li>
        <ul class="sub_menu_box"">
            <li class="sub_menu"><a href="#">人员管理</a></li>
            <li class="sub_menu"><a href="<%=basePath%>business/parkAllocation">园区分配</a></li>
        </ul>
    </ul>
</div>
<!--主体显示-->
<div class="contentbox">
    <div id="content-s" class="maincontent">
        <div id="content-header">
            <div id="breadcrumb"> <a href="pages/index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>总览</a> <a href="<%=basePath%>park/parklist" class="icon-home">楼盘管理</a> </div>
            <h1>园区管理</h1>
        </div>
        <div class="container-fluid">
            <hr>
            <div class="row-fluid">
                <div class="span12">
                    <div class="widget-box">


                        <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>

                        </div>




                        <div class="widget-content nopadding">
                            <table class="table table-bordered ">
                                <thead>
                                <tr>
                                    <th>园区全称</th>
                                    <th>园区地区</th>
                                    <th>园区地址</th>
                                    <th>园区详细信息</th>

                                </tr>
                                </thead>
                                <tbody id="parktable">
                                </tbody>
                            </table>
                        </div>
                        <div align="center" id="choosepage" >
                            <p>原本</p>
                        </div>
                        <button type="button" class="btn btn-primary" id="createbt">
                            添加园区
                        </button>
                        <div id="myModal" >
                            <div class=" clearfix visible-md-block visible-lg-block" hidden id="create">
                                <div class="widget-content nopadding">
                                    <h4 id="newparksuccess" align="center" hidden >添加成功</h4>
                                    <form id="newpark">
                                        <input type="hidden" name="parkAreaID" id="parkAreaID"/>

                                        <div class="control-group">
                                            <label class="control-label">园区名称 :</label>
                                            <div class="controls">
                                                <input type="text" class="span11" placeholder="园区名称" name="parkName" id="pname"/>
                                            </div>
                                        </div>


                                        <label class="control-label">选择省:</label>
                                        <select id="ptable"  style="width:150px"  >

                                        </select>
                                        <label class="control-label">选择市:</label>
                                        <select id="ctable"  style="width:150px">

                                        </select>
                                        <label class="control-label">选择区:</label>
                                        <select id="atable"  style="width:150px">

                                        </select>
                                        <div class="control-group">
                                            <label class="control-label">园区地址  :</label>
                                            <div class="controls">
                                                <input type="text"  class="span11" placeholder="园区地址" name="parkLocation" id="plocation" />
                                            </div>
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
</div>

<script src="pages/js/common.js"></script>
</body>
</html>


