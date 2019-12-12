package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.TempInfDao;
import com.educonsulting.mms.entity.TempInf;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

@Repository("tempInfDaoImpl")
public class TempInfDaoImpl extends BaseDaoImpl<TempInf, Long> implements TempInfDao {

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        String jpql = "select count(inf.serviceNo) from TempInf inf where inf.serviceNo = :serviceNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getSingleResult();
        return count > 0;
    }

    @Override
    public TempInf findByServiceNo(String serviceNo) {
        String jpql = "select inf from TempInf inf where inf.serviceNo = :serviceNo";
        return (TempInf) entityManager.createQuery(jpql).setParameter("serviceNo", serviceNo).getSingleResult();
    }
}
