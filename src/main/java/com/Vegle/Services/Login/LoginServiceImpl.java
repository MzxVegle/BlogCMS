package com.Vegle.Services.Login;

import com.Vegle.Bean.User;
import com.Vegle.Dao.LoginDao;
import net.sf.json.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Service("loginServiceImpl")
public class LoginServiceImpl implements LoginService{
    @Autowired
    HttpSession session;
    @Autowired
    LoginDao loginDao;

    public boolean checkLogin(String username, String password) {
        User user = loginDao.checkUser(username,password);
        System.out.println(user);
        if(user!=null&&user.getRole().getRole_type().equals("管理员")&&user.getStatus().getStatusName().equals("已激活")){
            JSONObject jsonObject = JSONObject.fromObject(user);
            session.setAttribute("user",jsonObject);
            return true;

        }else{
            return false;
        }
    }

    public boolean isLogin(){
        LogManager.getLogger(this.getClass()).warn("正在进行用户状态检测...");
            try {
                if (session.getAttribute("user") != null) {
                    return true;
                }
                return false;
            }catch (Exception e){
                return false;
            }
        }


    public boolean login(String username, String password) {
        if(checkLogin(username,password)){
            return true;
        }
        return false;
    }

    public boolean logout() {

        if(isLogin()){
            session.removeAttribute("user");
                session.invalidate();
        }
        return false;
    }
}
