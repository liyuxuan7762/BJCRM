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
    <link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <%--    分页插件--%>
    <script href="jquery/bs_pagination-master/css/jquery.bs_pagination.min.css" type="text/css"
            rel="stylesheet"></script>
    <script src="jquery/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
    <script src="jquery/bs_pagination-master/localization/en.js"></script>
    <script type="text/javascript">

        $(function () {
            // 给创建按钮添加单击事件
            $("#createActivityBtn").click(function () {
                // 点击弹出模态窗口的时候，要清空模态窗口里面的内容
                $("#createActivityForm").get(0).reset(); //get是将jQuery转化成DOM对象
                // 显示模态窗口
                $("#createActivityModal").modal("show");
            });

            // 给保存按钮添加单击事件
            $("#saveActivityBtn").click(function () {
                // 1.获取页面数据
                var owner = $("#create-marketActivityOwner").val()
                var name = $.trim($("#create-marketActivityName").val());
                var startDate = $("#create-startTime").val();
                var endDate = $("#create-endTime").val();
                var cost = $.trim($("#create-cost").val());
                var describe = $.trim($("#create-describe").val());

                // 2.判断数据是否合法
                // 创建者和名称不能为空'
                if (owner == "") {
                    alert("创建者不能为空");
                    return;
                }
                if (name == "") {
                    alert("活动名称不能为空");
                    return;
                }
                // 当开始日期和结束日期都不为空的时候 开始时期要小于结束日期
                if (startDate != "" && endDate != "") {
                    if (startDate > endDate) {
                        alert("开始时期要小于结束日期");
                        return;
                    }
                }
                // 判断成本只能是非负整数
                var regExp = /^(([1-9]\d*)|0)$/;
                if (!regExp.test(cost)) {
                    alert("成本只能是非负整数");
                    return;
                }

                // 2.发送Ajax请求
                $.ajax({
                    url: "workbench/activity/saveActivity.do",
                    data: {
                        "owner": owner,
                        "name": name,
                        "startDate": startDate,
                        "endDate": endDate,
                        "cost": cost,
                        "description": describe
                    },
                    type: "post",
                    success: function (data) {
                        if (data.code == "1") {
                            // 如果添加成功 关闭模态窗口
                            $("#createActivityModal").modal("hide");
                            // 刷新列表
                            queryActivityByConditionForPage(1, $("#pagination").bs_pagination("getOption", "rowsPerPage"));
                        } else {
                            // 不关闭模态窗口
                            alert(data.message);
                            $("#createActivityModal").modal("show");
                        }
                    }
                });
            });

            // 添加日历功能
            $(".mydate").datetimepicker({
                language: 'zn-CH', // 设置日历语言
                format: 'yyyy-mm-dd',
                minView: 'month', // 显示最小显示的级别，如果选择月，那么最小的显示范围就是一个月的30天
                initialDate: new Date(), // 日历初始日期
                autoclose: true, // 选择完自动关闭日历,
                todayBtn: true, // 显示今天按钮
                clearBtn: true // 显示清空按钮
            });

            // 当页面元素加载完成后，执行无条件查询活动记录第一页
            queryActivityByConditionForPage(1, 5);

            // 当点击查询按钮时
            $("#queryBtn").click(function () {
                queryActivityByConditionForPage(1, $("#pagination").bs_pagination("getOption", "rowsPerPage"));
            });

            // 给全选按钮添加单击事件
            $("#checkAll").click(function () {
                $("#tbody input[type = 'checkbox']").prop("checked", this.checked);
            });

            // 给每一个市场活动记录的checkbox添加事件，由于记录属于动态元素，因此需要使用on函数添加事件
            $("#tbody").on("click", "input[type = 'checkbox']", function () {
                // 判断checkbox的总个数和checked属性为true总个数是否相等，相等则全选选中，否则全选不选中
                if ($("#tbody input[type = 'checkbox']").size() === $("#tbody input[type = 'checkbox']:checked").size()) {
                    $("#checkAll").prop("checked", true);
                } else {
                    $("#checkAll").prop("checked", false);
                }
            });

            // 给删除按钮添加单击事件
            $("#deleteActivityBtn").click(function () {
                // 1.获取所有选中的CheckBox
                var checked = $("#tbody input[type = 'checkbox']:checked");
                // 2.判断是否有选中的CheckBox
                if (checked.size() == 0) {
                    alert("请至少选择一个市场活动");
                    return;
                }
                if (window.confirm("你确定要删除所选市场活动吗？")) {
                    var ids = "";
                    // 3.遍历checked数组，拼接所有value值
                    $.each(checked, function () {
                        ids += "id=" + this.value + "&";
                    });
                    ids = ids.substr(0, ids.length - 1); // 拼接完成字符串

                    // 4.发送异步请求
                    $.ajax({
                        url: "workbench/activity/deleteActivityByIds.do",
                        data: ids,
                        type: "post",
                        dataType: "json",
                        success: function (data) {
                            if (data.code == 1) {
                                // 删除成功，那么刷新列表到第一页 每页显示条数和之前一样
                                queryActivityByConditionForPage(1, $("#pagination").bs_pagination("getOption", "rowsPerPage"));
                            } else {
                                // 删除失败
                                alert(data.message);
                            }
                        }
                    })
                }
            });

            // 给修改按钮添加单击事件
            $("#modifyActivityBtn").click(function () {
                // 1.获取列表中所有选中状态的checkbox
                var check = $("#tbody input[type='checkbox']:checked");
                // 如果没有选中 则提示
                if (check.size() == 0) {
                    alert("请选择一个市场活动");
                    $("#editActivityModal").modal("hide");
                    return;
                }
                // 如果选中多个
                if (check.size() > 1) {
                    alert("你只能选择一个市场活动");
                    $("#editActivityModal").modal("hide");
                    return;
                }
                // 2.拿到选中的市场活动id
                var id = check.val();
                // 3.发送异步请求
                $.ajax({
                    url: "workbench/activity/queryActivityById.do",
                    data: {
                        id: id
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        // 3.给模态窗口赋值
                        $("#edit-id").val(data.id);
                        $("#edit-marketActivityOwner").val(data.owner);
                        $("#edit-marketActivityName").val(data.name);
                        $("#edit-startTime").val(data.startDate);
                        $("#edit-endTime").val(data.endDate);
                        $("#edit-cost").val(data.cost);
                        $("#edit-describe").val(data.description);
                        // 4.显示模态窗口
                        $("#editActivityModal").modal("show");
                    }
                })
            });

            // 给更新按钮添加单击事件
            $("#updateActivityBtn").click(function () {
                // 1.收集参数
                var id = $("#edit-id").val();
                var owner = $("#edit-marketActivityOwner").val()
                var name = $.trim($("#edit-marketActivityName").val());
                var startDate = $("#edit-startTime").val();
                var endDate = $("#edit-endTime").val();
                var cost = $.trim($("#edit-cost").val());
                var describe = $.trim($("#edit-describe").val());
                // 2.参数合法性验证
                if (owner == "") {
                    alert("创建者不能为空");
                    return;
                }
                if (name == "") {
                    alert("活动名称不能为空");
                    return;
                }
                // 当开始日期和结束日期都不为空的时候 开始时期要小于结束日期
                if (startDate != "" && endDate != "") {
                    if (startDate > endDate) {
                        alert("开始时期要小于结束日期");
                        return;
                    }
                }
                var regExp = /^(([1-9]\d*)|0)$/;
                if (!regExp.test(cost)) {
                    alert("成本只能是非负整数");
                    return;
                }
                // 3.发送请求
                $.ajax({
                    url: "workbench/activity/updateActivity.do",
                    data: {
                        "id": id,
                        "owner": owner,
                        "name": name,
                        "startDate": startDate,
                        "endDate": endDate,
                        "cost": cost,
                        "description": describe
                    },
                    type: "post",
                    success: function (data) {
                        if (data.code == "1") {
                            // 如果添加成功 关闭模态窗口
                            $("#editActivityModal").modal("hide");
                            // 刷新列表
                            queryActivityByConditionForPage($("#pagination").bs_pagination("getOption", "currentPage"), $("#pagination").bs_pagination("getOption", "rowsPerPage"));
                        } else {
                            // 不关闭模态窗口
                            alert(data.message);
                            $("#editActivityModal").modal("show");
                        }
                    }
                });
            });

            // 给批量下载添加单击事件
            $("#exportActivityAllBtn").click(function () {
                window.location.href = "workbench/activity/exportAllActivities.do";
            });
        });

        function queryActivityByConditionForPage(pageNo, pageSize) {
            // 1.获取页面元素
            var owner = $("#query-owner").val()
            var name = $.trim($("#query-name").val());
            var startDate = $("#query-startDate").val();
            var endDate = $("#query-endDate").val();
            var pageSize = pageSize;
            var pageNo = pageNo;
            // 2.发送请求
            $.ajax({
                url: "workbench/activity/queryActivity.do",
                type: "post",
                dataType: "json",
                data: {
                    "owner": owner,
                    "name": name,
                    "startDate": startDate,
                    "endDate": endDate,
                    "pageSize": pageSize,
                    "pageNo": pageNo
                },
                success: function (data) {
                    // $("#totalRowB").text(data.totalRow);
                    var htmlStr = "";
                    $.each(data.activityList, function (index, obj) {
                        htmlStr += "<tr class=\"active\">";
                        htmlStr += "<td><input type=\"checkbox\" value=\"" + obj.id + "\"/></td>";
                        htmlStr += "<td><a style=\"text-decoration: none; cursor: pointer; onclick=\"window.location.href='detail.html'\">" + obj.name + "</a></td>";
                        htmlStr += "<td>" + obj.owner + "</td>";
                        htmlStr += "<td>" + obj.startDate + "</td>";
                        htmlStr += "<td>" + obj.endDate + "</td>";
                        htmlStr += "</tr>";
                    });
                    $("#tbody").html(htmlStr);

                    // 重置全选按钮
                    $("#checkAll").prop("checked", false);

                    var totalPageNum = Math.ceil(data.totalRow / pageSize);
                    // 调用分页插件
                    $("#pagination").bs_pagination({
                        currentPage: pageNo, // 当前页号
                        rowsPerPage: pageSize, // 每行记录数
                        totalRows: data.totalRow, // 总记录数
                        totalPages: totalPageNum,// 总条数
                        visiblePageLinks: 5, // 翻页按钮个数,
                        showGoToPage: true,
                        showRowsPerPage: true,
                        showRowsInfo: true,
                        showRowsDefaultInfo: true,
                        onChangePage: function (event, pageObj) {
                            queryActivityByConditionForPage(pageObj.currentPage, pageObj.rowsPerPage);
                        }
                    });
                }
            });
        }


    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="createActivityForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control mydate" id="create-startTime" readonly>
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control mydate" id="create-endTime" readonly>
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveActivityBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">
                    <input type="hidden" id="edit-id">
                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                                <c:forEach items="${userList}" var="user">
                                    <option value="${user.id}">${user.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName" value="发传单">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control mydate" id="edit-startTime" value="2020-10-10">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control mydate" id="edit-endTime" value="2020-10-20">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" value="5,000">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe">市场活动Marketing，是指品牌主办或参与的展览会议与公关市场活动，包括自行主办的各类研讨会、客户交流会、演示会、新产品发布会、体验会、答谢会、年会和出席参加并布展或演讲的展览会、研讨会、行业交流会、颁奖典礼等</textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateActivityBtn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 导入市场活动的模态窗口 -->
<div class="modal fade" id="importActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：<small style="color: gray;">[仅支持.xls]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input type="file" id="activityFile">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;">
                    <h3>重要提示</h3>
                    <ul>
                        <li>操作仅针对Excel，仅支持后缀名为XLS的文件。</li>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>日期值以文本形式保存，必须符合yyyy-MM-dd格式。</li>
                        <li>日期时间以文本形式保存，必须符合yyyy-MM-dd HH:mm:ss的格式。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="importActivityBtn" type="button" class="btn btn-primary">导入</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon" id="query-name">名称</div>
                        <input class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon" id="query-owner">所有者</div>
                        <input class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon" id="query-startDate">开始日期</div>
                        <input class="form-control mydate" type="text" id="startTime" readonly/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon" id="query-endDate">结束日期</div>
                        <input class="form-control mydate" type="text" id="endTime" readonly>
                    </div>
                </div>

                <button type="button" class="btn btn-default" id="queryBtn">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="createActivityBtn">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" id="modifyActivityBtn" class="btn btn-default" data-toggle="modal"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger" id="deleteActivityBtn"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal">
                    <span class="glyphicon glyphicon-import"></span> 上传列表数据（导入）
                </button>
                <button id="exportActivityAllBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（批量导出）
                </button>
                <button id="exportActivityXzBtn" type="button" class="btn btn-default"><span
                        class="glyphicon glyphicon-export"></span> 下载列表数据（选择导出）
                </button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="checkAll"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="tbody">
                <tr class="active">
                    <td><input type="checkbox"/></td>
                    <td><a style="text-decoration: none; cursor: pointer;"
                           onclick="window.location.href='detail.html';">发传单</a></td>
                    <td>zhangsan</td>
                    <td>2020-10-10</td>
                    <td>2020-10-20</td>
                </tr>
                <tr class="active">
                    <td><input type="checkbox"/></td>
                    <td><a style="text-decoration: none; cursor: pointer;"
                           onclick="window.location.href='detail.html';">发传单</a></td>
                    <td>zhangsan</td>
                    <td>2020-10-10</td>
                    <td>2020-10-20</td>
                </tr>
                </tbody>
            </table>
            <div id="pagination"></div>
        </div>
    </div>
</div>
</body>
</html>