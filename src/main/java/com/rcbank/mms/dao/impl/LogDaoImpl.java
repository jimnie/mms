package com.rcbank.mms.dao.impl;

import com.rcbank.mms.dao.LogDao;
import com.rcbank.mms.entity.Log;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

@Repository("logDaoImpl")
public class LogDaoImpl extends BaseDaoImpl<Log, Long> implements LogDao {

    public void removeAll() {
        String jpql = "delete from Log log";
        entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).executeUpdate();
    }

}