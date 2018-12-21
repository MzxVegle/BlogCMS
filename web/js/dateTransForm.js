function dateTransform(strdate) {
    var datetime = new Date();
    datetime.setTime(strdate);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1;
    var date = datetime.getDate();
    var hour = datetime.getHours();
    /*对月 日 时 分 秒 小于10的时候的处理  --小于 10 时前面加 0*/
    if (month <= 9) {month = "0" + month;}
    if (date <= 9) {date = "0" + date}
    if (hour <= 9) {hour = "0" + hour;}
    var minute = datetime.getMinutes()
    if (minute <= 9) {minute = "0" + minute;}
    var second = datetime.getSeconds();
    if (second <= 9) {second = "0" + second;}
    return year + "-" + month + "-" + date + " " + hour + ":" + minute+ ":" + second;

}