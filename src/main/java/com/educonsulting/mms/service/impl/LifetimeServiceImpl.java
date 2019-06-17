package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.LifetimeDao;
import com.educonsulting.mms.entity.Lifetime;
import com.educonsulting.mms.service.LifetimeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("lifetimeServiceImpl")
public class LifetimeServiceImpl extends BaseServiceImpl<Lifetime, Long> implements LifetimeService {

    @Resource(name = "lifetimeDaoImpl")
    private LifetimeDao lifetimeDao;

    @Resource(name = "lifetimeDaoImpl")
    public void setBaseDao(LifetimeDao lifetimeDao) {
        super.setBaseDao(lifetimeDao);
    }

    @Override
    public Page<Lifetime> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    public List<Lifetime> findLifetimeByServiceNo(String serviceNo) {
        return lifetimeDao.findLifetimeByServiceNo(serviceNo);
    }

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        return lifetimeDao.isServiceNoExist(serviceNo);
    }
}
