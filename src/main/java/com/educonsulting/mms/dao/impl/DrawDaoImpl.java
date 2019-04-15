package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.DrawDao;
import com.educonsulting.mms.entity.Draw;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;
import java.util.List;

@Repository("drawDaoImpl")
public class DrawDaoImpl extends BaseDaoImpl<Draw, Long> implements DrawDao {

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        String jpql = "select count(dw.serviceNo) from Draw dw where dw.serviceNo = :serviceNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getSingleResult();
        return count > 0;
    }

    @Override
    public List<Draw> findDrawByServiceNo(String serviceNo) {
        String jpql = "select dw from Draw dw where dw.serviceNo = :serviceNo";
        List<Draw> list = entityManager.createQuery(jpql, Draw.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getResultList();
        return list;
    }
}
