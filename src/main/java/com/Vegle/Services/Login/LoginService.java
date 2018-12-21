package com.Vegle.Services.Login;

import javax.servlet.http.HttpSession;

 public interface LoginService {
    boolean checkLogin(String username, String password);
    boolean isLogin();
    boolean login(String username, String password);
    boolean logout();
}
