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
            $("#b1").click(function(){
                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"<%=basePath%>client/ajaxupdatemanager",
                    data:$('#updatemanager').serialize(),// 你的formid
                    async: false,
                    error: function(request) {
                        alert("Connection error");
                    },
                    success: function(data) {
                        $("#commonLayout_appcreshi").parent().html(data);
                        $("#updatemanagersuccess").show();
                    }
                })

            });
            $("#b2").click(function () {
                var intention = $("#reintention").val();
                var d = new Date();
                var month =d.getMonth()+1;


                $.ajax({
                    cache: true,
                    type: "POST",
                    url:"<%=basePath%>client/ajaxnewrecord",
                    data:$('#newrecord').serialize(),// 你的formid

                    async: false,

                    error: function(request) {
                        alert("Connection error");
                    },
                    success: function(data) {
                        $("#commonLayout_appcreshi").parent().html(data);
                        $("#newrecordsuccess").show();
                        if(intention=="0"){
                        $("#managerintention").val("已签约");}
                        else if(intention=="4"){
                            $("#managerintention").val("试用中");
                        }
                        else if(intention=="1"){
                            $("#managerintention").val("A");
                        }
                        else if(intention=="2"){
                            $("#managerintention").val("B");
                        }
                        else {
                            $("#managerintention").val("C");
                        }
                        $("#recordtable").prepend("<tr><td>"+$("#managerintention").val()+"</td><td>"+d.getFullYear()+"-"+month+"-"+d.getDate()+" "+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds()+"."+d.getMilliseconds()+"</td><td>"+$("#reinf").val()+"</td>");


                    }
                })

            })
            $("#call").click(function () {
                var userAgentInfo = navigator.userAgent;
                var Agents = ["Android", "iPhone",
                    "SymbianOS", "Windows Phone",
                    "iPad", "iPod"];
                var windows=new RegExp('Windows')

                var iphone=new RegExp('iPhone')
                var andriod=new RegExp('Android')
                var mac=new RegExp('Macintosh')
                var tel="0"
                var tel1=$("#num").val();
                if (tel1.length>4){
                    tel+=tel1}
                else {tel=tel1}

                if (iphone.test(userAgentInfo)){

                    window.open("EZUCPLUSAPP://ezucplus/info?phoneAction=sipDial&phoneNumber="+tel+"");

                }

                else if (windows.test(userAgentInfo)||mac.test(userAgentInfo)){

                    var url="http://localhost:8780/dialout?number="+tel+""
                    $.ajax({
                        type:"post",
                        url:url,
                        success:function (result) {

                        }
                    })

                }

                else if (andriod.test(userAgentInfo)){

                    //window.open("intent:#Intent;action=com.blisscloud.mobile.ezphone.phone;S.phoneAction=sipDial;S.phoneNumber=00912930792;end");
                    window.open("ezucplusapptel:"+tel);
                }

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

<div id="sidebar"> <a href="#" class="visible-phone"><i class="icon icon-th"></i>Tables</a>
    <ul>
        <li><a href="pages/index.jsp"><i class="icon icon-home"></i> <span>总览</span></a> </li>

        <li class="active"><a href="<%=basePath%>client/managerlist"><i class="icon icon-th"></i> <span>客户管理</span></a></li>
        <li> <a href="<%=basePath%>park/parklist"><i class="icon icon-signal"></i> <span>园区管理</span></a> </li>

    </ul>
</div>
<div id="content">
    <div id="content-header">
        <div id="breadcrumb"> <a href="pages/index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i>总览</a> <a href="<%=basePath%>client/managerlist" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> 客户管理</a><a  class="icon-current">联系人信息</a>  </div>
        <h1>联系人
            <form action="<%=basePath%>client/companyinf">  <input type="hidden" name="id" value="${manager.manComId}"><button data-dismiss="modal" class="btn btn-primary" ><span aria-hidden="true"></span><span class="sr-only">转到公司信息</span></button></form></h1>
    </div>
    <div class="container-fluid">
        <hr>
        <div class="row-fluid">
            <div class="span12">

                <div class="modal-dialog">
                    <div class="modal-content">



                        <form id="updatemanager">
                            <div class="modal-header">

                                <h4 class="modal-title">联系人详细信息</h4>
                                <h5 id="updatemanagersuccess" align="center" hidden >更新成功</h5>

                            </div>


                            <div class="widget-content nopadding">
                                <div class="control-group">
                                    <label class="control-label">姓名 :</label>
                                    <input type="hidden" name="id" value="${manager.id}">

                                    <div class="controls">
                                        <input type="text" class="span4"  value="${manager.manName}" name="manName"/>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label">所属公司 :</label>
                                        <div class="controls">
                                            <input type="text"  class="span4" name="comTargetDate" value="${manager.company.comName}" disabled>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">电话号码 :</label>
                                        <div class="controls">
                                            <input type="text"  class="span4" placeholder="邮箱" value="${manager.manTel}" name="manTel" id="tel" /> <button type="button" class="btn btn-success" id="call">拨打</button>
                                            <span id="callresult"></span>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">邮箱 :</label>
                                        <div class="controls">
                                            <input type="text" class="span4" placeholder="电话"value="${manager.manEmail}"name="manEmail"/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">意向 :</label>
                                        <div class="controls">
                                            <input id="managerintention" value="<c:choose><c:when test="${manager.manIntention=='0'}">已签约</c:when><c:when test="${manager.manIntention=='4'}">试用中</c:when><c:when test="${manager.manIntention=='1'}">A</c:when><c:when test="${manager.manIntention=='2'}">B</c:when><c:otherwise>C</c:otherwise></c:choose>" disabled>
                                        </div>
                                    </div>






                                    <div class="form-actions">
                                        <button type="button" class="btn btn-success" id="b1">保存</button>
                                    </div>


                                </div>

                            </div>

                        </form>

                        <form id="newrecord">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h4 class="modal-title">添加追踪记录</h4>
                                        <h5 id="newrecordsuccess" align="center" hidden >更新成功</h5>
                                    </div>

                                    <div class="modal-body">
                                        <p>追踪信息</p>
                                        <textarea class="form-control" name="reInf" id="reinf"></textarea>
                                        <input type="hidden" name="id" value="${manager.id}">
                                        <input type="hidden" name="reManId" value="${manager.id}">
                                    </div>

                                </div>
                                &nbsp;&nbsp;<select style="max-width:70px" name="reIntention" id="reintention">
                                <option value="1">A</option>
                                <option value="2">B</option>
                                <option value="3">C</option>
                                <option value="4">试用</option>
                                <option value="0">签约</option></select>
                                <div class="modal-footer">

                                    <button class="btn btn-primary" type="button" id="b2">提交</button>
                                </div>

                            </div><!-- /.modal-content -->
                        </form>






                <div class="widget-content nopadding">
                    <table class="table table-bordered " >
                        <thead>
                        <tr>
                            <th>意向</th>
                            <th>时间</th>
                            <th>记录</th>

                        </tr>
                        </thead>
                        <tbody id="recordtable">
                        <c:forEach items="${recordList}" var="record">

                            <tr class="gradeX">
                                <td><c:choose><c:when test="${record.reIntention=='0'}">已签约</c:when>
                                    <c:when test="${record.reIntention=='4'}">试用中</c:when>
                                    <c:when test="${record.reIntention=='1'}">A</c:when>
                                    <c:when test="${record.reIntention=='2'}">B</c:when>
                                    <c:otherwise>C</c:otherwise>

                                </c:choose></td>
                                <td>${record.reTime}</td>
                                <td>${record.reInf}</td>


                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
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


