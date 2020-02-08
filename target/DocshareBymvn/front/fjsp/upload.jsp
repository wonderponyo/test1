<%--
  Created by IntelliJ IDEA.
  User: junlong
  Date: 2019-12-24
  Time: 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=application.getContextPath();
%>
<html>
<head>
    <title>文件上传</title>
    <link rel="stylesheet" href="layui/css/layui.css"/>
    <script src="layui/layui.js"></script>
</head>
<body>
<button type="button" class="layui-btn" id="test1">
    <i class="layui-icon">&#xe67c;</i>上传图片
</button>
<button class="layui-btn" id="test9" type="button">提交</button>
<script>
    layui.use('upload', function(){
        var upload = layui.upload;

        //执行实例
        var uploadInst = upload.render({
            elem: '#test1' //绑定元素
            ,url: '<%=path%>/uploadServlet?val=11' //上传接口
            ,accept:"file"
            ,auto:false
            ,bindAction: '#test9'
            ,done: function(res){
                //上传完毕回调

                alert("上传成功");
            }
            ,error: function(){
                //请求异常回调
            }
        });
    });
</script>
</body>
</html>
