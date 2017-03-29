package com.rcbank.mms.dao;

import com.rcbank.mms.entity.User;

public interface UserDao extends BaseDao<User, Long> {

    boolean usernameExists(String username);

    User findByUsername(String username);

}