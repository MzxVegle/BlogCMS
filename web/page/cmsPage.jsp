<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/9/29
  Time: 18:46
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
    <title>个人博客管理系统</title>

    <script src="../js/jquery-3.3.1.min.js"></script>
    <link href="../css/bootstrap.css" rel="stylesheet" type="text/css">
    <link href="../css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="../css/jquery-ui.min.css" rel="stylesheet" type="text/css">

    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/jquery-ui.min.js"></script>
    <script src="../js/Msgbox.js"></script>
    <script src="../js/dateTransForm.js"></script>
    <script src="/js/jquery.base64.js"></script>
    <script src="/js/CodeTranslation.js"></script>

    <script src="/js/CodeRegex.js"></script>
</head>

<script>
    var timmer = null; //全局类型的计时器
    var messagebox = new Msgbox();  //全局类型的messagebox
    var codeRegex = new CodeRegex(); //全局类型的codeRegex
    $(document).ready(function () {
        generateNavBarTag();
        messagebox.closeEvent(function () {
            window.location.href = "/index";
        });
        isLogin();
        logout();



    });

    function generateNavBarTag() {
        $.post("/loadCmsNavBar","",function (navbarTag) {
            var navBar =$(".navbar-nav");
            for(var index in navbarTag){
                var node = navbarTag[index];
                var nodeChild = node.cmsNavBarList;
                //  创建一个列表并设置列表类
                var li = document.createElement("li");
                var navLink = document.createElement("a");
                li.appendChild(navLink);
                navBar.append(li);
                li.className = "nav-item ";
                navLink.className = "nav-link";
                navLink.href = "#";
                //当存在子节点的时候需要做的事情
                if(nodeChild.length!=0){
                    //  当子节点存在时候，需要新增一个下拉菜单的标签
                    li.classList.add("dropdown");
                    navLink.classList.add("dropdown-toggle") ;
                    navLink.innerHTML = node.nodeName+" <span class='caret'>";
                    navLink.setAttribute("data-toggle","dropdown");
                    //创建下拉列表
                    var dropdownMenu = document.createElement("div");
                    dropdownMenu.className = "dropdown-menu";
                    // 将下拉菜单放置到li中
                    li.appendChild(dropdownMenu);
                    for(var child in nodeChild){
                        var dropItem = document.createElement("a");
                        dropItem.className="dropdown-item";
                        dropItem.href = "#";
                        dropItem.innerHTML = nodeChild[child].nodeName;

                        dropItem.setAttribute("url",nodeChild[child].url);
                        dropItem.setAttribute("name","dropItem");
                        dropdownMenu.appendChild(dropItem);


                        // $("div").on("click","#dropItem-"+child,function (e) {
                        //     e.stopPropagation();
                        //     var index = $(this).attr("index");
                        //     alert(index);
                        //     var txt = $(this).text();
                        //     console.log(nodeChild[index]);
                        //     var url = nodeChild[index].url;
                        //     alert(url);
                        //     $("#panel").load("/page","page="+url);
                        // });
                        if(child<(nodeChild.length-1)){
                            //  在最后一个之前添加分隔符
                            dropdownMenu.innerHTML+="<div class='dropdown-divider'></div>"
                        }




                    }

                }
                else
                {
                    //  当不存在子节点需要做的事
                    navLink.innerHTML = node.nodeName;
                    navLink.classList.add("noneList");
                    navLink.setAttribute("url",node.url);
                    navLink.setAttribute("name","noneList");
                    var noneList = document.getElementsByName("noneList");
                    for(var n = 0;n<noneList.length;n++){
                        noneList[n].onclick = function () {
                            $("#panel").load("/page","page="+this.getAttribute("url"))
                        }
                    }

                }

            }
            var dropItems = document.getElementsByName("dropItem");
            for(var i=0;i<dropItems.length;i++){
                dropItems[i].onclick = function () {

                    $.post("/getBreadcrumbNavBar","name="+this.innerText,function (result) {
                        console.log(result);
                    //
                    // <li class="breadcrumb-item ">Home</li>
                    //         <li class="breadcrumb-item active">test</li>
                        $("#nowText").nextAll().remove();
                        for (var index = result.length-1;index>=0;index--){
                            $("#breadcrumb").append("<li class='breadcrumb-item'><label>"+ result[index].nodeName+"</label></li>");
                        }
                    },'json');
                    $("#panel").load("/page","page="+this.getAttribute("url"))

                }
            }
        },"json");
    }

    function logout() {
        $("#logout").click(function () {
            if(confirm("是否确定注销当前用户?")){
                $.post("/logout",function () {
                    window.location.href = "/index";
                });


            }
        });
    }
    function showRegPanel() {
        $("#userReg").on("click",function () {

            $("#panel").load("/page","page=/midPage/regPage");
        })
    }

    function isLogin() {
        $.post("/loginStatus",function (result) {
            if(result == "true"){
                var user = <%=session.getAttribute("user")%>
                $("#userlabel").html("欢迎您的登陆:"+user.username);

            }else{

                $("button").attr("disabled",true);
                $("a").click(function (e) {
                    messagebox.show("body","提示","您未登录或账户已注销！",true);
                    e.preventDefault();
                });
                messagebox.show("body","提示","您未登录或账户已注销！",true);
            }
        },"text");

    }



</script>
<style>
    .breadcrumb-item + .breadcrumb-item::before{
        content: ">";
    }
</style>
<body id="body" style="background-color: #ededed;">

        <nav class="navbar navbar-expand-sm bg-dark navbar-dark col-auto" style="border-radius:0px;">
            <div class="container">
                <div class="navbar-brand"><label >个人博客后台管理系统</label></div>

                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#target-menu">
                <span class="navbar-toggler-icon"></span>
                </button>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="target-menu">
                    <ul class="navbar-nav">
                    </ul>
                    <ul class="ml-auto" style="margin: 0px;padding: 0px">

                            <form class="form-inline" style="margin-bottom: 0;">
                                <label class="navbar-text" id="userlabel" style=""></label>

                                <a href="#"  id="logout" class="fa fa-power-off fa-2x nav-link text-danger" ></a>
                            </form>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>

    <div class="card col-10 offset-1" style="margin-top: 2%;margin-bottom:2%">

        <div class="card-body " id="panel" style="min-height: 70vh" >

        </div>

    </div>




        <%--<div id="panel" class="container"  style="margin-left:21%;padding-top: 5vh;background-color: white;height: 75%;width:auto;border-radius: 7px"></div>--%>
        <div class="card-footer bg-dark " style="text-align: center;color: white;">
            <div class="" >
                <ol class="breadcrumb text-dark bg-warning" id="breadcrumb" style="width: auto;height: 50px;margin:0px;text-align: center">
                    <label id="nowText">当前位置:&nbsp;</label>
                </ol>
            </div>
            <label class="">Copyright &copy; 2018 by Vegle. All rights reserved. </label>


        </div>
</body>
</html>
