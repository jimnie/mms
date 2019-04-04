package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.DepositDao;
import com.educonsulting.mms.entity.Deposit;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;
import java.util.List;

@Repository("depositDaoImpl")
public class DepositDaoImpl extends BaseDaoImpl<Deposit, Long> implements DepositDao {

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        String jpql = "select count(dep.serviceNo) from Deposit dep where dep.serviceNo = :serviceNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getSingleResult();
        return count > 0;
    }

    @Override
    public List<Deposit> findDepositByServiceNo(String serviceNo) {
        String jpql = "select dep from Deposit dep where dep.serviceNo = :serviceNo";
        List<Deposit> list = entityManager.createQuery(jpql, Deposit.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getResultList();
        return list;
    }
}
