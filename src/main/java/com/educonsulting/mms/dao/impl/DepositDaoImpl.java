package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.DepositDao;
import com.educonsulting.mms.entity.Deposit;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

@Repository("depositDaoImpl")
public class DepositDaoImpl extends BaseDaoImpl<Deposit, Long> implements DepositDao {

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        String jpql = "select count(dep.serviceNo) from Deposit dep where dep.serviceNo = :serviceNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getSingleResult();
        return count > 0;
    }
}
