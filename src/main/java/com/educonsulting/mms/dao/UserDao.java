package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.User;

public interface UserDao extends BaseDao<User, String> {

    boolean usernameExists(String username);

    User findByUsername(String username);

}