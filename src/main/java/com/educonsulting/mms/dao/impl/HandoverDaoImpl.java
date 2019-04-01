package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.HandoverDao;
import com.educonsulting.mms.entity.Handover;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

@Repository("handoverDaoImpl")
public class HandoverDaoImpl extends BaseDaoImpl<Handover, Long> implements HandoverDao {

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        String jpql = "select count(hd.serviceNo) from Handover hd where hd.serviceNo = :serviceNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getSingleResult();
        return count > 0;
    }
}
