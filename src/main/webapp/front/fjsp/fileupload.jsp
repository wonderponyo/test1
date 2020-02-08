<%@ page import="net.inf.Userinf" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path=application.getContextPath();
//	String username=request.getParameter("username);
	Userinf userinf = (Userinf) session.getAttribute("userinf");
	String csspath = application.getContextPath()+"/front/fcss/";
	String jspath =  application.getContextPath()+"/front/fjs/";

%>
<%--<html lang="en">--%>
<head>
	<title>Title</title>
	<link rel="stylesheet" href=<%=path+"/layui/css/layui.css"%> >
</head>
<body>
<%--action=<%=path+"/uploadServlet"%>--%>
<form class="layui-form" onsubmit="return false" enctype="multipart/form-data" accept-charset="UTF-8">
	<div id="upload">
		<%--		<form class="layui-form" action="">--%>
		<input type="hidden" name="username" value="${username}">
		<div class="layui-form-item">
			<label class="layui-form-label">文档标题:</label>
			<div class="layui-input-block">
				<input type="text" name="docname" required lay-verify="required" id="docname" placeholder="请输入文档标题" autocomplete="off"
				       class="layui-input">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">文档简介:</label>
			<div class="layui-input-block">
				<input type="text" name="docintro" required lay-verify="required" id="docintro" placeholder="请输入文档简介" autocomplete="off"
				       class="layui-input">
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label" style="width: 110px">请选择上传文档:</label>
			<button type="button" class="layui-btn" id="uploadbutton">

				<i class="layui-icon">&#xe67c;</i>浏览
			</button>
<%--			<input class="layui-btn" type="file" name="fileact">--%>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">下载积分:</label>
			<div class="layui-input-block">
				<input type="text" name="downscore" required lay-verify="required" id="downscore" placeholder="请输入下载积分" autocomplete="off"
				       class="layui-input">
			</div>
		</div>

		<div class="layui-form-item">

			<div class="layui-input-block">
				<button class="layui-btn" lay-submit   lay-filter="formDemo" id="test9" >提交</button>

			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="<%=jspath+"jquery-3.4.1.js"%>"></script>
<script src="<%=path+"/layui/layui.js"%>" charset="utf-8"></script>
<script>
	<%--layui.use('form', function(){--%>
		var form = layui.form;
		var url="<%=path%>/backstage/fileupload.action";
	<%--	//监听提交--%>
	<%--	form.on('submit(formDemo)', function(data){--%>
	<%--		alert(url);--%>
	<%--		//layer.msg(JSON.stringify(data.field));--%>
	<%--			$.ajax({--%>
	<%--				url:url,--%>
	<%--				type:'post',--%>
	<%--				data:data.field,--%>
	<%--				// headers: {--%>
	<%--				// 	'Content-Type': 'multipart/form-data'--%>
	<%--				// },--%>
	<%--				beforeSend:function () {--%>
	<%--					this.layerIndex = layer.load(0, { shade: [0.5, '#393D49'] });--%>
	<%--				},--%>
	<%--				success:function(data){--%>
	<%--					if(data === 'error'){--%>
	<%--						layer.msg(data.msg,{icon: 5});//失败的表情--%>

	<%--					}else if(data === 'success'){--%>
	<%--						layer.msg(data.msg, {--%>
	<%--							icon: 6,//成功的表情--%>
	<%--							time: 1000 //1秒关闭（如果不配置，默认是3秒）--%>
	<%--						}, function(){--%>
	<%--							location.reload();--%>
	<%--						});--%>
	<%--					}--%>
	<%--				},--%>
	<%--				complete: function () {--%>
	<%--					layer.close(this.layerIndex);--%>
	<%--				},--%>
	<%--			});--%>
	<%--			return false;//阻止表单跳转--%>


	<%--	});--%>
	<%--});--%>
	layui.use(['upload','form'], function(){
		var upload = layui.upload;
		//执行实例
		var docname;
		var docintro;
		var downscore;
		var username="<%=userinf.getUsername()%>";
		var uploadInst = upload.render({

			elem: '#uploadbutton' //绑定元素
			,url: url //上传接口
			,accept:"file"
			,auto:false
			,bindAction: '#test9'
			,before:function (res) {
				docname=$("#docname").val();
				 docintro=$("#docintro").val();
				 downscore=$("#downscore").val();
				this.data={doctitle:docname,docintro:docintro,downscore:downscore,username:username};
			}
			,beforeSend:function () {
				this.layerIndex = layer.load(0, { shade: [0.5, '#393D49'] });
			}
			,done: function(res){
				//上传完毕回调
				if (res.code=="0"){
					layer.msg("上传成功", {
						icon: 6,//成功的表情
						time: 1000 //1秒关闭（如果不配置，默认是3秒）

					});

				}
			}
			,error: function(){
				//请求异常回调
			}
		});
	});
</script>
</body>
<%--</html>--%>
