<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">

    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">

        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;

        $(function () {
            $("#remark").focus(function () {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function () {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });

            // $(".remarkDiv").mouseover(function () {
            //     $(this).children("div").children("div").show();
            // });

            $("#remarkDivList").on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            });

            // $(".remarkDiv").mouseout(function () {
            //     $(this).children("div").children("div").hide();
            // });

            $("#remarkDivList").on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            });


            //
            // $(".myHref").mouseover(function () {
            //     $(this).children("span").css("color", "red");
            // });

            $("#remarkDivList").on("mouseover", ".myHref", function () {
                $(this).children("span").css("color", "red");
            });

            // $(".myHref").mouseout(function () {
            //     $(this).children("span").css("color", "#E6E6E6");
            // });

            $("#remarkDivList").on("mouseout", ".myHref", function () {
                $(this).children("span").css("color", "#E6E6E6");
            });

            $("#remarkDivList").on("click", "a[name='deleteA']", function () {
                // 获取到要删除的评论ID
                // $(this) 将DOM对象转换成jQuery对象
                var remarkId = $(this).attr("remarkId");
                // 发送删除请求
                $.ajax({
                    url: "workbench/activity/deleteRemark.do",
                    data: {
                        remarkId: remarkId
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if(data.code == 1) {
                            // 删除成功 删除掉评论对应的div
                            // 为了防止Id重复，可以使用标签名_id的方式来解决
                            // 获取到要删除的div
                            $("#div_" + remarkId).remove();
                        } else {
                            alert(data.message);
                        }
                    }
                })
            });

            $("#remarkDivList").on("click", "a[name='editA']", function () {
                // 获取评论ID
                var remarkId = $(this).attr("remarkId");
                // 获取评论内容 根据id找到最外面的div，然后使用父子选择器选择div下面的h5标签
                var noteContent = $("#div_" + remarkId + " h5").text();

                // 将数据写入到模态窗口
                $("#remarkId").val(remarkId);
                $("#noteContent").val(noteContent);
                // 显示窗口
                $("#editRemarkModal").modal("show");
            });
            // 给保存按钮添加单击事件
            $("#saveBtn").click(function () {
                var remark = $.trim($("#remark").val());
                // 这里必须加引号，因为页面执行首先先将JSP页面在Tomcat服务器中执行完毕，
                // 然后等服务器执行完毕后返回html后，页面加载完毕后JS代码才执行
                // 如果不加引号，那么ActivityID接收到的就不是字符串了，是变量
                var activityId = '${activity.id}';
                if (remark === "") {
                    alert("评论不能为空");
                    return;
                }
                $.ajax({
                    url: "workbench/activity/addRemark.do",
                    type: "post",
                    dataType: "json",
                    data: {
                        activityId: activityId,
                        noteContent: remark
                    },
                    success: function (data) {
                        if (data.code == 1) {
                            // 评论成功
                            // 清空评论区
                            $("#remark").val("");
                            // 追加评论
                            var htmlStr = "";
                            htmlStr += "<div id=\"div_" + data.retData.id + "\" class=\"remarkDiv\" style=\"height: 60px;\">";
                            htmlStr += "<img title=\"${sessionScope.sessionUser.name}\" src=\"image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">";
                            htmlStr += "<div style=\"position: relative; top: -40px; left: 40px;\" >";
                            htmlStr += "<h5>" + data.retData.noteContent + "</h5>";
                            htmlStr += "<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>${activity.name}</b> <small style=\"color: gray;\"> " + data.retData.createTime + " 由${sessionScope.sessionUser.name}创建</small>";
                            htmlStr += "<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">";
                            htmlStr += "<a class=\"myHref\" name=\"editA\" remarkId=\"" + data.retData.id + "\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                            htmlStr += "&nbsp;&nbsp;&nbsp;&nbsp;";
                            htmlStr += "<a class=\"myHref\" name=\"deleteA\" remarkId=\"" + data.retData.id + "\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>";
                            htmlStr += "</div>";
                            htmlStr += "</div>";
                            htmlStr += "</div>";
                            // 了解html() text() append() before() after();
                            $("#remarkDiv").before(htmlStr);
                        } else {
                            // 评论失败
                            alert(data.message);
                        }
                    }
                });
            });

            // 给模态窗口的更新按钮添加事件
            $("#updateRemarkBtn").click(function () {
                // 验证评论区是否为空
                var remarkId = $("#remarkId").val();
                var noteContent = $.trim($("#noteContent").val());
                if(noteContent == "") {
                    alert("评论不能为空");
                    return;
                }
                // 向后台发送数据
                $.ajax({
                    url: "workbench/activity/editRemark.do",
                    type: "post",
                    dataType: "json",
                    data: {
                        id: remarkId,
                        noteContent: noteContent
                    },
                    success: function (data) {
                        if(data.code == 1) {
                            // 修改成功 关闭模态窗口 更新页面
                            $("#editRemarkModal").modal("hide");
                            // 重新设置信息
                            // 设置内容信息
                            $("#div_" + data.retData.id + " h5").val(data.retData.noteContent);
                            $("#div_" + data.retData.id + " small").text(" " + data.retData.editTime + "由${sessionScope.sessionUser.name}修改");

                        } else {
                            // 更新失败
                            alert(data.message);
                            $("#editRemarkModal").modal("show");
                        }
                    }
                });
            })
        });

    </script>

</head>
<body>

<!-- 修改市场活动备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="remarkId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="noteContent" class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="noteContent"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>市场活动-${activity.name} <small>${activity.startDate} ~ ${activity.endDate}</small></h3>
    </div>

</div>

<br/>
<br/>
<br/>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.name}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>

    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">开始日期</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.startDate}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.endDate}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">成本</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.cost}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${activity.createBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${activity.createTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;">
            <b>${activity.editBy}&nbsp;&nbsp;</b><small
                style="font-size: 10px; color: gray;">${activity.editTime}</small></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${activity.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="remarkDivList" style="position: relative; top: 30px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <c:forEach items="${activityRemarkList}" var="remark">
        <!-- 备注1 -->
        <div id="div_${remark.id}" class="remarkDiv" style="height: 60px;">
            <img title="${remark.createBy}" src="image/user-thumbnail.png" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5>${remark.noteContent}</h5>
                <font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b> <small
                    style="color: gray;"> ${remark.editFlag=='1'?remark.editTime:remark.createTime}
                由${remark.editFlag=='1'?remark.editBy:remark.createBy}${remark.editFlag=='1'?'修改':'创建'}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" name="editA" remarkId="${remark.id}" href="javascript:void(0);"><span
                            class="glyphicon glyphicon-edit"
                            style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" name="deleteA" remarkId="${remark.id}" href="javascript:void(0);"><span
                            class="glyphicon glyphicon-remove"
                            style="font-size: 20px; color: #E6E6E6;"></span></a>
                </div>
            </div>
        </div>
    </c:forEach>

    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </p>
        </form>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>