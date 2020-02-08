<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path=application.getContextPath();
	String csspath = application.getContextPath()+"/background/bcss/";
	String jspath =  application.getContextPath()+"/background/bjs/";

%>
<html>
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css"%> >
	<link rel="stylesheet" href=<%=csspath+"backlogincss.css"%> >
	<script type="text/javascript" src="<%=jspath+"jquery-3.4.1.js"%>"></script>
	<script type="text/javascript" src="<%=jspath+"backmain.js"%>"></script>
	<script src="<%=path+"/layui/layui.js"%>" charset="utf-8"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>layout 后台大布局 - Layui</title>
	<link rel="stylesheet" href="../src/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo">layui 后台布局</div>
		<!-- 头部区域（可配合layui已有的水平导航） -->
<%--		用户测试：${user.username}--%>
<%--		也可以写成${requestScope.user.username}--%>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item">
				<a href="javascript:;">
					<img src="http://t.cn/RCzsdCq" class="layui-nav-img">
					${user.username}
				</a>

				<dl class="layui-nav-child">
					<dd><a href="">基本资料</a></dd>
					<dd><a href="">安全设置</a></dd>
				</dl>
			</li>
			<li class="layui-nav-item"><a href="">退了</a></li>
		</ul>
	</div>

	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<ul class="layui-nav layui-nav-tree"  lay-filter="test">
<%--				<li class="layui-nav-item layui-nav-itemed">--%>
<%--					<a class="" onclick='aClick(this)' title="background/bjsp/usermanage.jsp">用户</a>--%>

<%--				</li>--%>
				<li class="layui-nav-item">
					<a href="javascript:;">用户</a>
					<dl class="layui-nav-child">
						<dd>	<a class="" onclick='aClick(this)' title=<%=path+"/background/bjsp/usermanage.jsp"%>>用户</a></dd>
						<dd><a href="javascript:;">列表二</a></dd>
						<dd><a href="">超链接</a></dd>
					</dl>
				</li>

				<li class="layui-nav-item">
					<a href="javascript:;">文档</a>
					<dl class="layui-nav-child">
						<dd>	<a class="" onclick='aClick(this)' title=<%=path+"/background/bjsp/docmanage.jsp"%>>文档审核</a></dd>
						<dd><a href="javascript:;">列表二</a></dd>
						<dd><a href="">超链接</a></dd>
					</dl>
				</li>

	<li class="layui-nav-item">
		<a href="javascript:; "onclick='aClick(this)' title=<%=path+"/background/bjsp/loglist.jsp"%>>日志列表</a>

	</li>

			</ul>
		</div>
	</div>

	<div class="layui-body" id="div2">
		<!-- 内容主体区域 -->
		<iframe style="width: 100%;height: 100%" src="" name="display" frameborder="0" id="myif"></iframe>
	</div>

	<div class="layui-footer">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>

<script>
	//JavaScript代码区域
	layui.use('element', function(){
		var element = layui.element;

	});
</script>
</body>
</html>