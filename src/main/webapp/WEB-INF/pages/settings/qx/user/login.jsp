<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        // 因为用户不一定鼠标在什么地方的时候点击回车，所以给整个页面添加一个keydown事件
        $(window).keydown(function (e) {
            if (e.keyCode == 13) {
                // 如果是回车键，那么就模拟一次登录按钮被点击
                $("#loginBtn").click();
                // jQuery中事件函数用法
                // .click(function() {}) 给按钮添加一个单机时间
                // .click() 模拟按钮被单机了一次
            }
        });
        $(function () {
            // 给登录按钮添加单击事件
            $("#loginBtn").click(function () {

                // 1. 获取数据 $.trim() 去空格
                var loginAct = $.trim($("#loginAct").val());
                var loginPwd = $.trim($("#loginPwd").val());
                // 获取属性值一般使用attr() 或者 prop()
                // attr() 用于获取属性值不是true或者false的属性
                // prop() 用于获取属性值是true或者false的属性
                var isRemPwd = $("#isRemPwd").prop("checked");

                // 2. 数据合法性验证 判断用户名密码是否为空
                if (loginAct == "") {
                    alert("用户名不为空");
                    return;
                }

                if (loginPwd == "") {
                    alert("密码不为空");
                    return;
                }

                // 3.发送请求
                $.ajax({
                        url: "settings/qx/user/login.do",
                        data: {
                            "loginAct": loginAct,
                            "loginPwd": loginPwd,
                            "isRemPwd": isRemPwd
                        },
                        type: "post",
                        dataType: "json",
                        success: function (data) {
                            // 根据obj返回值的code来判断登录是否成功
                            if (data.code == "1") {
                                // 登录成功
                                // 跳转到workbench的主界面
                                // 由于在WEB-INF下，所以需要通过controller跳转
                                window.location.href = "workbench/index.do";
                            } else {
                                $("#msg").text(data.message);
                            }
                        },
                        beforeSend: function () {
                            $("#msg").text("正在验证.........");
                        }
                    },
                );
            });
        });
    </script>
</head>
<body>
<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
    <img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2019&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form action="workbench/index.html" class="form-horizontal" role="form">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input class="form-control" id="loginAct" type="text" value="${cookie.loginAct.value}"
                           placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input class="form-control" id="loginPwd" type="password" value="${cookie.loginPwd.value}"
                           placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;">
                    <%--                    根据用户cookie中是否有数据来判断是否记住密码--%>
                    <label>
                        <c:if test="${not empty cookie.loginAct and not empty cookie.loginPwd}">
                            <input type="checkbox" id="isRemPwd" checked> 记住密码
                        </c:if>
                        <c:if test="${empty cookie.loginAct or empty cookie.loginPwd}">
                            <input type="checkbox" id="isRemPwd"> 记住密码
                        </c:if>
                    </label>
                    &nbsp;&nbsp;
                    <span id="msg" style="color: red"></span>
                </div>
                <button type="button" id="loginBtn" class="btn btn-primary btn-lg btn-block"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>