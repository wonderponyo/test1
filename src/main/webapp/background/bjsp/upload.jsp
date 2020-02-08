
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path=application.getContextPath();
    String csspath = application.getContextPath()+"/background/bcss/";
    String jspath =  application.getContextPath()+"/background/bjs/";

%>
<html>
<head>
    <title>文件上传</title>
    <link rel="stylesheet" href="<%=path%>/layui/css/layui.css"/>
    <script src="<%=path%>/layui/layui.js"></script>
</head>
<body>
<button type="button" class="layui-btn" id="test1">
    <i class="layui-icon">&#xe67c;</i>上传图片
</button>
<script>
    layui.use('upload', function(){
        var upload = layui.upload;
        //执行实例
        var uploadInst = upload.render({
            elem: '#test1' //绑定元素
            ,url: '<%=path%>/BackServlet?methodName=upload' //上传接口
            ,accept:'file'
            ,done: function(res){
                //上传完毕回调
                alert(res.code);
            }
            ,error: function(){
                //请求异常回调
            }
        });
    });
</script>
</body>
</html>
