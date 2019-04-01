package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.ShelfDao;
import com.educonsulting.mms.entity.Shelf;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("shelfDaoImpl")
public class ShelfDaoImpl extends BaseDaoImpl<Shelf, Long> implements ShelfDao {

    @Override
    public List<Shelf> findIdelShelf(Integer status) {
        String jpql = "select shelf from Shelf shelf where shelf.status = :status";
        List<Shelf> resultList = entityManager.createQuery(jpql).setParameter("status", status).getResultList();
        return resultList;
    }

    @Override
    public Shelf findShelfByCode(String code) {
        String jpql = "select shelf from Shelf shelf where shelf.code = :code";
        return (Shelf) entityManager.createQuery(jpql).setParameter("code", code).getSingleResult();
    }

}
