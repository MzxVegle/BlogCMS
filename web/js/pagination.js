function pagination(obj,currentPage,totalPage) {

    obj.append(document.getElementById("paginationBar"));
    //
    obj.html(" <ul class='pagination  justify-content-center' >" +
        "                <li id='previous' class='page-item'>" +
        "                    <a href='#' class='page-link' id='previous_btn' aria-label='Previous'>" +
        "                        <span aria-hidden='true'>&laquo;</span>" +
        "                    </a>" +
        "                </li>" +
        "                <li id='next' class='page-item'>" +
        "                    <a href='#' class='page-link' id='next_btn' aria-label='Next'>" +
        "                        <span aria-hidden='true'>&raquo;</span>" +
        "                    </a>" +
        "                </li>" +
        "            </ul>");

    //  填充分页模块
    for(var i=0;i<totalPage;i++){
        var li = document.createElement("li");
        li.className = "page-item";
        var a = document.createElement("a");
        a.className = "page-link page";
        var previous = $("#previous");
        var next = $("#next");
        a.innerText = i+1;
        a.href = "#";
        li.appendChild(a);
        li.id = "page_"+a.innerText;

        $("#next").before(li);
        $("#page_"+currentPage).addClass("active");


        //  对前一页和后一页是否可用进行逻辑判断
        if(currentPage == 1){
            previous.addClass("disabled");

        }else{
            if(previous.hasClass("disabled")){
                previous.removeClass("disabled");
            }
        }
        if(totalPage == currentPage){

            next.addClass("disabled");
        }else{
            if(next.hasClass("disabled")){
                next.removeClass("disabled");
            }
        }
    }
}