package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.AreaDao;
import com.educonsulting.mms.entity.Area;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;
import javax.persistence.TypedQuery;
import java.util.List;

@Repository("areaDaoImpl")
public class AreaDaoImpl extends BaseDaoImpl<Area, Long> implements AreaDao {

    public List<Area> findRoots(Integer count) {
        String jpql = "select area from Area area where area.parent is null order by area.order " +
                "asc";
        TypedQuery<Area> query = entityManager.createQuery(jpql, Area.class).setFlushMode
                (FlushModeType.COMMIT);
        if (count != null) {
            query.setMaxResults(count);
        }
        return query.getResultList();
    }

}