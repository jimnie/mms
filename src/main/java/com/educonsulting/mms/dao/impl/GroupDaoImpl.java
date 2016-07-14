package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.GroupDao;
import com.educonsulting.mms.entity.Group;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

/**
 * Created by Wayne on 2015/7/7.
 */
@Repository("groupDaoImpl")
public class GroupDaoImpl extends BaseDaoImpl<Group, Long> implements GroupDao {
    public Group findRoot() {
        String jpql = "select group from Group group where group.parent is null ";
        return entityManager.createQuery(jpql, Group.class).setFlushMode(FlushModeType.COMMIT)
                .getSingleResult();
    }

    public boolean isTagNameExists(String tag) {
        if (tag == null) {
            return false;
        }
        String jpql = "select count(*) from Group grp where lower(grp.tag) = lower(:tag)";
        Long count = entityManager.createQuery(jpql, Long.class)
                .setFlushMode(FlushModeType.COMMIT).setParameter("tag", tag).getSingleResult();
        return count > 0;
    }
}
