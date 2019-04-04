package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.entity.DHMatch;
import com.educonsulting.mms.service.DHMatchService;
import com.educonsulting.mms.service.ObjectDaoService;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import java.util.List;

@Service("dhMatchServiceImpl")
public class DHMatchServiceImpl implements DHMatchService {

    @Resource(name = "objectDaoServiceImpl")
    private ObjectDaoService objectDaoService;

    @Override
    public List<DHMatch> findDHMatch(String serviceNo, String dpName) {
//        String jpql = "select df from DHMatch df where df.serviceNo = :serviceNo";
        String jpql = "select df from DHMatch df where df.dStatus = 0 and df.hStatus = 0";
        if (StringUtils.isNotEmpty(serviceNo)) {
            jpql += " and df.serviceNo = :serviceNo";
        }
        if (StringUtils.isNotEmpty(dpName)) {
            jpql += " and df.dpName = :dpName";
        }
        EntityManager entityManager = objectDaoService.getEntityManager();
        List<DHMatch> dhMatchList;
        if (StringUtils.isNotEmpty(serviceNo) && StringUtils.isNotEmpty(dpName)) {
            dhMatchList = entityManager.createQuery(jpql, DHMatch.class)
                    .setParameter("serviceNo", serviceNo)
                    .setParameter("dpName", dpName).getResultList();
        } else if (StringUtils.isNotEmpty(serviceNo) && StringUtils.isEmpty(dpName)) {
            dhMatchList = entityManager.createQuery(jpql, DHMatch.class)
                    .setParameter("serviceNo", serviceNo).getResultList();
        } else if (StringUtils.isNotEmpty(dpName) && StringUtils.isEmpty(serviceNo)) {
            dhMatchList = entityManager.createQuery(jpql, DHMatch.class)
                    .setParameter("dpName", dpName).getResultList();
        } else {
            dhMatchList = entityManager.createQuery(jpql, DHMatch.class).getResultList();
        }
        return dhMatchList;
    }
}
