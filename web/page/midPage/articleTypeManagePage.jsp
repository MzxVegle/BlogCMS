<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/12/2
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<style>
    ul li a:hover{
        color: rgba(0, 0, 0, 0.5);
    }
    ul li a{
        color: rgb(0, 0, 0);
    }
</style>
<script>
    $(document).ready(function () {
        getTypeItem();

    });
    /**
     * getTypeItem：获取文章类型，接收数据类型为JSON
     * */
    function getTypeItem() {
        $.post("/getArticleType",function (result) {
            createTypeItem(result,$("#typesItem"));
            $("#typesItem").slideDown();
        },'json')
    }


    /**  @function createTypeItem：
     * 为创建出文章类型列表设置的函数，主要目的是为了将JSON中的数据填充listGroup中
     * @param data
     * data为获取到的JSON对象
     * @param obj
     * obj为包裹列表的控件
     * */
    function createTypeItem(data,obj) {
        obj.html("");
        for(var i in data){
            obj.append("<ul class='list-group mb-3 nav'>" +
                "<li class='list-group-item' style='margin-top: 10px'>" +
                "<a href= '#"+data[i].articleTypeId+"' class='nav-link' data-toggle='collapse'  style='display: inline'>"+data[i].typeName+"</a>" +
                "<a href='#' onclick='deleteTypes(this)' class='mb-2 fa fa-times text-danger pull-right' ></a>" +
                "<a href='#newLabel' onclick='generateNewTypeTag(this)' class='mb-2 fa fa-plus pull-right text-secondary' ></a>" +
                "<div class='collapse' id='"+data[i].articleTypeId+"'></div>" +
                "</li>" +
                "</ul>");
            if(data[i].articleTypes.length != 0){
                $(".list-group-item:last").children("[data-toggle='collapse']").prepend("<span class='fa fa-chevron-right text-info' style='margin-right: 15px'></span>");
                $(".list-group-item:last").children(".collapse").css({
                    "margin-left":"30px"
                })
                createTypeItem(data[i].articleTypes,$(".list-group-item:last").children(".collapse"))
            }else{
                $(".list-group-item:last").children("[data-toggle='collapse']").prepend("<span class='fa fa-minus text-info' style='margin-right: 15px'></span>");
            }
        }
    }

    /**
     * @function deleteTypes
     * 为删除文章类型所设置的函数
     * @param button
     * button为点击的当前按钮
     */
    function deleteTypes(button) {
        var title = $(button).parent().children("a:first").text()
        if(confirm("是否删除"+title+"分类以及其分类下的其他分类（请谨慎操作）？")){
            $.post("/deleteTypes","typeName="+title,function (result) {
                if(Boolean(result)==true){

                    $(button).parent().parent().remove()
                    alert("删除成功！");
                }else{
                    alert("删除失败!")
                }
            })
        }
    }

    /**
     * @function addNewType
     * 添加新的文章类型的listGroup(主要是为了页面展示所用)
     * @param collapse
     * collapse为新增分类listGroup的位置
     */
    function addNewType(collapse) {
        if($("#newLabel").length != 0){
            alert("您有一个尚未保存的分类，请提交后在创建分类");
            return;
        }
        if(confirm("添加一个分类？")){
            collapse.append("<ul class='list-group mb-3 nav' >" +
                "<li class='list-group-item' style='margin-top: 10px'>" +
                "<a href= '#' class='nav-link' data-toggle='collapse' style='display: inline'></a>" +
                "<a href='#' onclick='deleteTypes(this)' class='mb-2 fa fa-times text-danger pull-right' ></a>" +
                "<a href='#newLabel' onclick='generateNewTypeTag(this)' class='mb-2 fa fa-plus pull-right' ></a>" +
                "<div class='form-group'>" +
                "<input type='text' class='form-control' id='newLabel'>" +
                "<a href='#' style='margin: 10px' onclick='setTagText(this)'  class='btn btn-success fa fa-check'></a>" +
                "<a href='#' style='margin: 10px'  onclick='delTag(this)' class='btn btn-danger fa fa-times'></a>" +
                "</div>" +

                "<div class='collapse' id=''></div>" +
                "</li>" +
                "</ul>");
            $("#newLabel").blur(function () {
                if($(this).val() == ""){
                    $(this).parent().parent().parent().remove();
                }
            })

        }

    }
    function generateNewTypeTag(button) {
        var collapse = $(button).next();
        addNewType(collapse);
        collapse.addClass("show")
        var t = setTimeout(function () {
            $("#newLabel").focus()
            if($("#newLabel").hasFocus() == true){
                clearTimeout(t);
                t = null;
            }

        },10)

    }

    /**
     * @function setTagText
     * 设置listGroup的名称
     * @param button
     * 当前点击的标签
     */
    function setTagText(button) {
        var typeTitle = $(button).parent().parent().children("a:first");
        var titleTextBox = $(button).prev();

        if(titleTextBox.val() == ""){
            $(button).next().after("<div class='alert alert-danger alert-dismissable fade show' >" +
                "<button type='button' class='close' data-dismiss='alert'>&times;</button>" +
                "<strong>请输入分类名称，分类名称不能为空！</strong>" +
                "</div>")
            var timeout = setTimeout(function () {
                $("[data-dismiss='alert']").trigger("click")
                clearTimeout(timeout)
                timeout=null;
            },5000)


        }else{
            var param;
            console.log($(button).parents());
            if($(button).parents()[4].length !=0 && $($(button).parents()[4]).is(".list-group-item")){
                param = {typeName:titleTextBox.val(),fatherName:$($(button).parents()[4]).children("a:first").text()}

            }else{
                param = {typeName:titleTextBox.val()};
            }
            insertType(param,$(button).parent());
            //typeTitle.html("<span class='fa fa-minus' style='margin-right: 15px'></span>"+titleTextBox.val());
        }

    }

    /**
     *
     * @param param
     * 提交参数
     * @param form
     * div所存在的form标签
     */
    function insertType(param,form) {
        $.post("/insertArticleType",param,function (result) {
            if(Boolean(result) == true){
                form.remove();
                alert("插入成功！")

            }
        })
    }

    /**
     * @function delTag
     * 删除整个listGroup，主要在新标签中的删除按钮中调用
     * @param button
     * 调用此事件的按钮
     */
    function delTag(button) {
        console.log($(button).parents());
        $(button).parents()[2].remove();
    }
</script>
<style>
    #addMain{
        color: rgba(0,0,0,0.21)
    }
    #addMain:hover{
        color: rgba(0, 0, 0, 0.51)
    }
</style>
<body>

        <a href="#newLabel" class="fa fa-plus fa-3x nav-link pull-right" id="addMain" style="" onclick="generateNewTypeTag(this)"></a>

    <div id="typesItem" style="margin-top: 65px;background-color: white;width: auto;height: auto;display: none">

    </div>
</body>
</html>
