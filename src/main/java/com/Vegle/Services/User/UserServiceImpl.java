package com.Vegle.Services.User;

import com.Vegle.Bean.Role;
import com.Vegle.Bean.Status;
import com.Vegle.Bean.User;
import com.Vegle.Dao.UserDao;
import com.Vegle.Utils.GenerateUser;
import com.Vegle.Utils.Pagination;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
    @Autowired
    Pagination pagination;
    @Autowired
    Role role;
    @Autowired
    Status status;
    @Autowired
    private User user;
    @Autowired
    private UserDao userDao;
    @Autowired
    private GenerateUser generateUser;
    private JSONArray dispart(List data,int pageNo){
        JSONArray users = JSONArray.fromObject(pagination.disapart(data,3,pageNo));
        JSONObject jsonObject = new JSONObject();
        jsonObject.accumulate("totalPage",pagination.getTotalPage());
        jsonObject.accumulate("currentPage",pagination.getCurrentPageNo());
        users.add(jsonObject);
        return users;
    }
    public JSONArray getUsers(int pageNo,String name,String fields,String sort)  {

        return dispart(userDao.getUsers(name,fields,sort),pageNo);
    }

    public boolean hasUser(String username){

        return userDao.hasUser(username);
    }
    public boolean updateUser(JSONObject updateUser) {
        user = generateUser.generateUser(updateUser.getString("username"), updateUser.getString("password"), updateUser.getString("gender"), updateUser.getString("role"), updateUser.getString("status"),"");


        return userDao.updateUser(user);
    }

    public boolean insertUser(JSONObject insertUser) {
        user = generateUser.generateUser(insertUser.getString("username"), insertUser.getString("password"), insertUser.getString("gender"), insertUser.getString("role"), insertUser.getString("status"),insertUser.getString("regTime"));
        return userDao.insertUser(user);
    }

    public boolean deleteUser(String username) {
        return userDao.deleteUser(username);
    }
}
