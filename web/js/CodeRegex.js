
function CodeRegex() {
    this.passwordRegex=function (pwd) {
        var pattern = /^[a-zA-Z]\w{5,17}$/;
        return pattern.test(pwd);
    };
    this.usernameRegex = function (usn) {
        var pattern = /^[a-zA-Z][a-zA-Z0-9_]{4,15}$/;
        return pattern.test(usn);
    }
}
