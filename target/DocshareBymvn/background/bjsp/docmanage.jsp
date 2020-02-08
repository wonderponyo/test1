
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

	<div class="layui-form-item">
<%--		<div class="layui-block">--%>

			<label class="layui-form-label" >文档标题 ：</label>
			<div class="layui-input-inline">
				<input name="doctitle" id="doctitle" class="layui-input" type="text" autocomplete="off" >
			</div>

			<label class="layui-form-label" >上传人 ：</label>
			<div class="layui-input-inline">
				<input name="username" id="username" class="layui-input" type="text" autocomplete="off" >
			</div>

				<label class="layui-form-label">文档类型</label>
				<div class="layui-input-inline">
					<select name="doctype" id="doctype" lay-verify="required">
						<option value=""></option>
						<option value="txt">txt</option>
						<option value="png">png</option>
						<option value="jpg">jpg</option>
						<option value="doc">doc</option>

					</select>
				</div>
	</div>

<%--		</div>--%>

	<div class="layui-form-item">
		<label class="layui-form-label" >上传时间 ：</label>
		<div class="layui-input-inline">
			<input name="time" id="test3" class="layui-input" type="text" autocomplete="off" >
		</div>
	<div class="layui-block">
			<button class="layui-btn " id="query_bt"  type="button">查询</button>

		</div>
	</div>
</form>
<form id="fileform" method="post" action="<%=path%>/backstage/filedownload.action">
	<input type="hidden" id="filename" name="filename">
</form>
<table id="demo" lay-filter="test"></table>

<script type="text/html" id="stateBar">

	<a class="layui-btn layui-btn-xs" title="下载" lay-event="download">下载</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" title="审核不通过" lay-event="审核不通过">审核不通过</a>

	<a class="layui-btn layui-btn-xs" title="审核通过" lay-event="审核通过">审核通过</a>

</script>
<script src="<%=path%>/layui/dist/layui.js" charset="utf-8"></script>
<script>
	layui.use(['table','laydate'], function () {

		var table = layui.table;
		var laydate = layui.laydate;

		//日期时间有效范围的设定:
		laydate.render({
			elem: '#test3' // 绑定元素的id
			,range:'~'
			,theme: '#393D49' // 自定义主题颜色
		});


		//第一个实例
		table.render({
			elem: '#demo'
			, height: 312
			, url: "<%=path%>/backstage/doclist.action" //数据接口
			, page: true //开启分页
			, limit: 5
			, limits: [5, 10]
			, cols: [[ //表头
				 {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left',hide:true}
				,{field: 'docname', title: '文档名', width:80, sort: true, fixed: 'left',hide:true}
				,{field: 'doctitle', title: '文档标题', width: 120}
				, {field: 'username', title: '上传人', width: 120, sort: true}
				, {field: 'time', title: '上传时间', width: 230}
				, {field: 'downscore', title: '下载积分', width: 120}
				, {field: 'doctype', title: '文档类型', width: 120}
				,{field: 'opreate', title: '操作', width: 230,toolbar: '#stateBar'}

			]]
			, id: 'usertable'
		});

		$("#query_bt").click(function () {
			var date=$('#test3').val();
			var username= $('#username').val();
			var doctitle=$('#doctitle').val();
			var doctype=$('#doctype').val();
			table.reload('usertable', {
				url: "<%=path%>/backstage/doclist.action" //数据接口
				, where: { //设定异步数据接口的额外参数，任意设
								date:date,
								username:username,
								doctitle:doctitle,
								doctype:doctype
							}
							, page: {
								curr: 1 //重新从第 1 页开始
							}
						});

		});

		table.on('tool(test)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
			var data = obj.data; //获得当前行数据
			var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
			var tr = obj.tr; //获得当前行 tr 的 DOM 对象（如果有的话）
			var date=$('#test3').val();
			var username= $('#username').val();
			var doctitle=$('#doctitle').val();
			var doctype=$('#doctype').val();
			var id=data.id;
			var docname=data.docname;
			if (layEvent!=="download") {
				var inde = layer.confirm('确定吗执行该操作吗？', function (index) {
					// obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
					// layer.close(index);
					//向服务端发送删除指令
					$.ajax({
						type: "POST",
						url: "<%=path%>/backstage/updatedocState.action",
						dataType: "text",
						data: {id: id, state: layEvent},
						success: function (msg) {
							if (msg === "success") {
								layer.alert('状态修改成功', {icon: 1});

								table.reload('usertable', {
									url: "<%=path%>/backstage/doclist.action"
									, where: { //设定异步数据接口的额外参数，任意设
										date: date,
										username: username,
										doctitle: doctitle,
										doctype: doctype
									}

								});
								// Layui表格,刷新当前分页数据
								// $(".layui-laypage-btn").click()

							}


						}


					})
					layer.close(inde);
				});

			}else {

				// ajax请求无法响应下载功能因为response原因，一般请求浏览器是会处理服务器输出的response，例如生成png、文件下载等,然而ajax请求只是个“字符型”的请求，即请求的内容是以文本类型存放的。
				// 文件的下载是以二进制形式进行的，虽然可以读取到返回的response，但只是读取而已，是无法执行的，说白点就是js无法调用到浏览器的下载处理机制和程序。

				var nameinput=$("#filename");

				nameinput.attr("value",docname);
				$("#fileform").submit();
			}

		});

	});
</script>

</body>
</html>
