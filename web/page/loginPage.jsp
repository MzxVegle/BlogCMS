<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/9/29
  Time: 1:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","No-cache");
  response.setDateHeader("Expires", -1);
  response.setHeader("Cache-Control", "No-store");
%>
<html>
  <head>
    <title>个人博客管理系统登陆</title>

    <link href="pic/login.ico" rel="icon" type="img/x-ico">
    <link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/popper.min.js"></script>

    <script src="../js/bootstrap.js"></script>
    <script src="../js/Msgbox.js"></script>
  </head>
  <style>
    body{
      background: url('../pic/bg.jpg') no-repeat;

      background-size: cover;
    }
    /*"Helvetica Neue", Helvetica, Arial, sans-serif*/
    .form-control{
      color: white;
    }
    .form-control::-moz-placeholder{
      color: white;
    }
  </style>
  <script>
    $(document).ready(function () {
        var messagebox = new Msgbox();
        $("#username").focus();
        messagebox.closeEvent(function () {

        });

        var login = $("#login").on("click",function () {

            var temp = this.innerHTML;
            if($("#username").val() == ""){
                $("#usnicon").data("data-toggle","tooltip");
                $("#usnicon").data("title","用户名不能为空");

                $("#usnicon").tooltip("show");
            }
            if($("#password").val() == ""){
                $("#pwdicon").data("data-toggle","tooltip");
                $("#pwdicon").data("title","密码不能为空");
                $("#pwdicon").tooltip("show");

            }else{$.ajax({
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                url:"/login",
                type:"post",
                data: $('#loginForm').serialize(),
                dataType:"text",
                timeout:10000,
                beforeSend:function(){
                    if(login.prop("disabled")==false){

                        login.html("<i class=\"fa fa-spinner fa-spin\"></i>正在登陆");
                        login.attr("disabled",true);
                    }
                },
                success:function (result) {
                    if(login.prop("disabled")==true){
                        login.attr("disabled",false);
                        login.html(temp)
                    }
                    if(result == "true"){

                        window.location.href = "/page?page=/cmsPage";
                    }else{
                        messagebox.show("main","提示","登陆失败！您的凭证错误、账号被禁用或您不是管理员，请联系管理员",true);

                    }
                },
                error:function () {
                    messagebox.show("main","提示","连接远程数据库失败！请检查网络后再尝试",true);
                    if(login.prop("disabled")==true){
                        login.attr("disabled",false);
                        login.html(temp)
                    }

                }
            })}

        })

    })



  </script>
  <body >
  <div class="container-fluid" id="main" >

          <div class="col-4 offset-4 card" style="position:absolute;top:25%;background-color: rgba(255,255,255,0.30);box-shadow: #272727 10px 10px 30px ">
              <h3  class="mb-5" style="margin-top: 25px;text-align: center;color: white;letter-spacing: 5px">博客管理系统登陆</h3>
              <form   id="loginForm" class="col-8 offset-2">
                <div class="input-group mb-5" id="username-group">
                  <div  id="usnicon" class="input-group-prepend" style="background-color: rgba(255,255,255,0.1)">
                    <span class="input-group-text">
                      <i class="fa fa-user-o"></i>
                    </span>
                  </div>
                  <input id="username" name="username" type="text" placeholder="请输入您的用户名" class="form-control" style="background-color: rgba(113,113,113,0.3)">
                </div>

                <div class="input-group mb-5" data-placement="bottom">
                  <div  id="pwdicon" class="input-group-prepend" style="background-color: rgba(255,255,255,0.1)">
                    <span class="input-group-text">
                      <i class="fa fa-lock"></i>
                    </span>
                  </div>
                  <input id="password" name="password" type="password" placeholder="请输入您的密码" class="form-control" style="background-color: rgba(113,113,113,0.3)">
                </div>

                <button id="login" type="button" class="btn  btn-danger  col-12" >
                  登陆
                  <i class="fa fa-arrow-right"></i>
                </button>
              </form>

            </div>




  </div>

  </body>
</html>
