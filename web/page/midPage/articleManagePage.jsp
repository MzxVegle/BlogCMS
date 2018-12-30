<%--
  Created by IntelliJ IDEA.
  User: Vegle
  Date: 2018/11/23
  Time: 17:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="/js/pagination.js"></script>
    <script src="/js/typeChange.js"></script>
    <script src="/js/popovertips.js"></script>
    <script src="/js/wangEditor.min.js"></script>
    <script src="/js/createEditor.js"></script>
</head>
<script>
    $(document).ready(function () {
        getArticle(1);
    });
    function getArticle(pageNo,title,type,col,sort) {
        //  将参数列表封装成JSON方便ajax传送
        var param = {pageNo:pageNo,title:title,type:type,col:col,sort:sort};
        $.post("/getArticles",param,function (result) {
            $("tbody").html("");
            for(var i=0;i<result.length-1;i++){
                $("tbody").append("<tr>" +
                    "<td>"+result[i].articleId+"</td>" +
                    "<td>"+result[i].title+"</td>" +
                    "<td>"+result[i].articleType.typeName+"</td>" +
                    "<td>"+dateTransform(result[i].addTime.time)+"</td>" +
                    "<td>"+dateTransform(result[i].updateTime.time)+"</td>" +
                    "<td>" +
                    "<button class='btn btn-info' tag='seeReply' index="+i+" style='margin-right: 5px'>查看评论 <span class='badge badge-warning'>"+result[i].commentCount+"</span></button>"+
                    "</td>" +
                    "<td>" +
                    "<button class='btn btn-success' tag='seeArticle' index="+i+" style='margin-right: 5px'>查看</button>" +
                    "<button class='btn btn-primary' tag='updateArticle' index="+i+" style='margin-right: 5px'>修改</button>" +
                    "<button class='btn btn-danger' tag='deleteArtcile'  articleId="+result[i].articleId+">删除</button>" +
                    "</td>" +
                    "</tr>")

            }
            $("[tag='deleteArtcile']").on("click",function () {
                if(confirm("是否删除此文章？该文章下的所有评论都将会被删除(请谨慎操作)")){
                    var aid = $(this).attr("articleId");
                    $.post("/deleteArticle","aid="+aid,function (result) {
                        if (Boolean(result)){
                            alert("删除成功")
                            getArticle(pageNo,title,type,col,sort)
                        } else{
                            alert("删除失败")
                        }
                    })
                }
            });
            $("#articleTable").slideDown();
            //  通过标题查找点击事件
            $("#byTitle").on("click",function () {
                getArticle(pageNo,$("#searchName").val())
            });
            //  通过文章类型查找点击事件
            $("#byType").on("click",function () {
                getArticle(pageNo,null,$("#searchType").val())
            });
            //通过文章Id查找留言的点击事件
            $("[tag='seeReply']").on("click",function () {
                var articleId=result[$(this).attr("index")].articleId
                $("body").before("<div id='dialog'  title='查看评论' ></div>")
                $("#dialog").dialog({
                    height:400,
                    width:700,
                    position:{my:'center top',at:'center top',of:window},
                    show: {
                        effect: "blind",
                        duration: 1000
                    },
                    hide: {
                        effect: "blind",
                        duration: 1000
                    },
                    modal:true,
                    open:function(){
                        getComment(articleId)
                    },
                    close:function () {
                        $(this).remove();
                    }
                })
            });

            //  查看文章按钮的点击事件
            $("[tag='seeArticle']").on("click",function () {
                var viewBox = new Msgbox();
                viewBox.setmsgboxwidth();
                viewBox.show("body",result[$(this).attr("index")].title,base64ToUtf8(result[$(this).attr("index")].txt),true);
                $(".modal-content").css({
                    "width":"700px",
                    "left":"-80"
                });
                $(".modal-body").css({

                    "height":"700px"
                })
                $(".modal-body").addClass("pre-scrollable");
                viewBox.closeEvent(function(){})
            });
            
            //  修改文章按钮的点击事件
            $("[tag='updateArticle']").on("click",function () {
                var e;
                var currentArticle = result[$(this).attr("index")]
                var updatePanel = "<div id='updatePanel' title='修改文章'></div>"
                $("body").append(updatePanel);
                $("#updatePanel").dialog({
                    position:{my: "center", at: "top+100px", of: window},
                    width:800,
                    modal:true,
                    open:function(){
                        var html="<div class='input-group mb-3'>" +
                            "<div class='input-group-prepend'>" +
                            "<label class='input-group-text'>标题</label>" +
                            "</div>" +
                            "<input type='text' value="+currentArticle.title+" class='form-control' id='titleUpdateText' disabled style='margin-right:10px'>" +
                            "<button class='btn btn-primary input-group-append' id='titleBtn'>更改标题</button>" +
                            "</div>" +
                            "<div class='input-group'>" +
                            "<label class='input-group-text'>文章类型</label>" +
                            "<select class='custom-select' disabled id='typeUpdateSelector' style='margin-right:10px '>" +
                            "<option>----请选择一项</option>" +
                            "<option selected>"+currentArticle.articleType.typeName+"</option>" +
                            "</select>" +
                            "<button class='input-group-append btn btn-primary' id='typeBtn'>更改类型</button>" +
                            "</div>" +
                            "<div id='editorBar'></div>" +
                            "<div id='textArea' style='height: 300px;border: 1px solid #e9ecef'></div>"
                        $("#updatePanel").html(html);
                        var editor = createEditor("#editorBar","#textArea");
                        console.log(base64ToUtf8(currentArticle.txt))
                        editor.txt.html(base64ToUtf8(currentArticle.txt));
                        e = editor;
                        $("#titleBtn").on("click",function () {
                            if(confirm("是否修改标题？")){
                                $("#titleUpdateText").removeAttr("disabled")
                                $(this).remove();
                            }
                        })
                        $("#typeBtn").on("click",function () {
                            var typeSelect = $("#typeUpdateSelector");
                            if(confirm("是否更改分类？")){
                                typeSelect.removeAttr("disabled");
                                typeSelect.html("<option>---请选择一项</option>");
                                $(this).remove();
                                $.post("/getArticleType",function (result) {
                                    for(var i in result){
                                        typeSelect.append("<option>"+result[i].typeName+"</option>")
                                    }
                                    typesChange(result)

                                },'json')
                            }
                        })
                    },
                    close:function () {
                        $("#updatePanel").remove()
                    },
                    buttons:{
                        "关闭":function () {
                            $("#updatePanel").dialog("close");
                        },
                        "修改":function () {

                            if($("#titleUpdateText").val() == ""){
                                popovertips($("#titleUpdateText"),"标题不能为空","manual","right");
                                return;
                            }
                            if($("select:last").find("option:selected").index() == 0 ){
                                popovertips($("select:last").parent(),"请选择一项作为分类","manual","right");
                                return;
                            }

                            if($("#titleUpdateText").val() != "" && $("select:last").find("option:selected").index() != 0 ){
                                var updateArticle = {
                                    id:currentArticle.articleId,
                                    title:$("#titleUpdateText").val(),
                                    type:$("select:last").val(),
                                    txt:uft8ToBase64(e.txt.html()),
                                    updateTime:dateTransform(new Date().getTime())
                                };


                                $.post("/updateArticle","article="+JSON.stringify(updateArticle),function (result) {
                                    if(Boolean(result)){
                                        getArticle(pageNo,title,type,col,sort)
                                        alert("更新成功")
                                    }else{
                                        alert("更新失败")
                                    }
                                })
                            }
                        }
                    }
                })
            })
            var currentPageNo = result[result.length-1].currentPage;
            var totalPage = result[result.length-1].totalPage;
            pagination($("#paginationBar"),currentPageNo,totalPage);
            //  设置前一页事件
            $("#previous_btn").on("click",function () {
                if(currentPageNo >1)
                    var previousNo = currentPageNo-1;
                getArticle(previousNo,title,type,col,sort);
            });
            $("#next_btn").on("click",function () {
                if(currentPageNo<totalPage)
                    var nextPage = currentPageNo+1;
                getArticle(nextPage,title,type,col,sort);
            });
            $(".page").on("click",function () {
                getArticle($(this).text(),title,type,col,sort);
            });
        },'json');
    }

    function getComment(articleId) {
        $.post("/getCommentsById","articleId="+articleId,function (comments) {
            createReplyBoard(comments, $("#dialog"), articleId)
        },'json')
    }
    function createReplyBoard(comments,obj,articleId) {
        obj.html("");
        for(var i in comments){
            obj.append("<ul class='list-group  mb-3 nav' >" +
                "<li class='list-group-item list-group-item-primary' style='margin-top: 10px'>" +
                "<label style='margin: 0;padding: 0' >" +
                "<i style='color: rgba(113,113,113,0.62)'>"+(parseInt(i)+1)+"L   </i>" +
                "<label>" +
                transferredComment(comments[i])
                +"</label>"+
                "</label>" +
                "<div class='dropdown-divider'></div>" +
                "<i style='float: right;font-size: 13px;color: rgba(113,113,113,0.62);' >评论日期:"+dateTransform(comments[i].createTime.time)+"</i>" +
                "<label>评论内容：</label>" +
                "<i style='padding-left: 4px;display: block;margin-left: 45px;word-wrap: break-word;word-break: break-all;overflow: hidden' >"
                +base64ToUtf8(comments[i].content)+
                "</i>" +
                "<div style='font-size: 12px;float: right'>" +
                "<a href='#editor' onclick='reply(this)' style='margin-right: 5px' tag='reply' articleId="+articleId+" replyId="+(comments[i].replyUser == null?0:comments[i].replyUser.id)+" commentid="+comments[i].id+">" +
                "回复" +
                "</a>" +
                "<a href='#' tag='deleteReply' onclick='deleteReply(this)' articleId="+articleId+" commentid = "+comments[i].id+">删除</a>" +
                "</div>" +
                "<a href= '#"+comments[i].id+"' tag='collapse'  data-toggle='collapse' style='font-size: 13px'></a>" +
                "<div class='collapse show' id='"+comments[i].id+"'></div>" +
                "</li>" +
                "</ul>");
            if(comments[i].comments.length != 0){
                $("[tag = 'collapse']").html("" +
                    "展开还有<span class='badge badge-info' style='margin: 0 5px 0 5px'>"+comments[i].comments.length+"</span>条评论" +
                    "<span class='fa fa-angle-double-right' style='margin-left: 5px'></span>");
                $(".list-group-item:last").children(".collapse").css({
                    "margin-left":"30px"
                });
                createReplyBoard(comments[i].comments,$(".list-group-item:last").children(".collapse"),articleId);
            }
        }
    }
    function reply(replyButton) {
        var collapse = $(replyButton).parent().parent().children(".collapse");
        if($("#editor").length !=0){
            alert("还有一个评论未提交，请提交之后再回复");
            return;
        }
        if(!collapse.hasClass("show")){
            collapse.addClass("show")
        }

        collapse.prepend("<div id='editor'>" +
            "<div id='editorBar' ></div>" +
            "<div id='textArea' class='mb-2' style='border: 1px solid #c2c5c8;height: 100px;'></div>" +
            "<a href='#' class='btn btn-primary' id='commitReply'>提交</a>" +
            "</div>");
        var E = window.wangEditor;
        var editor = new E("#editorBar","#textArea");
        editor.customConfig.menus = [
            'emoticon'
        ]
        editor.customConfig.onblur = function () {
            if(editor.txt.text() == ""){
                $("#editor").remove();
            }
        }
        editor.create();
        editor.txt.html("")
        var t = setTimeout(function () {
            $("#textArea").children().focus();
        },10)
        $("#commitReply").on("click",function () {
            if(editor.txt.text() != ""){
                var currentUserId = ${sessionScope.user.id}
                var rid = parseInt($(replyButton).attr("replyId"))
                var commentId = parseInt($(replyButton).attr("commentId"))
                var articleId = parseInt($(replyButton).attr("articleId"))
                var createTime = dateTransform(new Date().getTime())

                var content = uft8ToBase64(editor.txt.html())
                var commentJson = {userId:currentUserId,replyId:rid,commentId:commentId,articleId:articleId,content:content,createTime:createTime}
                $.post("/insertComment","commentJson="+JSON.stringify(commentJson),function (result) {
                    if(Boolean(result)){
                        alert("回复成功");
                        getComment(articleId)
                    }else{
                        alert("回复失败");
                    }
                })
            }
        })

    }
    function deleteReply(deleteButton) {
        var commentId = $(deleteButton).attr("commentid");
        $("body").append("<div id='messageBox' title='是否删除该评论？'>" +
            "<p>注意！该操作会删除该评论，若该评论为一级评论（或存在多个子评论），该评论下的所有评论都将被删除</p>" +
            "</div>");
        $("#messageBox").dialog({
            modal:true,
            resizable:false,
            position:{ my: "center", at: "top+200px", of: window},
            buttons:{
                "确定":function () {
                    $.post("/deleteCommentById","commentId="+commentId,function (result) {
                        if(Boolean(result)== true){
                            getComment($(deleteButton).attr("articleId"))
                            alert("删除成功！");
                            $("#messageBox").dialog("close")
                        }else{
                            alert("删除失败！");
                            $("#messageBox").dialog("close");
                        }
                    })
                },
                "取消":function () {
                    $("#messageBox").dialog("close");
                }
            },
            close:function () {
                $("#messageBox").remove()
            }
        })

    }
    function transferredComment(comments) {
        var user = <%=session.getAttribute("user")%>
        var str;
        var commentUser = comments.commentUser.username == user.username?"我":comments.commentUser.username;
        if(comments.replyUser != null){
            replyUser = comments.replyUser.username == user.username?"我":comments.replyUser.username;
            str = commentUser + "       回复      " +replyUser;
        }else{
            str = "评论人:"+commentUser;
        }
        return str;
    }
</script>
<body>
<div class="" >
    <div id="advanceSearchFrame" class="mb-2" >
        <a href="#advanceSearch" class="mb-2" data-toggle="collapse">高级搜索  <span class="fa fa-angle-right fa-lg"></span></a>
        
        <div class="collapse " id="advanceSearch">
            <div class="dropdown-divider "></div>
            <div class="input-group input-group-sm col-4 mb-2 custom-control-inline" style="margin-top: 3px">
                <div class="input-group-prepend"><div class="input-group-text"><span >按标题搜索:</span></div></div>
                <input type="text" id="searchName" class="form-control">
                <div class="input-group-append">
                    <a href="#" class="input-group-text nav-link" id="byTitle"><span class="fa fa-search"></span></a>
                </div>
            </div>
            <div class="input-group input-group-sm col-4 mb-2 custom-control-inline" style="margin-top: 3px">
                <div class="input-group-prepend"><div class="input-group-text"><span >按分类搜索:</span></div></div>
                <input type="text" id="searchType" class="form-control">
                <div class="input-group-append">
                    <a href="#" class="input-group-text nav-link" id="byType"><span class="fa fa-search"></span></a>
                </div>
            </div>
        </div>
    </div>
    <div id="articleTable" style="display: none">
        <table cellpadding="10" style="text-align: center;padding: 5px" class="table table-striped table-condensed table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>文章标题</th>
                <th>文章类别</th>
                <th>添加时间</th>
                <th>更新时间</th>
                <th>评论</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>

</div>
<div id="pagination" class="justify-content-center">
    <nav id="paginationBar" aria-label="Page navigation">
    </nav>
</div>

</body>
</html>
