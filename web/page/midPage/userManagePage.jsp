<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/10/1
  Time: 23:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
<script src="/js/pagination.js"></script>
</head>
<script>

    $(document).ready(function () {
        messagebox.closeEvent(function () {});
        getUserList(1,$("#searchName").val(),"uid","asc");
        if(timmer !=null){
            clearInterval(timmer);
            timmer =null;
        }
        $("#submitSearch").on("click",function () {
            getUserList(1,$("#searchName").val(),"uid","asc");
        });
        $("#searchName").on("input",function () {
            if($(this).val()==''){
                getUserList(1,$("#searchName").val(),"uid","asc");
            }
        });
        changeSort($("#sortId"),'uid');
        changeSort($("#sortRegTime"),'regtime');
        changeSort($("#sortUserName"),'usn');


    });
    function changeSort(obj,field) {
        obj.on("click",function () {
            $("[group]").not(obj).attr("flag",'asc');
            if(obj.attr("flag")=="asc"){
                getUserList(1,$("#searchName").val(),field,"desc")
                obj.attr("flag","desc");
            }else{
                getUserList(1,$("#searchName").val(),field,"asc");
                obj.attr("flag","asc");
            }
        })

    }


    function getUserList(pageNo,name,fields,sort) {
        var param = {pageNo:pageNo,name:name,fields:fields,sort:sort};
        console.log(param);
        $.ajax({
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            url:"/getUserList",
            type:"post",
            data:param,
            dataType:"json",
            timeout:10000,
            beforeSend:function(){
                $("body").append("<div id='backdrop' class='modal-backdrop fade show'>" +
                    "<div id='tips' class='offset-md-5' style='margin-top:15%'> <i class='fa fa-5x fa-refresh fa-spin'></i>" +
                    "<label>正在获取数据，请稍等...</label></div>" +
                    "</div>");
            },
            success:function (data) {
                var user = eval(data);
                var currentPageNo = user[user.length-1].currentPage;
                var totalPage = user[user.length-1].totalPage;
                generateUserTable(user,currentPageNo);
                pagination($("#paginationBar"),currentPageNo,totalPage);
                //  设置前一页事件
                $("#previous_btn").on("click",function () {
                    if(currentPageNo >1)
                        var previous = currentPageNo-1;
                        getUserList(previous,name,fields,sort);

                });
                $("#next_btn").on("click",function () {
                    if(currentPageNo<totalPage)
                        var nextPage = currentPageNo+1;
                        getUserList(nextPage,name,fields,sort);
                });
                $(".page").on("click",function () {

                    getUserList($(this).text(),name,fields,sort);
                });
                var backdrop = $("#backdrop");
                if(backdrop.length>0){
                    backdrop.remove();
                }

            },
            error:function () {
                var backdrop = $("#backdrop");

                if(backdrop.length>0){
                    backdrop.remove();
                }
                messagebox.show("body","提示","连接远程数据库失败！请检查网络后再尝试",true);
            }
        });

    }
    function toggleIcon(obj,beforeClassName,afterClassName) {
        if(obj.hasClass(beforeClassName)){
            obj.removeClass(beforeClassName);
            obj.addClass(afterClassName);
        }
    }



    function generateUserTable(data,currentPage) {

        var tbody = $("#tbody");
        tbody.html("");
        for(var index =0;index<data.length-1;index++){
            tbody.append("<tr>" +
                "<td>"+data[index].id+"</td>" +
                "<td class='usn'>"+data[index].username+"</td>" +
                "<td>"+data[index].password+"</td>"+
                "<td>"+data[index].gender+"</td>"+
                "<td>"+data[index].role.role_type+"</td>"+
                "<td>"+data[index].status.statusName+"</td>"+
                "<td>"+dateTransform(data[index].regtime.time)+"</td>"+
                "<td>" +
                "<button class='btn btn-success updateBtn' >修改</button>" +
                "<button class='btn btn-danger deleteBtn' >删除</button>" +
                "</td>"+
            "</tr>");
        }
        $("#table").slideDown(1000)
        $(".updateBtn").on("click",function () {
            var username = $(this).parents("tr").find(".usn").text();
            updatebtnclick(data,username,currentPage);
        })
        $(".deleteBtn").on("click",function () {
            var username = $(this).parents("tr").find(".usn").text();
            if(confirm("是否删除"+username+"?(请谨慎操作)")){
                $.post("/deleteUser","name="+username,function (result) {
                    if(Boolean(result) == true){
                        getUserList(currentPage,$("#searchName").val());
                    }else{
                        alert("删除失败！")
                    }
                })
            }
        })

    }




    function updatebtnclick(userList,username,currentPage) {
        var currentUserIndex;
        //  获取当前行的用户下标;
        for(var index in userList){
            if(userList[index].username == username){
                currentUserIndex = index;
            }
        }

        var updatePanel = new Msgbox();
        updatePanel.show("body","修改用户:"+userList[currentUserIndex].username,"",true,true);
        updatePanel.closeEvent(function () {});

        $(".modal-body").html("");
        var form = document.createElement("form");

        var usergroup  = document.createElement("div");
        usergroup.className = "input-group mb-5";
        usergroup.innerHTML = "<div class='input-group-prepend'>" +
            "<label for='username'  class='input-group-text'><i class='fa fa-user'></i></label>" +
            "</div>" +
            "<input id='username' class='form-control ' type='text' disabled value="+userList[currentUserIndex].username+">";

        form.appendChild(usergroup);


        // "<label for='password'  class='input-group-addon '><i class='fa fa-lock'></i></label>" +
        // "<input id='password' class='form-control'   type='text' disabled value="+userList[currentUserIndex].password+">" +
        // "<span class='input-group-btn'>" +
        // "<button id='changePwd' type='button' class='btn btn-default'>修改密码</button>" +
        // "</span>";
        var pwdgroup = document.createElement("div");
        pwdgroup.className = "input-group mb-5";
        pwdgroup.innerHTML = "<div class='input-group-prepend'>" +
            "<label for='password' class='input-group-text'><i class='fa fa-key'></i></label>" +
            "</div>" +
            "<input id='password' class='form-control' type='text' disabled value="+userList[currentUserIndex].password+">" +
            "<div class='input-group-append'>" +
            "<button id='changePwd' type='button' class='btn btn-primary'>修改密码</button>" +
            "</div>";

        form.appendChild(pwdgroup);

        var gendergroup = document.createElement("div");
        gendergroup.className = "form-group mb-5";
        gendergroup.innerHTML = "<div class='input-group-prepend'>" +
            "<label for='genderSelector'  class='input-group-text '><i class='fa fa-venus-mars '></i></label>" +
            "<select id='genderSelector'  class='custom-select' >" +
            "<option >男</option>" +
            "<option >女</option>"+
            "</select>" +
            "</div>";
        form.appendChild(gendergroup);

        var rolegroup = document.createElement("div");
        rolegroup.className = "form-group mb-5";
        rolegroup.innerHTML = "<div class='input-group-prepend'>" +
            "<label for='roleSelector'  class='input-group-text ' style='border-radius: 0'><i class='fa fa-vcard '></i></label>" +
            "<select id='roleSelector'  class='custom-select' >" +
            "<option >管理员</option>" +
            "<option >普通用户</option>"+
            "</select>"+
            "</div>" ;
        form.appendChild(rolegroup);

        var statusgroup = document.createElement("div");
        statusgroup.className = "form-group mb-5";
        statusgroup.innerHTML = "<div class='input-group-prepend'>" +
            "<label for='password'  class='input-group-text '><i class='fa fa-key '></i></label>" +
            "<select id='statusSelector'  class='custom-select' >" +
            "<option >已激活</option>" +
            "<option >未激活</option>"+
            "</select>" +
            "</div>";
        form.appendChild(statusgroup);



        $(".modal-body").append(form);
        $("#roleSelector").find("option:contains('"+userList[currentUserIndex].role.role_type+"')").attr("selected",true);
        $("#genderSelector").find("option:contains('"+userList[currentUserIndex].gender+"')").attr("selected",true);
        $("#statusSelector").find("option:contains('"+userList[currentUserIndex].status.statusName+"')").attr("selected",true);
        $("#changePwd").on("click",function x() {
            if(confirm("您确定要更改密码吗？")){
                $("#password").removeAttr("disabled");
                $("#password").select();
            }
        });
        //  调用更新函数
        update(currentPage);
    }


    function update(currentPageNo) {
        $("#confirm_button").on("click",function () {
            var username = $("#username").val();
            var password = $("#password").val();
            var gender = $("#genderSelector").val();
            var role = $("#roleSelector").val();
            var status = $("#statusSelector").val();
            var userStr = {
                "username":username,
                "password":password,
                "gender":gender,
                "role":role,
                "status":status
            };
            var updateUser = JSON.stringify(userStr);
            console.log(updateUser);
            $.ajax({
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                url:"/updateUser",
                type:"post",
                data:{"updateUser":updateUser},
                dataType:"text",
                timeout:10000,
                success:function (result) {
                    if(result =="true"){
                        messagebox.close();
                        setTimeout(function () {
                            getUserList(currentPageNo,$("#searchName").val(),"uid","asc");
                        },1000);
                        alert("修改成功！");
                    }else {
                        messagebox.close();
                        alert("您未做修改,或其他原因造成您的修改未能提交");
                    }
                }
            })
        })
    }
</script>
<style>
    button{
        margin-right: 10px;
    }
    .table th, .table td {
        text-align: center;
        vertical-align: middle!important;
    }
</style>
<body>
    <div id="advanceSearchFrame" class="mb-2" >
        <a href="#advanceSearch" class="mb-2" data-toggle="collapse">高级搜索  <span class="fa fa-angle-right fa-lg"></span></a>

            <div class="collapse" id="advanceSearch">
                <div class="dropdown-divider "></div>
                <div class="input-group input-group-sm col-4 mb-2 " style="margin-top: 3px">
                    <div class="input-group-prepend"><div class="input-group-text"><span >按用户名搜索:</span></div></div>
                    <input type="text" id="searchName" class="form-control">
                    <div class="input-group-append"><a href="#" class="input-group-text nav-link" id="submitSearch"><span class="fa fa-search"></span></a></div>
                </div>
            </div>
    </div>
    <div class="dropdown-divider "></div>
    <div id="table"  style="display: none">
        <table id="userTable"   class="table table-striped table-hover">
            <thead class="thead-light">
                <tr>
                    <th>ID <a href="#" class="fa fa-sort nav nav-link " group="sortGroup" id="sortId" flag="asc" style="color: #9c9c9c;margin: 0px;padding: 0px"></a></th>
                    <th>用户名 <a href="#" class="fa fa-sort nav nav-link " group="sortGroup" id="sortUserName" flag="asc" style="color: #9c9c9c;margin: 0px;padding: 0px"></a></th>
                    <th>密码</th>
                    <th>性别</th>
                    <th>权限</th>
                    <th>状态</th>
                    <th>注册时间 <a href="#" class="fa fa-sort nav nav-link " group="sortGroup" id="sortRegTime" flag="asc" style="color: #9c9c9c;margin: 0px;padding: 0px"></a></th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="tbody">

            </tbody>
        </table>
    </div>
    <div id="pagination" class="justify-content-center">
        <nav id="paginationBar" style="display: inline" aria-label="Page navigation">
        </nav>
    </div>
</body>
</html>
