package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.DesertAshesDao;
import com.educonsulting.mms.entity.DesertAshes;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;
import java.util.List;

@Repository("desertAshesDaoImpl")
public class DesertAshesDaoImpl extends BaseDaoImpl<DesertAshes, Long> implements DesertAshesDao {

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        String jpql = "select count(da.serviceNo) from DesertAshes da where da.serviceNo = :serviceNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getSingleResult();
        return count > 0;
    }

    @Override
    public List<DesertAshes> findDesertAshesByServiceNo(String serviceNo) {
        String jpql = "select da from DesertAshes da where da.serviceNo = :serviceNo";
        List<DesertAshes> list = entityManager.createQuery(jpql, DesertAshes.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("serviceNo", serviceNo).getResultList();
        return list;
    }
}
