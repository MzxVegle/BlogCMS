package com.Vegle.Controllers;

import com.Vegle.Services.Login.LoginService;
import com.Vegle.Utils.AjaxPrintf;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class LoginController {
    @Autowired
    AjaxPrintf ajax;
    @Autowired
    LoginService loginService;
    @RequestMapping("/login")
    public void login(HttpServletRequest request, HttpServletResponse response)throws Exception{
        Thread.sleep(2000); //模拟两秒延时
        ajax.printf(loginService.login(request.getParameter("username"), request.getParameter("password")));

    }
    @RequestMapping("/logout")
    public void logout(HttpServletResponse response)throws Exception{
        System.out.println("执行注销");
        ajax.printf(loginService.logout());
    }
    @RequestMapping("/loginStatus")
    public void loginStatus(HttpServletResponse response) throws IOException {
        ajax.printf(loginService.isLogin());
    }
}