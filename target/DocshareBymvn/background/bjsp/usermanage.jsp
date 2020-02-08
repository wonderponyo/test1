
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
	<title>Title</title>
</head>
<body>
<form class="layui-form">
	<div class="layui-form-item" >

		<div class="layui-inline">
			<label class="layui-form-label">注册时间：</label>
			<div class="layui-input-inline">
				<input type="date" class="layui-input" id="dateStart" placeholder="yyyy-MM-dd">
			</div>
			<label class="layui-form-label">至</label>
			<div class="layui-input-inline">
				<input type="date" class="layui-input" id="dateEnd" placeholder="yyyy-MM-dd">
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label" >用户名 ：</label>
			<div class="layui-input-inline">
				<input name="username" id="username" class="layui-input" type="text" autocomplete="off" >
			</div>

			<button class="layui-btn " id="query_bt"  type="button">查询</button>
		</div>
	</div>
</form>
<table id="demo" lay-filter="test"></table>

<script type="text/html" id="stateBar">
	{{#  if(d.userstate == '审核通过'){ }}
	<a class="layui-btn layui-btn-danger layui-btn-xs" title="禁用" lay-event="disable">禁用</a>

	{{#  } else if(d.userstate == '禁用') { }}
	<a class="layui-btn layui-btn-xs" title="启用" lay-event="enable">启用</a>

	{{#  }
	}}
</script>

<script src="<%=path%>/layui/dist/layui.js" charset="utf-8"></script>
<script>
	layui.use('table', function () {

		var table = layui.table;
		//第一个实例
		table.render({
			elem: '#demo'
			, height: 312
			, url: "<%=path%>/backstage/userlist.action" //数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				// {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
				{field: 'username', title: '用户名', width: 120}
				, {field: 'regtime', title: '注册时间', width: 120, sort: true}
				, {field: 'score', title: '积分', width: 80}
				, {field: 'uploadsum', title: '上传文档数', width: 120}
				, {field: 'downloadsum', title: '下载文档数', width: 120}
				, {field: 'userstate', title: '用户状态', width: 120}
				,{field: 'opreate', title: '操作', width: 120,toolbar: '#stateBar'}

			]]
			, id: 'usertable'
		});

		$("#query_bt").click(function () {
			var dateStart = $('#dateStart').val();
			var dateEnd = $('#dateEnd').val();
			var username= $('#username').val();
			if ((dateStart.length > 0 && dateEnd.length > 0) || (dateStart.length == 0 && dateEnd.length == 0)) {
				if ((dateStart.length != 0 && dateEnd.length != 0) && (dateStart === dateEnd)) {
					layer.msg("前后日期需大于一天", {icon: 5});
				} else {
						table.reload('usertable', {
							url:  "<%=path%>/backstage/userlist.action"
							, where: { //设定异步数据接口的额外参数，任意设
								dateStart: dateStart,
								dateEnd: dateEnd,
								username:username
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

		table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data; //获得当前行数据
			var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
			var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
			var oldstate=data.userstate;
			var newstate=$(tr).find('a').attr("title");
			 if(layEvent === 'disable' || layEvent === 'enable'){ //禁用
				var inde= layer.confirm('确定'+newstate+data.username+'吗？', function(index){
					// obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
					// layer.close(index);

					$.ajax({
						type: "POST",
						url: "<%=path%>/backstage/updateState.action",
						dataType: "text",
						data:{username:data.username,state:$(tr).find('a').attr("title")},
						success: function (msg) {
							if (msg==="success") {
								layer.alert('状态修改成功', {icon: 1});
								if(newstate==="启用"){
									newstate="审核通过";
									//window.parent.location.reload();
								}
								var dateStart = $('#dateStart').val();
								var dateEnd = $('#dateEnd').val();
								var username= $('#username').val();
								if ((dateStart.length > 0 && dateEnd.length > 0) || (dateStart.length == 0 && dateEnd.length == 0)) {
									if ((dateStart.length != 0 && dateEnd.length != 0) && (dateStart === dateEnd)) {
										layer.msg("前后日期需大于一天", {icon: 5});
									} else {
										table.reload('usertable', {
											url: "<%=path%>/backstage/userlist.action"
											, where: { //设定异步数据接口的额外参数，任意设
												dateStart: dateStart,
												dateEnd: dateEnd,
												username:username
											}

										});
										// Layui表格,刷新当前分页数据
										// $(".layui-laypage-btn").click()

									}

								} else {
									layer.msg("日期需两者都选或两者都不选", {icon: 5});
								}
								// obj.update({
								// 	userstate:newstate
								// });

							}

						}
					 })
					 layer.close(inde);
				});
			}

		});

	});
</script>

</body>
</html>
