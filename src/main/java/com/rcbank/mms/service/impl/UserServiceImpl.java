package com.rcbank.mms.service.impl;

import com.rcbank.mms.Principal;
import com.rcbank.mms.dao.UserDao;
import com.rcbank.mms.entity.*;
import com.rcbank.mms.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service("userServiceImpl")
public class UserServiceImpl extends BaseServiceImpl<User, Long> implements UserService {

    @Resource(name = "userDaoImpl")
    private UserDao userDao;

    @Resource(name = "userDaoImpl")
    public void setBaseDao(UserDao userDao) {
        super.setBaseDao(userDao);
    }

    @Transactional(readOnly = true)
    public boolean usernameExists(String username) {
        return userDao.usernameExists(username);
    }

    @Transactional(readOnly = true)
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Transactional(readOnly = true)
    public List<String> findAuthorities(Long id) {
        List<String> authorities = new ArrayList<String>();
        User user = userDao.find(id);
        if (user != null) {
            for (Group group : user.getGroups()) {
                for (Role role : group.getRoles()) {
                    for (Resources resource : role.getResources()) {
                        for (Authority authority : resource.getAuthorities()) {
                            authorities.add(authority.getPerms());
                        }
                    }
                }
            }
        }
        return authorities;
    }

    @Transactional(readOnly = true)
    public boolean isAuthenticated() {
        Subject subject = SecurityUtils.getSubject();
        if (subject != null) {
            return subject.isAuthenticated();
        }
        return false;
    }

    @Transactional(readOnly = true)
    public User getCurrent() {
        Subject subject = SecurityUtils.getSubject();
        if (subject != null) {
            Principal principal = (Principal) subject.getPrincipal();
            if (principal != null) {
                return userDao.find(Long.valueOf(principal.getId()));
            }
        }
        return null;
    }

    @Transactional(readOnly = true)
    public String getCurrentUsername() {
        Subject subject = SecurityUtils.getSubject();
        if (subject != null) {
            Principal principal = (Principal) subject.getPrincipal();
            if (principal != null) {
                return principal.getUsername();
            }
        }
        return null;
    }

    @Override
    @Transactional
//	@CacheEvict(value = "authorization", allEntries = true)
    public void save(User user) {
        super.save(user);
    }

    @Override
    @Transactional
//	@CacheEvict(value = "authorization", allEntries = true)
    public User update(User user) {
        return super.update(user);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public User update(User user, String... ignoreProperties) {
        return super.update(user, ignoreProperties);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(Long id) {
        super.delete(id);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(Long... ids) {
        super.delete(ids);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void delete(User user) {
        super.delete(user);
    }

}