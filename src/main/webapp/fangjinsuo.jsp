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
                  var url1="http://120.26.74.199:8080/ucrm/api/exportCallDetails?startTime=2017-10-26%2016:01&endTime=2017-10-27%2000:00&minContactTime=0&apiKey=XIOxUFOeE5BPWZhbmdqaW5zdW89TllZeE49PFQfUCI"
                $.ajax({
                    url: "<%=basePath%>business/get",
                    type: "POST",
                    dataType: "json",
                    data: {"url": url1},
                    success: function (result) {
                        var i = $.parseJSON(result)
                        alert(i.totalCount)
                        $.each(i.results,function () {
                            $.ajax({
                                url: "<%=basePath%>business/save",
                                type: "POST",
                                dataType: "json",
                                data: {"answerTime": this.answerTime,
                                        "callMode":this.callMode,
                                        "callStatus":this.callStatus,
                                        "callType":this.callType,
                                        "callee":this.callee,
                                        "calleeAppType":this.calleeAppType,
                                        "calleeAppVersion":this.calleeAppVersion,
                                        "caller":this.caller,
                                        "callerAppType":this.callerAppType,
                                        "callerAppVersion":this.callerAppVersion,
                                        "deptId":this.deptId,
                                        "deptName":this.deptName,
                                        "duration":this.duration,
                                        "empAccount":this.empAccount,
                                        "empEmail":this.empEmail,
                                        "empId":this.empId,
                                        "empName":this.empName,
                                        "endTime":this.endTime,
                                        "recordId":this.recordId,
                                        "recordingUrl":this.recordingUrl,
                                        "source":this.source,
                                        "startTime":this.startTime,
                                        "totalDuration":this.totalDuration},
                                success:function () {

                                }
                            })
                        })
                    }
                })

            })
            $("#b2").click(function () {
                var userAgentInfo = navigator.userAgent;
                var Agents = ["Android", "iPhone",
                    "SymbianOS", "Windows Phone",
                    "iPad", "iPod"];
                var windows=["Windows"]
                var iphone=["iphone"]
                var tel="0"
                var tel1=$("#num").val();
                if (tel1.length>4){
                    tel+=tel1}
                alert(userAgentInfo)
                if (userAgentInfo.indexOf(windows)){
                    var url="http://localhost:8780/dialout?number="+tel+""
                    $.ajax({
                        type:"post",
                        url:url,
                        success:function (result) {
                            $("#callresult").html(result)
                        }
                    })

                }
                else if (userAgentInfo.indexOf(iphone)){

                }

            })
            $("#aa").click(function () {

                $(".ss").attr("checked",true)

            })
        })


    </script>

</head>


<body>
<a href="http://tool.chinaz.com/Tools/unixtime.aspx" target="_blank">时间戳转换工具</a>
<p>开始时间戳</p>
<input id="start">
<p>结束时间戳</p>
<input id="end">
最小通话时间
<input id="time">
<button id="b1">查询</button>
<button id="aa">sss</button><input type="checkbox" class="ss" id="ssa"><input type="checkbox" class="ss"><input type="checkbox" class="ss">




<br>
<br>

<p>结果</p>
<div id="1">
</div>
<table border="1">
    <thead>
    <tr>
        <th>answerTime</th><th>callMode</th><th>callStatus</th><th>callType</th><th>callType</th><th>callee</th><th>calleeAppType</th><th>calleeAppVersion</th><th>caller</th><th>callerAppType</th><th>deptId</th><th>deptName</th><th>duration</th><th>empAccount</th><th>empEmail</th><th>empId</th><th>empName</th><th>endTime</th><th>recordId</th><th>recordingUrl</th><th>source</th><th>startTime</th><th>totalDuration</th>
    </tr>
    </thead>
    <tbody id="2">
    </tbody>
</table>
<div id="3"></div>
<input id="num">
<button id="b2">拨打</button>
<a href="EZUCPLUSAPP://ezucplus/info?phoneAction=sipDial&phoneNumber=6669">1</a>
<a href="NSURLURLWithString:@'EZPHONEAPP://ezphone/info?phoneAction=sipDial&phoneNumber=6669'">2</a>


</body>
</html>