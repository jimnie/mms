package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.LogDao;
import com.educonsulting.mms.entity.Log;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

@Repository("logDaoImpl")
public class LogDaoImpl extends BaseDaoImpl<Log, String> implements LogDao {

    public void removeAll() {
        String jpql = "delete from Log log";
        entityManager.createQuery(jpql).setFlushMode(FlushModeType.COMMIT).executeUpdate();
    }

}