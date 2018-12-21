function uft8ToBase64(utf8) {
    return btoa(encodeURIComponent(utf8));
}
function base64ToUtf8(base64) {
    return decodeURIComponent(atob(base64));
}