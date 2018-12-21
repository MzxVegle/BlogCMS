function popovertips(obj,content,trigger,placement) {
    var contents = content;
    var triggers = trigger;
    var placements = placement;
    obj.popover({
        content:contents,
        trigger:triggers,
        placement:placements,
        html:true,
        container: 'body'
    });
    obj.popover("show");
    setTimeout(function () {
        obj.popover("hide");
    },5000);
    obj.on('hidden.bs.popover', function () {

        obj.popover("dispose");
    })



}