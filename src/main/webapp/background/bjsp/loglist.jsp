
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path=application.getContextPath();
	String csspath = application.getContextPath()+"/background/bcss/";
	String jspath =  application.getContextPath()+"/background/bjs/";

%>
<html>
<head>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css" %>>
	<link rel="stylesheet" href=<%=csspath+"backmain.css"%> >
	<script type="text/javascript" src="<%=jspath+"jquery-3.4.1.js"%>"></script>
	<script src="<%=path+"/layui/layui.js"%>" charset="utf-8"></script>
	<script src="<%=jspath+"usermanage.js"%>" charset="utf-8"></script>
	<title>日志列表</title>
</head>
<body>
<form class="layui-form">
	<div class="layui-form-item" >

		<div class="layui-inline">
			<label class="layui-form-label">操作时间：</label>
			<div class="layui-input-inline">
				<input type="date" class="layui-input" id="dateStart" placeholder="yyyy-MM-dd">
			</div>
			<label class="layui-form-label">至</label>
			<div class="layui-input-inline">
				<input type="date" class="layui-input" id="dateEnd" placeholder="yyyy-MM-dd">
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label" >操作人 ：</label>
			<div class="layui-input-inline">
				<input name="opman" id="opman" class="layui-input" type="text" autocomplete="off" >
			</div>

			<button class="layui-btn " id="query_bt"  type="button">查询</button>
		</div>
	</div>
</form>
<table id="demo" lay-filter="test"></table>



<script src="<%=path%>/layui/dist/layui.js" charset="utf-8"></script>
<script>
	layui.use('table', function () {

		var table = layui.table;

		table.render({
			elem: '#demo'
			, height: 312
			, url: "<%=path%>/BackServlet?methodName=loglist" //数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				// {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
				{field: 'optime', title: '操作时间', width: 180}
				, {field: 'opman', title: '操作人', width: 120, sort: true}
				, {field: 'opthing', title: '操作事项', width: 220}


			]]
			, id: 'logtable'
		});

		$("#query_bt").click(function () {
			var dateStart = $('#dateStart').val();
			var dateEnd = $('#dateEnd').val();
			var opman= $('#opman').val();
			if ((dateStart.length > 0 && dateEnd.length > 0) || (dateStart.length == 0 && dateEnd.length == 0)) {
				if ((dateStart.length != 0 && dateEnd.length != 0) && (dateStart === dateEnd)) {
					layer.msg("前后日期需大于一天", {icon: 5});
				} else {
					table.reload('logtable', {
						url:  "<%=path%>/BackServlet?methodName=loglist"
						, where: { //设定异步数据接口的额外参数，任意设
							dateStart: dateStart,
							dateEnd: dateEnd,
							opman:opman
						}
						, page: {
							curr: 1 //重新从第 1 页开始
						}
					});
					// Layui表格,刷新当前分页数据
					// $(".layui-laypage-btn").click()


				}

			} else {
				layer.msg("日期需两者都选或两者都不选", {icon: 5});
			}

		});



	});
</script>

</body>
</html>
