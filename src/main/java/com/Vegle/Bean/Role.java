package com.Vegle.Bean;

import org.springframework.stereotype.Repository;

@Repository
public class Role {
    private int role_id;
    private String role_type;

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public String getRole_type() {
        return role_type;
    }

    public void setRole_type(String role_type) {
        this.role_type = role_type;
    }

    @Override
    public String toString() {
        return "Role{" +
                "role_id=" + role_id +
                ", role_type='" + role_type + '\'' +
                '}';
    }
}
