package com.Vegle.Utils;

import com.Vegle.Bean.Role;
import com.Vegle.Bean.Status;
import com.Vegle.Bean.User;
import com.Vegle.Dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class GenerateUser {
    @Autowired
    UserDao userDao;
    @Autowired
    User user;
    @Autowired
    Role role;
    @Autowired
    Status status;
    @Autowired
    TransFormDate formDate;
    public User generateUser(String username,String password,String gender,String roleType,String statusName,String date){
        int roleId = userDao.getUserRoleId(roleType);
        int statusId = userDao.getUserStatusId(statusName);

        user.setUsername(username);     //设置用户名
        user.setPassword(password);     //设置密码
        user.setGender(gender);     //设置性别

        role.setRole_type(roleType);    //设置用户权限名
        role.setRole_id(roleId);        //设置权限名ID
        user.setRole(role);

        status.setStatusId(statusId);
        status.setStatusName(statusName);
        user.setStatus(status);
        user.setRegtime(formDate.transFormDate(date));
        return user;
    }
}
