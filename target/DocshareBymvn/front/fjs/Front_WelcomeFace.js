//
// layui.use(['form', 'layer', 'jquery','upload'], function () {
//     var layer = layui.layer;
//     var form = layui.form;
//     var $ = layui.jquery;
//     var upload = layui.upload;
//
//     //执行实例
//
// });

    $('#login').click(function () {
        var index = layer.open({
            type: 1,
            content: $('#loginface').html(),
            area: ['500px'],
            title: '前台登录页面',
            btn:['取消']

        })
        //form.render();
    });
    $('#register').click(function () {
        layer.open({
            type: 1,
            content: $('#registerface').html(),
            area: ['500px'],
            title: '前台注册页面',
            btn:['取消'],
            success:function () {
               // form.render();
            }
        });
    });

$('#uploadopen').click(function (data) {
    // var username=$("#userid");
    layer.open({
        type: 2,
        content:"front/fjsp/fileupload.jsp",
        area: ['700px','350px'],

        title: '文档上传',


    });
});

$('#personinf').click(function () {
    var username=$("#userid").val();

    $.ajax({
        type: "POST",
        url: "FrontServlet?methodName=showpersoninf",
        dataType: "text",
        data:{username:username},
        success: function (msg) {
                var msgob=JSON.parse(msg);
                $("#username").text(msgob.username);
            $("#sex").text(msgob.sex);
            $("#edu").text(msgob.education);
            $("#profes").text(msgob.profession);
            $("#tel").text(msgob.phone);
            $("#email").text(msgob.mail);
            layer.open({
                type: 1,
                content: $('#personinfoshow').html(),
                area: ['500px'],
                title: '我的信息',
                btn:['返回'],
                success:function () {
                    // form.render();
                }
            });
            }
        })


});


function clientlogin() {
    var path=$('#path').val();
    var account = $("#loginAccount").val();
    var password = $("#loginPassword").val();
    $.ajax({
        type: "POST",
        url: path+"/front/log.action",
        dataType: "text",
        data:{loginAccount:account,loginPassword:password},
        success: function (msg) {
            if (msg === "success") {
                alert("登录成功");
                window.parent.location.reload();
                // parent.document.location.href = "frontmain.jsp";
            } else {

                var index = layer.open({
                    type: 1,
                    content: $('#loginface').html(),
                    area: ['500px'],
                    title: '前台登录页面',
                    btn: ['取消']

                });
                alert("登录失败")
            }
        }
    })
}
function clientreg() {
    var path=$('#path').val();
    var username = $("#registerAccount").val();
    var pwd = $("#registerPassword").val();
    var registerPhone = $("#registerPhone").val();
    var registersexy = $("input[name='sexy']:checked").val();
    var education= $("#education").val();
    var profession=$("#profession").val();
    var phone=$("#phone").val();
    var mail=$("#mail").val();
    alert(path);
    $.ajax({
        type: "POST",
        url: path+"/front/reg.action",
        dataType: "text",
        data:{username:username,password:pwd,phone:registerPhone,sex:registersexy,education:education,profession:profession,phone:phone,mail:mail},
        success: function (msg) {

                alert("注册成功")

        }
    })
}

