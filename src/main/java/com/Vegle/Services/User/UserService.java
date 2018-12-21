package com.Vegle.Services.User;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public interface UserService {
    JSONArray getUsers(int pageNo,String name,String fields,String sort);
    boolean updateUser(JSONObject updateUser);
    boolean insertUser(JSONObject insertUser);
    boolean hasUser(String username);
    boolean deleteUser(String username);
}
