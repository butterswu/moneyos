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

    <script src="pages/js/jquery.min.js"></script>
    <script src="pages/js/jquery.ui.custom.js"></script>

    <script src="pages/js/jquery.uniform.js"></script>

    <script src="pages/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript">
        $(function () {

            var func =function () {
                alert("funck")

            }
            $("#caonima").click(func)
            $("#aa").change(func)


        })


    </script>
</head>
<body>

<!--Header-part-->


<button type="button"  id="caonima" >草泥马</button>
<select id="aa">
    <option value="0" >选项一</option>
<option value="1" >选项二</option>
</select>


</body>
</html>


