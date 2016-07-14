package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.RoleDao;
import com.educonsulting.mms.entity.Role;
import com.educonsulting.mms.service.RoleService;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service("roleServiceImpl")
public class RoleServiceImpl extends BaseServiceImpl<Role, Long> implements RoleService {

    @Resource(name = "roleDaoImpl")
    private RoleDao roleDao;

    @Resource(name = "roleDaoImpl")
    public void setBaseDao(RoleDao roleDao) {
        super.setBaseDao(roleDao);
    }

    @Transactional
    public boolean isTagNameExists(String tag) {
        return roleDao.isTagNameExists(tag);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public void save(Role role) {
        super.save(role);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public Role update(Role role) {
        return super.update(role);
    }

    @Override
    @Transactional
    @CacheEvict(value = "authorization", allEntries = true)
    public Role update(Role role, String... ignoreProperties) {
        return super.update(role, ignoreProperties);
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
    public void delete(Role role) {
        super.delete(role);
    }

}