package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.service.ObjectDaoService;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Service("objectDaoServiceImpl")
public class ObjectDaoServiceImpl implements ObjectDaoService {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public EntityManager getEntityManager() {
        return this.entityManager;
    }
}
