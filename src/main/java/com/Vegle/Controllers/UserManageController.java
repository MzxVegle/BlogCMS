package com.Vegle.Controllers;

import com.Vegle.Services.User.UserService;
import com.Vegle.Utils.AjaxPrintf;
import com.Vegle.Utils.Pagination;
import net.sf.json.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;

@Controller
public class UserManageController {
    Logger logger = LogManager.getLogger(this);
    @Autowired
    AjaxPrintf ajax;
    @Autowired
    Pagination pagination;
    @Autowired
    UserService userService;
    @RequestMapping("/getUserList")
    public void getUserList(int pageNo,String name,String fields,String sort) throws Exception {
        System.out.println("pageNo:"+pageNo+",name:"+name+",fields:"+fields+",sort:"+sort);

        ajax.printf(userService.getUsers(pageNo,name,fields,sort));
    }
    @RequestMapping("/updateUser")
    public void updateUser(HttpServletResponse response,String updateUser)throws Exception{
        JSONObject bean = JSONObject.fromObject(updateUser);
        boolean result = userService.updateUser(bean);
        ajax.printf(result);
    }
    @RequestMapping("/hasUser")
    public void hasUser(String username,HttpServletResponse response){

        boolean result = userService.hasUser(username);
        System.out.println(result);
        ajax.printf(result);
    }
    @RequestMapping("/insertUser")
    public void insertUser(HttpServletResponse response,String user)throws Exception{
        System.out.println(user);
        JSONObject userobj = JSONObject.fromObject(user);
        boolean result = userService.insertUser(userobj);
        ajax.printf(result);
    }
    @RequestMapping("/getUsersByName")
    public void getUsersByName(int pageNo,String name){
        System.out.println(name);
        ajax.printf(userService.getUsers(pageNo,name,"uid","desc"));
    }
    @RequestMapping("/deleteUser")
    public void deleteUser(String name){
        ajax.printf(userService.deleteUser(name));
    }
}
