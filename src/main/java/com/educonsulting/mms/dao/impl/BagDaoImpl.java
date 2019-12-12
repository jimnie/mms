package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.BagDao;
import com.educonsulting.mms.entity.Bag;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;
import java.util.List;

@Repository("bagDaoImpl")
public class BagDaoImpl extends BaseDaoImpl<Bag, Long> implements BagDao {

    @Override
    public List<Bag> findBagByDpCertNoAndStatus(String dpCertNo, Integer status) {
        String jpql = "select bag from Bag bag where bag.dpCertNo = :dpCertNo and bag.status = :status";
        List<Bag> list = entityManager.createQuery(jpql, Bag.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("status", status)
                .setParameter("dpCertNo", dpCertNo).getResultList();
        return list;
    }

    @Override
    public List<Bag> findBagByDpCertNo(String dpCertNo) {
        String jpql = "select bag from Bag bag where bag.dpCertNo = :dpCertNo";
        List<Bag> list = entityManager.createQuery(jpql, Bag.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("dpCertNo", dpCertNo).getResultList();
        return list;
    }

    @Override
    public List<Bag> findBagByServiceNo(String serviceNo) {
        String jpql = "select bag from Bag bag where bag.serviceNo = :serviceNo";
        List<Bag> list = entityManager.createQuery(jpql, Bag.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getResultList();
        return list;
    }
}
