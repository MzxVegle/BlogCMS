<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/10/17
  Time: 23:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="/js/wangEditor.min.js"></script>
    <script src="/js/popovertips.js"></script>
    <script src="/js/jquery.base64.js"></script>
    <script src="/js/CodeTranslation.js"></script>
    <script src="/js/typeChange.js"></script>
    <script src="/js/createEditor.js"></script>
</head>

<script>

    $(document).ready(function () {
       var editor = createEditor('#editorBar',"#editorTextarea");
        $.post("/getArticleType",function (data) {
            for(var index in data){
                $("#types").append("<option>"+data[index].typeName+"</option>");
            }
            typesChange(data);
            $("#mainEditor").fadeIn(1000);
            $("#btn1").on("click",function () {
                if($("select:last").find("option:selected").index() == 0 ){
                    popovertips($("select:last"),"请选择一项作为分类","manual","right");
                }
                if($("#title").val() == ""){
                    popovertips($("#title"),"请填写标题","manual","right");
                }

                if($("select:last").find("option:selected").index() != 0 & $("#title").val() != ""){
                    var article = {
                        title:$("#title").val(),
                        type:$("select:last").val(),
                        txt:uft8ToBase64(editor.txt.html()),
                        addTime:dateTransform(new Date().getTime()),
                        updateTime:dateTransform(new Date().getTime())
                    };

                    $.ajax({
                        contentType: "application/x-www-form-urlencoded;charset=utf-8",
                        type:"post",
                        data:"article="+JSON.stringify(article),
                        dataType:"text",
                        url:"/insertArticle",
                        success:function (result) {
                            var flag = Boolean(result);
                            if(flag == true){
                                alert("文章添加成功！")
                            }else{
                                alert("文章添加失败！");
                            }
                        }
                    })

                }

            })
        },'json');


    });




</script>
<body>
<div id="mainEditor" style="width: 1000px;display: none">
    <div class="form-group offset-3" style="width: 500px">
        <div class="input-group-prepend mb-4">
            <label class="input-group-text">标题<i style="color: red">*</i></label>
            <input class="form-control" id="title" type="text" placeholder="输入文章标题(必填)">
        </div>
        <div class="input-group-prepend " id="type">
            <label class="input-group-text" >类别<i style="color: red">*</i></label>
            <select class="custom-select" id="types">
                <option>---请选择一项</option>
            </select>
        </div>
    </div>
    <div id="editor" class="offset-1" >
        <div id="editorBar" class="offset-4" ></div>
        <%--<div class="dropdown-divider"></div>--%>
        <div id="editorTextarea" class="offset-4 " style="height: 300px;border: 1px solid #c2c5c8"></div>
    </div>

    <div class="offset-6" style="margin-top: 1%;">

        <button id="btn1" class="btn btn-primary" type="button">提交</button>
    </div>
</div>
</body>
</html>
