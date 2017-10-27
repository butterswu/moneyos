<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>

<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    %>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="pages/tree/lay/css/layui.css" />
    <style type="text/css">
        body{
            height: 1200px;
        }
        #demo{
            margin: 30px 100px;
        }
        .descripttion{
            width: 1000px;
            margin: 50px;
        }
        body>ul{
            display: inline-block;
            width: 400px;
            margin: 20px;
        }
    </style>

    <script src="pages/tree/layui.js" charset="utf-8"></script>
    <script>
        layui.use('tree', function() {
            var tree = layui.tree({
                elem: '#demo', //指定元素，生成的树放到哪个元素上
                check: 'checkbox', //勾选风格
                skin: 'as', //设定皮肤
                drag: true,//点击每一项时是否生成提示信息
                checkboxName: 'aa[]',//复选框的name属性值
                checkboxStyle: "",//设置复选框的样式，必须为字符串，css样式怎么写就怎么写
                click: function(item) { //点击节点回调
                    console.log("item")
                },
                onchange: function (){//当当前input发生变化后所执行的回调
                    console.log(this);
                },
                nodes: [ //节点
                    {
                        name: '常用文件夹', //节点名称
                        //	spread: true, //是否是展开状态，true为展开状态
                        href: "http://www.baidu.com",//设置节点跳转的链接，如果不设置则不会跳转
                        target: "_self",//节点链接打开方式
                        alias: 'changyong',
                        data: {//为元素添加额外数据，即在元素上添加data-xxx="yyy"，可选
                            nodeName: "常用文件夹",
                            alias: "changyong"
                        },
                        checkboxValue: 1,//复选框的值
                        checked: true,//复选框默认是否选中
                        children: [{
                            name: '所有未读',
                            alias: 'weidu',
                            checked: true,
                            checkboxValue: 2
                        }, {
                            name: '置顶邮件',
                        }, {
                            name: '标签邮件',
                            checked: false,
                            checkboxValue: 3
                        }]
                    }, {
                        name: '我的邮箱',
                        checked: true,
                        spread: true,
                        data: {
                            nodeName: "我的邮箱",
                            alias: "email"
                        },
                        children: [{
                            name: 'QQ邮箱',
                            checked: true,
                            checkboxValue: 4,
                            spread: true,
                            children: [{
                                name: '收件箱',
                                checked: false,
                                checkboxValue: 5,
                                children: [{
                                    name: '所有未读',
                                    checked: false,
                                    checkboxValue: 6,
                                    children: [{
                                        name: '一周未读',
                                        checked: false,
                                        checkboxValue: 6
                                    }]
                                }, {
                                    name: '置顶邮件',
                                    checked: false,
                                    checkboxValue: 7
                                }, {
                                    name: '标签邮件',
                                    checked: false,
                                    checkboxValue: 8
                                }]
                            }, {
                                name: '已发出的邮件',
                                checked: false,
                                checkboxValue: 9
                            }, {
                                name: '垃圾邮件',
                                checked: false,
                                checkboxValue: 10
                            }]
                        }, {
                            name: '阿里云邮',
                            checked: true,
                            checkboxValue: 11,
                            children: [{
                                name: '收件箱',
                                checked: true,
                                checkboxValue: 12
                            }, {
                                name: '已发出的邮件',
                                checked: true,
                                checkboxValue: 13
                            }, {
                                name: '垃圾邮件',
                                checked: true,
                                checkboxValue: 14
                            }]
                        }]
                    }
                ]
            });


            /*第二课树延时一会，在本地由于数据不多可能没什么效果*/
            var tree2 = null;
            setTimeout(function (){
                tree2 = layui.tree({
                    elem: '#demo1', //指定元素，生成的树放到哪个元素上
                    //check: 'checkbox', //勾选风格
                    skin: 'as', //设定皮肤
                    drag: true,//点击每一项时是否生成提示信息
                    checkboxName: 'aa[]',//复选框的name属性值
                    checkboxStyle: "",//设置复选框的样式，必须为字符串，css样式怎么写就怎么写
                    click: function(item) { //点击节点回调
                        console.log(item)
                    },
                    nodes: [ //节点
                        {
                            name: '常用文件夹', //节点名称
                            //	spread: true, //是否是展开状态，true为展开状态
                            href: "http://www.jq22.com",//设置节点跳转的链接，如果不设置则不会跳转
                            target: "_self",//节点链接打开方式
                            alias: 'changyong',
                            checkboxValue: 1,//复选框的值
                            checked: true,//复选框默认是否选中
                            children: [{
                                name: '所有未读',
                                alias: 'weidu',
                                checked: true,
                                checkboxValue: 2
                            }, {
                                name: '置顶邮件',
                            }, {
                                name: '标签邮件',
                                checked: false,
                                checkboxValue: 3
                            }]
                        }, {
                            name: '我的邮箱',
                            checked: true,
                            spread: true,
                            children: [{
                                name: 'QQ邮箱',
                                checked: true,
                                checkboxValue: 4,
                                spread: true,
                                children: [{
                                    name: '收件箱',
                                    checked: false,
                                    checkboxValue: 5,
                                    children: [{
                                        name: '所有未读',
                                        checked: false,
                                        checkboxValue: 6,
                                        children: [{
                                            name: '一周未读',
                                            checked: false,
                                            checkboxValue: 6
                                        }]
                                    }, {
                                        name: '置顶邮件',
                                        checked: false,
                                        checkboxValue: 7
                                    }, {
                                        name: '标签邮件',
                                        checked: false,
                                        checkboxValue: 8
                                    }]
                                }, {
                                    name: '已发出的邮件',
                                    checked: false,
                                    checkboxValue: 9
                                }, {
                                    name: '垃圾邮件',
                                    checked: false,
                                    checkboxValue: 10
                                }]
                            }, {
                                name: '阿里云邮',
                                checked: true,
                                checkboxValue: 11,
                                children: [{
                                    name: '收件箱',
                                    checked: true,
                                    checkboxValue: 12
                                }, {
                                    name: '已发出的邮件',
                                    checked: true,
                                    checkboxValue: 13
                                }, {
                                    name: '垃圾邮件',
                                    checked: true,
                                    checkboxValue: 14
                                }]
                            }]
                        }
                    ]
                });
            }, 200);



        });
    </script>
</head>

<body>


<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>生成一个较深的树</legend>
</fieldset>
<div class="descripttion">
    <h2 style="font-size: 22px;">
        这棵树是我根据layer的一个树形菜单改良的，目前这棵树适合用在权限分配、菜单分类中。
    </h2>
    <br>
    <h4 style="font-size: 18px;font-weight: 600;color: #666;">特点：</h4>
    <h5 style="letter-spacing: 2px;line-height: 21px;text-indent: 25px;font-size: 16px;">
        选中父节点，该父节点下的所有子节点都会被选中，父节点不选中，则该父节点下的所有子节点都会被取消选中；选中子节点，该子节点的所有父节点都会被选中；当某一父节点下的所有子节点都没有被选中时，该父节点会被取消选中，只要该父节点下有一个子节点选中了，该父节点都不会被取消选中。
        <br />
        支持IE8及现代浏览器
    </h5>
    <br>
    <h4 style="font-size: 18px;font-weight: 600;color: #666;">使用注意事项：</h4>
    <h5 style="letter-spacing: 2px;line-height: 21px;text-indent: 25px;font-size: 16px;">
        当一个页面中用到了多棵树的时候，需要使用setTimeout进行延时，因为每棵树加载并渲染需要一定的时间（里面用到了很多的循环和递归），如果不设置延时则可能导致后面的树渲染不出来。
    </h5>
</div>


<ul id="demo"></ul>
<ul id="demo1"></ul>



</body>

</html>