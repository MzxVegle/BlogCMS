function uft8ToBase64(utf8) {
    return $.base64.btoa(encodeURIComponent(utf8));
}
function base64ToUtf8(base64) {
    return decodeURIComponent($.base64.atob(base64,true));
}