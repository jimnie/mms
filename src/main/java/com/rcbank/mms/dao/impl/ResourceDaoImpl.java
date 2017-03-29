package com.rcbank.mms.dao.impl;

import com.rcbank.mms.dao.ResourceDao;
import com.rcbank.mms.entity.Resources;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

/**
 * Created by Wayne on 2015/7/12.
 */
@Repository("resourceDaoImpl")
public class ResourceDaoImpl extends BaseDaoImpl<Resources, Long> implements ResourceDao {

    public Resources findParents() {
        String jpql = "select resources from Resources resources where resources.parent is null ";
        return entityManager.createQuery(jpql, Resources.class).setFlushMode(FlushModeType
                .COMMIT).getSingleResult();
    }

    public boolean isAliasNameExists(String aliasName) {
        if (aliasName == null) {
            return false;
        }
        String jpql = "select count(*) from Resources resource where lower(resource.aliasName) = " +
                "lower(:aliasName)";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("aliasName", aliasName).getSingleResult();
        return count > 0;
    }

    @Override
    public Resources findSubnodes(String id) {
        String jpql = "select resources from Resources resources where resources.parent = :id ";
        return entityManager.createQuery(jpql, Resources.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("id", id).getSingleResult();
    }
}
