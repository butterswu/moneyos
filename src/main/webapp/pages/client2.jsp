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
<%--    <script src="pages/js/matrix.js"></script>
    <script src="pages/js/matrix.tables.js"></script>--%>
    <script type="text/javascript">
        $(function () {
            var company=""
            var manager=""
            $(document).ready(function(){
                getcompanybypage()
                getselpark()
            });
            var getcompanybypage = function (pagenow) {

                $.ajax({
                    type:"POST",
                    url:"<%=basePath%>client/ajaxgetCompanyByPage",
                    dataType:"json",
                    data:{"pageNow":pagenow,"companyName":company,"managername":manager},

                    success:function (result) {


                        var page = $.parseJSON(result);
                        if(page==null){

                            $("#companytable").html("");
                            $("#choosepage").html("");}
                            else {
                            var url2 = "<%=basePath%>client/companyinf";
                            var pinf = "";
                            var table = "";
                            $.each(page.list, function (i, item) {
                                var parklist = ""
                                var manlist=""
                                var url = "<%=basePath%>park/parkinf"
                                var url2="<%=basePath%>client/managerinf"
                                $.each(item.companyParkList, function (p, pitem) {
                                    parklist += "<form action='" + url + "'><span>" + pitem.parkName + "</span><input type='hidden' name='id' value='" + pitem.id + "'/><button type='submit'>查看</button></form>"

                                })
                                $.each(item.companyManagerList, function (p, mitem) {
                                    manlist += "<form action='" + url2 + "'><span>" + mitem.manName + "</span><input type='hidden' name='id' value='" + mitem.id + "'/><button type='submit'>查看</button></form>"

                                })

                                table += "<tr class=\" gradeX\"><td>" + item.comName + "</td><td>" + parklist +"</td><td>"+manlist+ "</td><td>" + item.comCount + "</td><td><form action='" + url2 + "'><input type='hidden' name='id' value='" + item.id + "'><button type='submit' class='btn btn-danger '>查看</button> </form></td></tr>";

                            })
                            $("#companytable").html(table);
                            pinf+="<font size='2'>共"+page.totalPageCount+"页</font><font>共"+page.totalCount+"条记录</font><font size='2'>第"+page.pageNow+"页</font>"
                            if (page.pageNow == 1) {
                                if (page.totalPageCount == 2) {
                                    pinf += "<button class='pagenum' pagenow='2'>尾页</button>";
                                }
                                else if (page.totalPageCount == 1) {
                                }
                                else {
                                    pinf += "<button class='pagenum' pagenow='2'>下一页</button><button class='pagenum' pagenow='" + page.totalPageCount + "'>尾页</button> ";
                                }
                            }
                            else if (page.totalPageCount == page.pageNow && page.pageNow == 2) {
                                pinf += "<button class='pagenum' pagenow='1'>首页</button>"
                            }
                            else if (page.totalPageCount == page.pageNow) {
                                var pagebefore = parseInt(page.pageNow) - 1;
                                pinf += "<button class='pagenum' pagenow='1'>首页</button><button class='pagenum' pagenow='" + pagebefore + "'>上一页</button> "
                            }
                            else if (page.pageNow + 1 == page.totalPageCount) {
                                var pagebefore = parseInt(page.pageNow) - 1;
                                pinf += "<button class='pagenum' pagenow='1'>首页</button><button class='pagenum' pagenow='" + pagebefore + "'>上一页</button><button class='pagenum' pagenow='" + page.totalPageCount + "'>尾页</button> "
                            }
                            else {
                                var pageafter = parseInt(page.pageNow) + 1;
                                var pagebefore = parseInt(page.pageNow) - 1;
                                pinf += "<button class='pagenum' pagenow='1'>首页</button><button class='pagenum' pagenow='" + pagebefore + "'>上一页</button><button class='pagenum' pagenow='" + pageafter + "'>下一页</button> <button class='pagenum' pagenow='" + page.totalPageCount + "'>尾页</button> "

                            }
                            $("#choosepage").html(pinf);
                        }
                    },



                    }


                )
            }
            $("#selectByManager").on('input propertychange',function () {
                manager=$(this).val();
                getcompanybypage();
            });
            $("#selectByCompany").on('input propertychange',function () {

                company=$(this).val();
                getcompanybypage();
            });
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
            var getselpark=function () {
                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/getAllNameId",
                    success: function (result) {
                        var str=""
                        var park=$.parseJSON(result)
                        park=$.parseJSON(park)
                        $.each(park ,function (i,item) {
                            str+="<tr pid='"+item.id+"'><td>"+item.parkName+"</td><td><input type='checkbox' class='allPark' value='1'></td></tr>"

                        })
                        $("#selPark").html(str)

                    }
                })
            }
            var choosePark=function (parkId) {
                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/ajaxGetBuildingListByParkId",
                    data:{"parkid":parkId},

                    success:function (result) {
                        /*$("#selRoom").html("")*/
                        var str=""
                        var buildinglist=$.parseJSON(result)
                        buildinglist=$.parseJSON(buildinglist)
                        $.each(buildinglist,function (i,item) {
                            str+="<tr bid='"+item.id+"'><td class='parkTd'>"+item.buildingName+"</td><td><input type='checkbox' class='allBuilding'></td></tr>"

                        })
                        $("#selBuilding").html(str)
                    }
                })

            }

            $("#selPark tr").live('click',function () {

                    choosePark($(this).attr("pid"))
            })
            var chooseBuilding=function (buildingId) {
                $.ajax({
                    type:"post",
                    url:"<%=basePath%>park/ajaxGetRoomListByBuildingId",
                    data:{"id":buildingId},
                    success:function (result) {
                        var roomList=$.parseJSON(result)
                        roomList=$.parseJSON(roomList)
                        var str=""
                        $.each(roomList,function (i,item) {
                            str+="<tr rid='"+item.id+"'><td>"+item.roomName+"</td><td><input type='checkbox' class='allRoom'></td></tr>"
                        })
                        $("#selRoom").html(str)
                    }

                })
            }
            $("#selBuilding tr").live('click',function () {

                chooseBuilding($(this).attr("bid"))
            })
            $(".allBuilding").live('click',function () {


            })
            var checkAll=function () {
                $(".allBuilding").attr("checked",true)
                $(".allRoom").attr("checked",true)
                e.stopPropagation();
            }
            $(".allPark").live('click',function (e) {
                var pid=$(this).parent().parent().attr("pid")
                if ($(this).is(':checked')){
                    /*choosePark(pid)*/
                    checkAll()
                }
                e.stopPropagation();

            })
            $("#aa").click(function () {
                $.each($(".ss"),function (i,item) {
                    $(item).attr("checked","checked")
                })
                /*$(".ss").attr("checked",true)*/

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
                        <h5>按单位检索</h5><form action="<%=basePath%>client/managerlist"> <button type="submit" class="btn btn-primary" >切换为按联系人检索</button></form>
                    </div>
                    <span>检索条件</span><br>
                    <span>联系人</span><input type="text" id="selectByManager"><br>
                    <span>单位名</span><input type="text" id="selectByCompany"><br>
                    <span>区位条件</span><button id="aa">sss</button><input type="checkbox" class="ss" id="ssa" value="22" checked=""><input type="checkbox" class="ss" value="11"><input type="checkbox" class="ss" value="33">
                    <table class="table table-bordered ">

                        <tr>

                            <td><table class="table table-bordered ">
                                <thead>
                                <tr>
                                    <th>园区名称 </th>
                                    <th>全选园区</th>

                                </tr>
                                </thead>
                                <tbody id="selPark">

                                </tbody>

                            </table></td>

                            <td><table class="table table-bordered ">
                                <thead>
                                <tr>
                                    <th>楼宇名称</th>
                                    <th>全选楼宇</th>
                                </tr>
                                </thead>
                                <tbody id="selBuilding">

                                </tbody>
                            </table></td>
                            <td><table class="table table-bordered ">
                                <thead>
                                <tr>
                                    <th>房间名称</th>
                                    <th>选择房间</th>
                                </tr>
                                </thead>
                                <tbody id="selRoom">

                                </tbody>
                            </table></td>
                        </tr>

                    </table>




                    <div class="widget-content nopadding">
                        <table class="table table-bordered ">
                            <thead>
                            <tr>
                                <th>单位全称</th>
                                <th>单位所在园区</th>
                                <th>下属联系人</th>
                                <th>单位人数</th>
                                <th>单位详细信息</th>

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
                        添加单位
                    </button>
                    <div id="myModal" >
                        <div class=" clearfix visible-md-block visible-lg-block" hidden id="create">
                            <div class="widget-content nopadding">
                                <h4 id="newcompanysuccess" align="center" hidden >添加成功</h4>
                                <form id="newcompany">

                                    <div class="control-group">
                                        <label class="control-label">单位全称 :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="单位名称" name="comName"/>
                                        </div>
                                    </div>
                                    <div class="control-group" id="company">
                                        <label class="control-label">单位人数 :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="单位人数"  name="comCount"/>
                                           
                                        </div>

                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">企业编号 :</label>
                                        <div class="controls">
                                            <input type="text"  class="span11" placeholder="企业编号" name="comNum" />
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label">单位信息:</label>
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

