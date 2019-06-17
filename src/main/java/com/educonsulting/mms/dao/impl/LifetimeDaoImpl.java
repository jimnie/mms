package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.LifetimeDao;
import com.educonsulting.mms.entity.Lifetime;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;
import java.util.List;

@Repository("lifetimeDaoImpl")
public class LifetimeDaoImpl extends BaseDaoImpl<Lifetime, Long> implements LifetimeDao {

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        String jpql = "select count(lt.serviceNo) from Lifetime lt where lt.serviceNo = :serviceNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getSingleResult();
        return count > 0;
    }

    @Override
    public List<Lifetime> findLifetimeByServiceNo(String serviceNo) {
        String jpql = "select lt from Lifetime lt where lt.serviceNo = :serviceNo";
        List<Lifetime> list = entityManager.createQuery(jpql, Lifetime.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getResultList();
        return list;
    }
}
