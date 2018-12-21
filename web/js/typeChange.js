/**
 * @author Vegle
 * @param data
 * data为类型的JSON
 *
 * 该函数主要控制类型改变时的操作
 */
function typesChange(data) {

    $("select:last").on("change",function () {
        console.log($("select:last"));
        $(this).nextAll().remove();
        var selectedIndex = $(this).find("option:selected").index()-1;

        if(selectedIndex != -1){
            //若data里面的articleTyps不等于空，那么说明存在子节点，否则则不存在子节点
            if(data[selectedIndex].articleTypes.length != 0){
                $("select:last").after("<span class='fa fa-angle-right' style='margin: 10px'></span> <select class='custom-select'></select>");
                $("select:last").append("<option>---请选择一项</option>")
                for(var index in data[selectedIndex].articleTypes){
                    $("select:last").append("<option>"+data[selectedIndex].articleTypes[index].typeName+"</option>")
                }

                typesChange(data[selectedIndex].articleTypes);
            }else{
                return;
            }
        }

    });


}