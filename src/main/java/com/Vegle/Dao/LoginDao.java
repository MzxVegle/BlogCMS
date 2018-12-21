package com.Vegle.Dao;

import com.Vegle.Bean.User;

public interface LoginDao {
    User checkUser(String usn, String pwd);
}
