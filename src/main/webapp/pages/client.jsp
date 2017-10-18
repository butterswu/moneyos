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

    <link rel="stylesheet" href="pages/css/common.css" />
    <link rel="stylesheet" href="pages/css/client.css" />
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
<!--头部导航-->
<div class="header">
    <a class="header_logo" href="/"></a>
</div>
<!--侧导航-->
<div class="sidemenu">
    <ul class="control_sidemenu">
        <li class="main_menu icon_a"><a href="pages/index.jsp">总览</a></li>
        <li class="active_main_menu main_menu icon_b"><a href="<%=basePath%>client/managerlist">客户管理</a></li>
        <li class="main_menu icon_b"><a href="<%=basePath%>park/parklist">园区管理</a></li>
        <li class="main_menu icon_c"><a>权限管理</a></li>
        <ul class="sub_menu_box">
            <li class="sub_menu"><a href="#">人员管理</a></li>
            <li class="sub_menu"><a href="<%=basePath%>business/parkAllocation">园区分配</a></li>
        </ul>
    </ul>
</div>
<!--主体显示-->
<div class="contentbox">
    <div class="keep"></div>
    <div class="control_content">
        <!--头部介绍-->
        <div class="content_introduce">
            <h1>客户管理</h1>
        </div>
        <!--功能区域-->
        <div class="content_main">
            <!--检索区域-->
            <div class="search_box">
                <div class="search_first">
                    <div class="search_first_a">
                        <span>按联系人检索</span><form action="<%=basePath%>client/companyList"><button type="submit" class="" >按公司检索</button></form>
                    </div>
                    <div class="search_first_b">
                        <label class="search_first_b_a">
                            <input type="checkbox" id="i0" class="i s_middle"><span class="s_middle">已签约</span>
                        </label>
                        <label class="search_first_b_b">
                            <input type="checkbox" id="i4" class="i s_middle"><span class="s_middle">试用中</span>
                        </label>
                    </div>
                </div>

                <div class="search_second">
                    <div class="search_second_a">按意向</div>
                    <div class="search_second_b">
                        <label class="bt_search_second_b_a">
                            <input type="checkbox" id="i1" class="i s_middle"><span class="s_middle">A</span>
                        </label>
                        <label class="bt_search_second_b_b">
                            <input type="checkbox" id="i2" class="i s_middle"><span class="s_middle">B</span>
                        </label>
                        <label class="bt_search_second_b_c">
                            <input type="checkbox" id="i3" class="i s_middle"><span class="s_middle">C</span>
                        </label>
                    </div>
                </div>

                <div class="search_third">
                    <div class="search_third_a">
                        <span>按联系人</span><input type="text" id="selectByManager">
                    </div>
                    <div class="search_third_b">
                        <span>按公司名</span><input type="text" id="selectByCompany">
                    </div>
                </div>
            </div>

            <!--添加用户-->
            <button type="button" class="add_bt" id="createbt">添加联系人</button>

            <!--数据显示区域-->
            <div class="data_content">
                <!--显示部分-->
                <div class="main_data_content">
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
                        <tbody id="mananagertable"></tbody>
                    </table>
                </div>
                <!--翻页-->
                <div align="center" id="choosepage" ></div>
            </div>
        </div>
    </div>

    <!--增添数据框-->
    <div class="add_data_box">
        <div class="head_add_data">
            <h1>添加联系人</h1>
            <span class="close_add_data"></span>
        </div>

        <form class="main_add_data" id="newmanager">
            <div class="control_data">
                <label class="title_data">姓名 :</label>
                <div class="write_data">
                    <input type="text" class="span11 write_data_box" name="manName"/>
                </div>
            </div>

            <div class="control_data" id="company">
                <label class="title_data">公司 :</label>
                <div class="write_data">
                    <input type="text" class="span11 write_data_box" id="companyname"/>
                </div>
                    <!--<input type="hidden" name="manComId" value="" id="companyid">-->
            </div>
            <!--公司选择-->
            <div class="choice_company" id="checkresult" hidden></div>

            <div class="control_data">
                <label class="title_data">邮箱 :</label>
                <div class="write_data">
                    <input type="text"  class="span11 write_data_box" name="manEmail" />
                </div>
            </div>

            <div class="control_data">
                <label class="title_data">电话 :</label>
                <div class="write_data">
                    <input type="text" class="span11 write_data_box" name="manTel"/>
                </div>
            </div>

            <div class="control_data">
                <label class="title_data">意向 :</label>
                <div class="write_data" id="manIntent">
                    <div class="order_state">
                        <label for="order_state_a" class="order_state_a">签约</label>
                        <input type="radio" id="order_state_a" value="0" name="state">
                        <label for="order_state_b" class="order_state_b">试用</label>
                        <input type="radio" id="order_state_b" value="4" name="state">
                    </div>

                    <div class="order_level">
                        <label class="order_level_a">
                            <input type="radio" value="1" name="level"><span>A</span>
                        </label>
                        <label class="order_level_b">
                            <input type="radio" value="2" name="level"><span>B</span>
                        </label>
                        <label class="order_level_c">
                            <input type="radio" value="3" name="level"><span>C</span>
                        </label>
                    </div>
                </div>
            </div>
            <!--<input type="hidden" class="span11"  name="manIntention"/>-->

            <button type="button" class="save_data" id="b1" aria-checked="">保存</button>
        </form>
    </div>

</div>

<script src="pages/js/common.js"></script>
</body>
</html>

