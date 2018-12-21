function Msgbox(){
    //  1、创建模态框的基本元素

    var messagebox = document.createElement("div");
    var modaldialog = document.createElement("div");
    var modalcontent = document.createElement("div");
    var dialogHeader = document.createElement("div");
    var dialogBody = document.createElement("div");
    var dialogFooter = document.createElement("div");
    var footerGroup = document.createElement("div");
    var msg = document.createElement("p");
    var  msgtitle = document.createElement("h3");
    var confirmbtn = document.createElement("button");
    var closebtn = document.createElement("button");

    this.closeEvent = function (event) {
        closebtn.onclick = function () {
            event();
            $("#messagebox").modal('hide');

        };

    };
    this.close = function () {
        $("#messagebox").modal('hide');
    };
    this.confirmEvent = function (event) {
        confirmbtn.onclick = function () {
            event();
        };
    }
    this.setmsgboxwidth = function (width) {
        modaldialog.style.maxWidth = width+"px";
        dialogBody.style.overflow = "auto";
    }
    this.setmsgboxHeight = function (height) {
        dialogBody.style.maxHeight = height + "px";

        dialogBody.style.overflow = "auto";
    }
    this.show = function(showplace,title,message,hasCloseButton,hasOkButton){
        var  container = document.getElementById(showplace);
        //  主窗体
        messagebox.id = "messagebox";
        messagebox.className = "modal fade ";

        //  modal-dialog;
        modaldialog.className = "modal-dialog";
        messagebox.appendChild(modaldialog);

        modalcontent.className = "modal-content ";
        modaldialog.appendChild(modalcontent);
        //  header
        dialogHeader.className = "modal-header";

        dialogHeader.appendChild(msgtitle);
        modalcontent.appendChild(dialogHeader);
        //  body
        dialogBody.className = "modal-body";

        dialogBody.appendChild(msg);
        modalcontent.appendChild(dialogBody);
        //footer
        dialogFooter.className = "modal-footer";
        modalcontent.appendChild(dialogFooter);
        footerGroup.id = "footbuttonGroup";
        dialogFooter.appendChild(footerGroup);
        container.appendChild(messagebox);
        msgtitle.innerHTML = title;
        msg.innerHTML = message;
        //  按钮

        // 如果hasCloseButton为真则添加关闭按钮
        if(hasCloseButton){

            if(document.getElementById("close_button") == null){
                closebtn.innerText = "关闭";
                closebtn.id = "close_button";
                closebtn.className = "btn btn-danger ";

                footerGroup.appendChild(closebtn);
            }


        }
        if (hasOkButton){

            confirmbtn.innerText = "确定";
            confirmbtn.id = "confirm_button";
            confirmbtn.className = "btn btn-success ";


            footerGroup.appendChild(confirmbtn);


        }
        $("#messagebox").on("hidden.bs.modal",function () {
            if (document.getElementById("messagebox")!=null){
                container.removeChild(messagebox);

            }
        });
        $("#messagebox").modal('show');

    };


}