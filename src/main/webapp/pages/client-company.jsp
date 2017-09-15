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
    <title>Matrix Admin</title>
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
            var companyId=""
            var parkId=""
            var buildinId=""
            var roomId=""
            var newroomcount=0

            $("#b1").click(function(){

                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"<%=basePath%>client/ajaxupdatecompany",
                    data:$('#updatecompany').serialize(),// 你的formid
                    async: false,
                    error: function(request) {
                        alert("Connection error");
                    },
                    success: function(data) {
                        $("#commonLayout_appcreshi").parent().html(data);
                        $("#updatecompanysuccess").show();
                    }
                })

            });
            $("#newroombt").click(function () {
                $("#create").show();
                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/ajaxGetAllPark",
                    dataType:"json",
                    success:function (result) {
                        var parkList=$.parseJSON(result)
                        var parktable="<option>选择园区</option>"
                        $.each(parkList,function (i,item) {

                            parktable+="<option parkid='"+item.id+"'>"+item.parkName+"</option>"

                        })
                        $("#ptable").html(parktable)

                    }
                })


            })
            $("#ptable").change(function () {
                parkId=$("#ptable").find("option:selected").attr("parkid")
                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/ajaxGetBuildingListByParkId",
                    data:{"parkid":parkId},
                    dataType:"json",
                    success:function (result) {
                        var buildingList=$.parseJSON(result)
                        var buildingTable="<option>选择楼宇</option>"
                        $.each(buildingList,function (i,item) {

                            buildingTable+="<option buildingid='"+item.id+"'>"+item.buildingName+"</option>"
                        })
                        $("#btable").html(buildingTable)
                    }
                })

            })
            $("#btable").change(function () {
                buildinId=$("#btable").find("option:selected").attr("buildingid")

                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/ajaxGetRoomListByBuildingId",
                    data:{"id":buildinId},
                    dataType:"json",
                    success:function (result) {
                        var roomList=$.parseJSON(result)
                        var roomTable="<option>选择房间</option>"
                        $.each(roomList,function (i,item) {

                            roomTable+="<option roomid='"+item.id+"'>"+item.roomName+"</option>"
                        })
                        $("#rtable").html(roomTable)
                    }
                })
            })
            $("#rtable").change(function () {
                roomId=$("#rtable").find("option:selected").attr("roomid")
                $("#roomId").val(roomId)


            })
            $("#save").click(function () {

                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/ajaxNewCompanyRoom",
                    data:$("#newpark").serialize(),
                    success:function () {
                        newroomcount+=1
                        $("#newroomcount").html(newroomcount)
                        $("#newparksuccess").show();


                    }
                })

            })


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

        <li class="active"><a href="<%=basePath%>client/managerlist"><i class="icon icon-th"></i> <span>客户管理</span></a></li>
        <li> <a href="<%=basePath%>park/parklist"><i class="icon icon-signal"></i> <span>园区管理</span></a> </li>
        <li><a href="<%=basePath%>user/user"><i class="icon icon-pencil"></i> <span>用户管理</span></a></li>
    </ul>
</div>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb"> <a href="pages/index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>总览</a> <a  title="Go to Home" class="tip-bottom" href="<%=basePath%>client/managerlist"><i class="icon-home"></i> 客户管理</a><a  class="icon-current">公司信息</a>  </div>
        <h1>公司 </h1>
    </div>
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">



                        <form id="updatecompany">
                            <div class="modal-header">

                                <h4 class="modal-title">公司详细信息</h4>
                                <h5 id="updatecompanysuccess" align="center" hidden >更新成功</h5>

                            </div>


                            <div class="widget-content nopadding">
                                    <div class="control-group">
                                        <label class="control-label">公司名称 :</label>

                                        <input type="hidden" name="id" value="${company.id}"name="id">
                                        <div class="controls">
                                            <input type="text" class="span4"  name="comName" value="${company.comName}"/>
                                        </div>

                                    <div class="control-group">
                                        <label class="control-label">计划日期 :</label>
                                        <div class="controls">
                                            <input type="date"  class="span4" name="comTargetDate" value="${company.comTargetDate}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">人数 :</label>
                                        <div class="controls">
                                            <input type="text"  class="span4" placeholder="邮箱" value="${company.comCount}" name="comCount" />
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">企业编号 :</label>
                                        <div class="controls">
                                            <input type="text" class="span4" placeholder="电话"value="${company.comNum}"name="comNum"/>
                                        </div>
                                    </div>

                                   <div class="control-group">
                                      <label class="control-label">公司信息</label>
                                      <div class="controls">
                                        <textarea class="span4" name="comInf">${company.comInf}</textarea>
                                      </div>
                                   </div>




                                    <div class="form-actions">
                                        <button type="button" class="btn btn-success" id="b1">保存</button>
                                    </div>


                            </div>

                            </div>

                        </form>


                            <div>

                                <hr>
                                <h2>位置信息</h2>
                                <button type="button" id="newroombt">添加公司房间</button>
                                <div class=" clearfix visible-md-block visible-lg-block"  id="create" hidden>
                                    <div class="widget-content nopadding">
                                        <h4 id="newparksuccess" align="center" hidden >添加成功<span id="newroomcount"></span>个房间</h4>
                                        <form id="newpark">
                                            <input type="hidden" name="comId" id="companyId" value="${company.id}"/>
                                            <label class="control-label">选择园区:</label>
                                            <select id="ptable"  style="width:150px"  >
                                            </select>
                                            <label class="control-label">选择楼:</label>
                                            <select id="btable"  style="width:150px">
                                            </select>
                                            <label class="control-label">选择房间:</label>
                                            <select id="rtable"  style="width:150px">
                                            </select>
                                            <input type="hidden" class="span11"  name="roomId" id="roomId"/>

                                            <div class="form-actions">
                                                <button type="button" class="btn btn-success" id="save" aria-checked="">添加</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <c:forEach items="${company.companyParkList}" var="park">
                                    <p>${park.province}${park.city}${park.area}${park.parkLocation}${park.parkName}</p>
                                    <hr>
                                        <c:forEach items="${park.parkBuildingList}" var="building">
                                            <p>${building.buildingName}</p>
                                            <c:forEach items="${building.buildingRoomList}" var="room">
                                                <p>${room.roomName}</p>

                                            </c:forEach>

                                        </c:forEach>

                                </c:forEach>
                            </div>

                            <div class="modal-footer">





                <span class="text-muted">所有联系人：</span>

                <div class="widget-content nopadding">
                    <table class="table table-bordered ">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>意向</th>
                            <th>详细</th>

                        </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${company.companyManagerList}" var="manager">

                            <tr class="gradeX">
                                <td>${manager.manName}</td>
                                <td><c:choose><c:when test="${manager.manIntention=='0'}">已签约</c:when><c:when test="${manager.manIntention=='4'}">试用中</c:when><c:when test="${manager.manIntention=='1'}">A</c:when><c:when test="${manager.manIntention=='2'}">B</c:when><c:otherwise>C</c:otherwise></c:choose></td>
                                <td>  <form action="<%=basePath%>client/managerinf">
                                    <input type="hidden" name="id" value="${manager.id}">
                                    <button type="submit" class="btn btn-info" >
                                        查看</button> </form> </td>


                            </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </div>
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



