<%@ page import="net.inf.Userinf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path=application.getContextPath();
	String csspath = application.getContextPath()+"/front/fcss/";
	String jspath =  application.getContextPath()+"/front/fjs/";
	Userinf userinf = (Userinf) session.getAttribute("userinf");
%>
<html lang="en">
<head>
	<title>Title</title>
</head>

<head>
	<meta charset="UTF-8">
	<title>前台欢迎页面</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css"%> >
	<style>
		body {
			width: 100%;
			height: 500px;
		}

		#layout {
			width: 40%;
			height: 350px;
			margin: auto;
			margin-top: 100px;
			border: #9F9F9F solid 1px;
		}

		#info {
			height: 70px;
			border: #9F9F9F solid 1px;
		}

		#btgroup {
			margin-top: 20px;
			margin-left: 370px;

		}
		#search{
			margin-top: 40px;
			margin-left: 120px;
		}
		#layout1,#layout2{
			padding-right: 30px;
		}
		#btgrouplogin,#btgroupreg{
			margin-left: 180px;
		}
	</style>

</head>
<body>
<input type="hidden" value="<%=path%>" id="path">

<div id="layout">
	<div class="layui-layout layui-layout-admin">
	<div class="layui-header" id="info">

		<ul class="layui-nav " style="margin-left: 0px;margin-top: 5px" id="btgroup">
			<c:if test="${sessionScope.userinf == null}">
				<li class="layui-nav-item"><button class="layui-btn layui-btn-radius layui-btn-normal" id = "login" > 登录 </button ></li>&nbsp;&nbsp;&nbsp;
				<li class="layui-nav-item"><button class="layui-btn layui-btn-radius layui-btn-normal" id = "register" > 注册 </button ></li>&nbsp;&nbsp;&nbsp;
			</c:if>
			<c:if test="${sessionScope.userinf != null}">
				<li class="layui-nav-item"><span class="layui-input-inline " ><%="欢迎您："+userinf.getUsername()%></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
				<li class="layui-nav-item"><span class="layui-input-inline "><%="当前积分："+userinf.getScore()%></span>&nbsp;&nbsp;&nbsp;</li>
				<input type="hidden" value="<%=userinf.getUsername()%>" id="userid">
				<li class="layui-nav-item"><button class="layui-btn layui-btn-radius layui-btn-normal" style="padding: 0px 14px" id = "personinf" > 个人信息 </button ></li>
				<li class="layui-nav-item"><button class="layui-btn layui-btn-radius layui-btn-normal" style="padding: 0px 14px" id = "uploadopen" > 我要上传 </button ></li>
				<li class="layui-nav-item"><button class="layui-btn layui-btn-radius layui-btn-normal" style="padding: 0px 14px" id = "downloadopen" > 我要下载 </button ></li>
			</c:if>
		</ul>
	</div>
	</div>
	<div class="layui-form-item" >
		<div class="layui-input-inline">
			<input type="text" name="title" required lay-verify="required" id="docname" placeholder="请输入文档名" autocomplete="off"
			       class=" layui-input ">
		</div>
		<div class="layui-input-inline">
			<button class="layui-btn layui-btn-radius  layui-btn-primary" id="search">搜索文档</button>
		</div>
	</div>
	<table id="demo" lay-filter="test"></table>
<%--	<button type="button" class="layui-btn" id="test1">--%>
<%--		<i class="layui-icon">&#xe67c;</i>上传图片--%>
<%--	</button>--%>

</div>

<script type="text/html" id="loginface">
	<div id="layout1">
<%--		<form class="layui-form" action="">--%>
			<div class="layui-form-item">
				<label class="layui-form-label">用户名:</label>
				<div class="layui-input-block">
					<input type="text" name="title" required lay-verify="required" id="loginAccount" placeholder="请输入用户名" autocomplete="off"
					       class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">密码:</label>
				<div class="layui-input-block">
					<input type="password" name="password" required lay-verify="required" id="loginPassword" placeholder="请输入密码"
					       autocomplete="off" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-input-block" id="btgrouplogin">
					<button class="layui-btn" lay-submit lay-filter="formDemo" onclick="clientlogin()">登录</button>
					<button type="reset" class="layui-btn layui-btn-primary">返回</button>
				</div>
			</div>
<%--		</form>--%>
	</div>
</script>

<script type="text/html" id="personinfoshow">
	<div id="infoshow">
		<%--		<form class="layui-form" action="">--%>
		<div class="layui-form-item">
			<label class="layui-form-label">用户名:</label>
			<div class="layui-input-block">
				<span id="username"></span>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">性别:</label>
			<div class="layui-input-block">
				<span id="sex"></span>
			</div>
		</div>

			<div class="layui-form-item">
				<label class="layui-form-label">学历:</label>
				<div class="layui-input-block">
					<span id="edu"></span>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">职业:</label>
				<div class="layui-input-block">
					<span id="profes"></span>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">手机号:</label>
				<div class="layui-input-block">
					<span id="tel"></span>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">email:</label>
				<div class="layui-input-block">
					<span id="email"></span>
				</div>
			</div>

		<%--		</form>--%>
	</div>
</script>



<script type="text/html" id="registerface">
	<div id="layout2">

			<div class="layui-form-item">
				<label class="layui-form-label">用户名:</label>
				<div class="layui-input-block">
					<input type="text" name="title" id="registerAccount" required lay-verify="required" placeholder="请输入用户名" autocomplete="off"
					       class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">密码:</label>
				<div class="layui-input-block">
					<input type="password" name="password" id="registerPassword" required lay-verify="required" placeholder="请输入密码"
					       autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">重复输入:</label>
				<div class="layui-input-block">
					<input type="password" name="password" required lay-verify="required" placeholder="请输入密码"
					       autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">性别:</label>
				<div class="layui-input-block">
					<input type="radio" name="sex" value="男" title="男">
					<input type="radio" name="sex" value="女" title="女" checked>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">学历:</label>
				<div class="layui-input-block">
					<select name="city" lay-verify="required" id="education">
						<!--                    <option value=""></option>-->
						<option value="博士">博士</option>
						<option value="硕士">硕士</option>
						<option value="本科">本科</option>
						<option value="大专">大专</option>
						<option value="高中">高中</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">职业:</label>
				<div class="layui-input-block">
					<select name="city" lay-verify="required" id="profession">

						<option value="工人">工人</option>
						<option value="农民">农民</option>
						<option value="商人">商人</option>
						<option value="自由职业">自由职业</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label" >手机:</label>
				<div class="layui-input-block">
					<input type="tel" name="password" required lay-verify="phone" id="phone" placeholder="请输入手机"
					       autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">E-mail:</label>
				<div class="layui-input-block">
					<input type="email" name="password" required lay-verify="email" id="mail" placeholder="请输入邮箱"
					       autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block" id="btgroupreg">
					<button class="layui-btn"  lay-filter="formDemo" id="" onclick="clientreg()">注册</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>

	</div>
</script>
<%--<script src="/static/build/layui.js"></script>--%>

<script type="text/javascript" src="<%=jspath+"jquery-3.4.1.js"%>"></script>
<script src="<%=path+"/layui/layui.js"%>" charset="utf-8"></script>
<script src="<%=jspath%>Front_WelcomeFace.js?randomId=<%=Math.random()%>"></script>
<script>
	layui.use('table', function () {

		var table = layui.table;
		//第一个实例


		$("#search").click(function () {
			var docname= $('#docname').val();

			table.render({
				elem: '#demo'
				, height: 312
				, url: "<%=path%>/BackServlet?methodName=querydocbytitle&title="+docname //数据接口
				, page: true //开启分页
				, limit: 5
				, limits: [5, 10]
				, cols: [[ //表头
					// {field: 'id', title: 'ID', width:80, sort: true, fixed: 'left'}
					{field: 'doctitle', title: '文档标题', width: 120}
					, {field: 'username', title: '上传人', width: 120, sort: true}
					, {field: 'time', title: '上传时间', width: 80}
					, {field: 'downscore', title: '下载积分', width: 120}
					, {field: 'doctype', title: '文档类型', width: 120}
					,{field: 'opreate', title: '下载次数', width: 180}

				]]
				, id: 'usertable'
			});
					// Layui表格,刷新当前分页数据
					// $(".layui-laypage-btn").click()




		});



	});
</script>
</body>
</html>
