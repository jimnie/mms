package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Lifetime;

import java.util.List;

public interface LifetimeService extends BaseService<Lifetime, Long> {

    List<Lifetime> findLifetimeByServiceNo(String serviceNo);

    boolean isServiceNoExist(String serviceNo);

}
