<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/10/13
  Time: 13:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="/js/popovertips.js"></script>
</head>

<script>

    $(document).ready(function () {
        $("#regPanel").fadeIn(function () {
            timmer = setInterval(function () {
                $("#regTime").val(createRegTime());
            });

            register();
        });



    });
    function register() {
        var username = $("#username");
        var firstpwd = $("#firstpwd");
        var secondpwd = $("#secondpwd");
        var gender = $("#gender");
        var role = $("#role");
        var hasUser=false ;
        var status = $("#status");
        var time = $("#regTime");
        username.blur(function () {
            var hasUserTimmer = setTimeout(function () {
                 $.post("/hasUser","username="+username.val(),function (result) {
                    if(result == "true"){
                        hasUser=true;
                        popovertips(username,"用户名已经存在！","manual","right");
                    }else {
                        hasUser = false;
                    }
                    clearTimeout(hasUserTimmer);
                })
            },100);

        });

        $("#reg").on("click",function () {
            if(hasUser){
                popovertips(username,"用户名已经存在！","manual","right");
            }
            //  不正确的时候判定规则
            if(username.val() == ""){
                popovertips(username,"用户名不能为空","manual","right");
            }else if(codeRegex.usernameRegex(username.val()) == false){
                popovertips(username,"用户名不合法","manual","right");
            }
            if(firstpwd.val() == ""){
                popovertips(firstpwd,"密码不能为空","manual","right");

            }else if(codeRegex.passwordRegex(firstpwd.val())==false){
                    popovertips(firstpwd,"以字母开头，长度在6~18之间，只能包含字母、数字和下划线","manual","right");
            }
            if(secondpwd.val() != firstpwd.val()){
                popovertips(secondpwd,"第一次输入的密码和第二次输入的密码不相符","manual","right");
            }else if(secondpwd.val() == ""){
                popovertips(secondpwd,"确认密码不能为空","manual","right");
            }

            //正确的判定规则
            if(hasUser==false && username.val()!="" && codeRegex.usernameRegex(username.val()) && firstpwd.val()!="" && codeRegex.passwordRegex(firstpwd.val()) && firstpwd.val() == secondpwd.val()){
                var user = {
                  "username":username.val(),
                  "password":firstpwd.val(),
                  "gender":gender.val(),
                  "role":role.val(),
                  "status":status.val(),
                  "regTime":time.val()
                };
                $(".modal-body").css("align","center");
                var regViews =
                    "<div>" +
                    "<p>用户名:"+user.username+"</p>" +
                    "<p>密码:"+user.password+"</p>" +
                    "<p>性别:"+user.gender+"</p>" +
                    "<p>角色:"+user.role+"</p>" +
                    "<p>状态:"+user.status+"</p>" +
                    "</div>";
                messagebox.show("body","注册清单",regViews,true,true);
                messagebox.closeEvent(function () {
                })
                messagebox.confirmEvent(function () {
                    $.ajax({
                        contentType: "application/x-www-form-urlencoded; charset=utf-8",
                        url:"/insertUser",
                        type:"post",
                        data:"user="+JSON.stringify(user),
                        success:function (result) {
                            if(result){
                                alert("注册用户成功！");
                            }
                        }
                    })
                })
            }


        })
    }


    function createRegTime() {
        var datetime = new Date();
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1;
        var date = datetime.getDate();
        var hour = datetime.getHours();
        /*对月 日 时 分 秒 小于10的时候的处理  --小于 10 时前面加 0*/
        if (month <= 9) {month = "0" + month;}
        if (date <= 9) {date = "0" + date}
        if (hour <= 9) {hour = "0" + hour;}
        var minute = datetime.getMinutes();
        if (minute <= 9) {minute = "0" + minute;}
        var second = datetime.getSeconds();
        if (second <= 9) {second = "0" + second;}
        return year + "-" + month + "-" + date + " " + hour + ":" + minute+ ":" + second;

    }
</script>
<style>
    button{
        margin-right: 10px;
    }
.popover-body{
    background-color:darkred ;
    color: white;
}
.bs-popover-right .arrow::after,.bs-popover-auto[x-placement^="right"] .arrow::after{
    border-right-color:darkred ;
}
</style>
<body>
<form>
    <div id="regPanel" class="card offset-3 col-6" style="padding: 0px;display: none">
        <div class="card-header " style="text-align: center;letter-spacing: 5px;">
            <h3 class="card-title">用户注册</h3>
        </div>
        <div class="card-body" >
            <div class="input-group mb-4">
                <div class="input-group-prepend">
                    <span class="input-group-text" ><i class="fa fa-user"></i></span>
                </div>
                <input type="text" class="form-control" id="username"  placeholder="请输入用户名(字母开头，允许5-16字节，允许字母数字下划线)">
            </div>
            <div class="input-group mb-4">
                <div class="input-group-prepend">
                    <span class="input-group-text" ><i class="fa fa-lock"></i></span>
                </div>

                <input type="password" id="firstpwd" class="form-control"  placeholder="请输入密码(以字母开头，长度在6~18之间，只能包含字母、数字和下划线)">
            </div>

            <div class="input-group mb-4">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                </div>
                <input type="password" id="secondpwd" class="form-control" placeholder="请确认密码(必须与第一次输入的密码匹配)">
            </div>
            <div class="form-group mb-4">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-venus-mars"></i></span>
                    <select id="gender" class="custom-select">
                        <option>男</option>
                        <option>女</option>
                    </select>
                </div>
            </div>

            <div class="form-group mb-4">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class='fa fa-vcard '></i></span>
                    <select id="role" class="custom-select">
                        <option>管理员</option>
                        <option>普通用户</option>
                    </select>
                </div>

            </div>

            <div class="form-group mb-4">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class='fa fa-key '></i></span>
                    <select id="status" class="custom-select">
                        <option>未激活</option>
                        <option>已激活</option>
                    </select>
                </div>

            </div>

            <div class="input-group mb-4">
                <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                </div>
                <input type="text" id="regTime" class="form-control" style="text-align: center" disabled>
            </div>

        </div>
        <div class="card-footer">
            <div class="offset-4" style="">

                <button type="reset" class="btn btn-danger " style="margin-right: 20%">清空内容</button>
                <button type="button" class="btn btn-success" style="" id="reg">注册用户</button>
            </div>


        </div>
    </div>
</form>
</body>
</html>
