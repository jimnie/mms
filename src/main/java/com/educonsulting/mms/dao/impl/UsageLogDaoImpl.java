package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.UsageLogDao;
import com.educonsulting.mms.entity.UsageLog;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

@Repository("usageLogDaoImpl")
public class UsageLogDaoImpl extends BaseDaoImpl<UsageLog, String> implements UsageLogDao {

    public void removeAll() {
        String jpql = "delete from UsageLog log";
        entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).executeUpdate();
    }

}