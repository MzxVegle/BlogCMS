package com.Vegle.Dao;

import com.Vegle.Bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
     List<User> getUsers(@Param("name") String name,@Param("field") String field,@Param("sort") String sort);
     boolean updateUser(User user);
     boolean hasUser(String username);
     int getUserRoleId(String roleType);
     int getUserStatusId(String statusName);
     boolean insertUser(User user);
     boolean deleteUser(@Param("name") String username);
}
