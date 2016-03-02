package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.ActDao;
import com.educonsulting.mms.entity.Act;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

/**
 * Created by Wayne on 2015/7/16.
 */
@Repository("actDaoImpl")
public class ActDaoImpl extends BaseDaoImpl<Act, String> implements ActDao {

    public boolean isAliasExists(String tag) {
        if (tag == null) {
            return false;
        }
        String jpql = "select count(*) from Act act where lower(act.enName) = lower(:tag)";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("tag", tag).getSingleResult();
        return count > 0;
    }

}
