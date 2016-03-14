package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.UserDao;
import com.educonsulting.mms.entity.User;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;
import javax.persistence.NoResultException;

@Repository("userDaoImpl")
public class UserDaoImpl extends BaseDaoImpl<User, String> implements UserDao {

    public boolean usernameExists(String username) {
        if (username == null) {
            return false;
        }
        String jpql = "select count(user.username) from User user where lower(user.username) = " +
                "lower" +
                "(:username)";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("username", username).getSingleResult();
        return count > 0;
    }

    public User findByUsername(String username) {
        if (username == null) {
            return null;
        }
        try {
            String jpql = "select user from User user where lower(user.username) = lower" +
                    "(:username)";
            return entityManager.createQuery(jpql, User.class).setFlushMode(FlushModeType.COMMIT)
                    .setParameter("username", username).getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

}