package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.RoleDao;
import com.educonsulting.mms.entity.Role;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

@Repository("roleDaoImpl")
public class RoleDaoImpl extends BaseDaoImpl<Role, String> implements RoleDao {
    public boolean isTagNameExists(String tag) {
        if (tag == null) {
            return false;
        }
        String jpql = "select count(*) from Role role where lower(role.tag) = lower(:tag)";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("tag", tag).getSingleResult();
        return count > 0;
    }
}