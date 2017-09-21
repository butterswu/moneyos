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
    <script src="Js/bootstrap-datetimepicker.js"></script>
    <script src="Js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript">
        $(function(){
            var roombuildingid;
            $("#showBuildings").click(function () {
                showbuildings()

            })
            var showbuildings = function () {
                $("#newroomsuccess").hide()
                $("#showBuildings").show();
                var parkid =$("#parkid").val();
                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/ajaxGetBuildingList",
                    data:{"parkid":parkid},
                    dataType:"json",
                    success :function (result) {

                        var buildings =$.parseJSON(result);
                        var building="<button class='newb' type='button'>添加楼宇</button>";

                        $.each(buildings,function (i,item) {
                            building+="<p>"+item.buildingName+"<button buildingid='"+item.id+"' class='sroom' type='button'>查看房间</button></p>"

                        })
                        $("#buildingList").html(building);
                        $("#buildingList").show();

                    }
                })

            }
            var newbuilding=function () {

                $("#newbuilding").show();

            }
            $(".newb").live('click',newbuilding)

            var seerooms=function () {
                
                var buildingid=roombuildingid


                var room=""
                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"<%=basePath%>park/ajaxGetRooms",
                    data:{"id":buildingid},// 你的formid
                    async: false,
                    error: function(request) {
                        alert("Connection error");
                    },
                    success: function(result) {

                        room+=""
                        var roomlist = $.parseJSON(result);
                        var roomlist2 =$.parseJSON(roomlist)

                        $.each(roomlist2,function (i,item) {
                            room+="<p>"+item.roomName+"</p>"
                        })
                        room+="<button type='button' class='newroombt' buildingid='"+buildingid+"'>添加房间</button><button type='button' class='retruntobuildinglist' >返回楼宇列表</button> "
                        $("#buildingList").html(room);
                        $("#showBuildings").hide();
                        $("#newbuilding").hide()
                    }


                })

            }
            $(".sroom").live('click',function () {
               roombuildingid= $(this).attr("buildingid")
                seerooms();

            })
            $("#submitnewbbt").click(function(){
                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"<%=basePath%>park/ajaxNewbuilding",
                    data:{"buildingName":$("#buildingName").val(),"buildingParkId":$("#buildingParkId").val()},// 你的formid
                    async: false,
                    error: function(request) {
                        alert("Connection error");
                    },
                    success: function() {
                        $("#buildingName").val("");
                        $("#newbuilding").hide();
                        $("#newbuildingsuccess").show();
                        showbuildings();
                    }
                });
            });

            $(".retruntobuildinglist").live('click',showbuildings);

            $(".newroombt").live('click',function () {
                roombuildingid=$(this).attr("buildingid");
                $("#newroom").show();
            });
            $("#submitnewrbt").click(function(){
                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"<%=basePath%>park/ajaxNewRoom",
                    data:{"roomName":$("#roomName").val(),"roomBuildingId":roombuildingid},// 你的formid
                        async: false,
                        error: function(request) {
                            alert("Connection error");
                        },
                        success: function() {
                            $("#roomName").val("");
                            $("#newroom").hide();
                            $("#newroomsuccess").show();
                            showbuildings();
                        }
                });
            });






        });
    </script>
</head>
<body>


<!--Header-part-->
<div id="header">
    <h1><a href="dashboard.html">MoneyOS_21</a></h1>
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

<!--start-top-serch-->
<div id="search">

</div>
<!--close-top-serch-->

<!--sidebar-menu-->

<div id="sidebar"> <a href="#" class="visible-phone"><i class="icon icon-th"></i>目录</a>
    <ul>
        <li><a href="pages/index.jsp"><i class="icon icon-home"></i> <span>总览</span></a> </li>

        <li ><a href="<%=basePath%>client/managerlist"><i class="icon icon-th"></i> <span>客户管理</span></a></li>
        <li class="active"> <a href="<%=basePath%>park/parklist"><i class="icon icon-signal"></i> <span>园区管理</span></a> </li>
    </ul>
</div>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb"> <a href="pages/index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>总览</a> <a  title="Go to Home" class="tip-bottom" href="<%=basePath%>client/managerlist"><i class="icon-home"></i> 园区管理</a><a  class="icon-current">园区信息</a>  </div>
        <h1>园区 </h1>
    </div>
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">



                <form id="updatecompany">
                    <div class="modal-header">

                        <h4 class="modal-title">园区详细信息</h4>
                        <h5 id="updatecompanysuccess" align="center" hidden >更新成功</h5>

                    </div>


                    <div class="widget-content nopadding">
                        <div class="control-group">
                            <label class="control-label">园区名称 :</label>


                            <div class="controls">
                                <input type="hidden" class="span4"  id="parkid" value="${park.id}"/>
                                <input type="text" class="span4"  name="comName" value="${park.parkName}"/>
                            </div>

                            <div class="control-group">
                                <label class="control-label">园区位置 :</label>
                                <div class="controls">
                                    <input type="text"  class="span4" value="${park.province}${park.city}${park.area}${park.parkLocation}">
                                </div>
                            </div>
                            <div class="control-group">
                                <h4 class="modal-title">园区楼宇</h4>
                                <label class="control-label">楼宇数 :<p>${park.buildingCount}</p><button type="button" class="btn btn-success" id="showBuildings">查看楼宇</button><hr></label>
                                <h5 id="newbuildingsuccess" align="center" hidden >添加楼宇成功</h5>
                                <h5 id="newroomsuccess" align="center" hidden >添加房间成功</h5>



                                <div class=" clearfix visible-md-block visible-lg-block" hidden id="newbuilding">
                                    <div class="widget-content nopadding">

                                        <form id="submitnewb">

                                            <div class="control-group">
                                                <label class="control-label">新增楼名 :</label>
                                                <div class="controls">
                                                    <input type="hidden" id="buildingParkId" value="${park.id}" >
                                                    <input type="text" class="span11" placeholder="楼名" id="buildingName"/>
                                                </div>
                                            </div>

                                            <div class="form-actions">
                                                <button type="button" class="btn btn-success" id="submitnewbbt" aria-checked="">保存</button>
                                            </div>

                                        </form>
                                    </div>
                                </div>
                                <div class=" clearfix visible-md-block visible-lg-block" hidden id="newroom">
                                    <div class="widget-content nopadding">

                                        <form id="submitnewr">

                                            <div class="control-group">
                                                <label class="control-label">新增房间 :</label>
                                                <div class="controls">
                                                    <input type="hidden" id="roombuildingid"  >
                                                    <input type="text" class="span11" placeholder="房间名" id="roomName"/>
                                                </div>
                                            </div>

                                            <div class="form-actions">
                                                <button type="button" class="btn btn-success" id="submitnewrbt" aria-checked="">保存</button>
                                            </div>

                                        </form>
                                    </div>
                                </div>


                                <div id="buildingList" hidden>



                                </div>

                            </div>
                            <div class="control-group">
                                <h4 class="modal-title">园区入驻公司</h4>

                                <table class="table table-bordered ">
                                    <thead>
                                    <tr>
                                        <th>公司名称</th>
                                        <th>公司详细</th>


                                    </tr>
                                    </thead>
                                    <tbody id="companylisttable">
                                    <c:forEach items="${park.parkCompanyList}" var="company">
                                        <tr>
                                            <td>${company.comName}</td>
                                            <td><form action="<%=basePath%>client/companyinf"><input name="id" type="hidden" value="${company.id}"/><button type="submit">查看详细信息</button></form></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>







                        </div>

                    </div>

                </form>




                <div class="modal-footer">








                </div><!-- /.modal-dialog -->





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



