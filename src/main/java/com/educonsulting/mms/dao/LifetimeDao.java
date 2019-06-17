package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Lifetime;

import java.util.List;

public interface LifetimeDao extends BaseDao<Lifetime, Long> {

    boolean isServiceNoExist(String serviceNo);

    List<Lifetime> findLifetimeByServiceNo(String serviceNo);
}
