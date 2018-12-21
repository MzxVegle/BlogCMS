function createEditor(editorBarId,textareaId) {
    var E = window.wangEditor;
    var editor = new E(editorBarId,textareaId);
    editor.customConfig.uploadImgServer = '/uploadImg';
    editor.customConfig.uploadFileName = "myFileName";
    editor.customConfig.zIndex = 100;
    // 关闭粘贴样式的过滤
    editor.customConfig.pasteFilterStyle = true
    // 忽略粘贴内容中的图片
    editor.customConfig.pasteIgnoreImg = true

    editor.customConfig.uploadImgHooks = {
        success : function(xhr, editor, result) {
            console.log("上传成功"+result);
        },
        customInsert: function (insertImg, result, editor) {
            // 图片上传并返回结果，自定义插入图片的事件（而不是编辑器自动插入图片！！！）
            // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果
            var url = result.data;
            insertImg(url);
            //退格删除图片处理
            $("img").on("DOMNodeRemoved",function () {
                $.post("/deleteImg","url="+$(this).attr("src"));
            });
        }
    };
    editor.create();
    editor.txt.html("");

    return editor;
}