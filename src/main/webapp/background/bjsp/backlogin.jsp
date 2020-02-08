
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path=application.getContextPath();
	String csspath = application.getContextPath()+"/background/bcss/";
	String jspath =  application.getContextPath()+"/background/bjs/";

%>
<html>
<head>
	<title>Title</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css"%> >
	<link rel="stylesheet" href=<%=csspath+"backlogincss.css"%> >
	<script type="text/javascript" src="<%=jspath+"jquery-3.4.1.js"%>"></script>
	<script src="<%=path+"/layui/layui.js"%>" charset="utf-8"></script>
</head>
<body>
<div id="div1">
	<h3>后台登录</h3>
<form class="layui-form" action=<%=path+"/backstage/log.action"%> method="post">
	<div class="layui-form-item">

		<label class="layui-form-label">账号</label>
		<div class="layui-input-inline">
			<input type="text" name="account" required  lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">密码</label>
		<div class="layui-input-inline">
			<input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
		</div>
	</div>

	<div class="layui-form-item">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
			<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		</div>
	</div>
</form>
</div>
<script>
	//Demo
	layui.use('form', function(){
		var form = layui.form;

		//监听提交
		form.on('submit(formDemo)', function(data){
			//layer.msg(JSON.stringify(data.field));

		});
	});
</script>
</body>
</html>
