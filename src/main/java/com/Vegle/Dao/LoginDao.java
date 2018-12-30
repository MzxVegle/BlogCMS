package com.Vegle.Dao;

import com.Vegle.Bean.User;

public interface LoginDao {
    /**
     * 用于检查用户和密码是否存在的接口函数
     * @param usn
     * 指定的用户名
     * @param pwd
     * 指定的密码
     * @return
     * 返回一个用户，若用户存在则返回这个用户，若不存在则返回null
     */
    User checkUser(String usn, String pwd);
}
