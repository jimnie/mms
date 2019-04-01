package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.HandoverDao;
import com.educonsulting.mms.entity.Handover;
import com.educonsulting.mms.service.HandoverService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("handoverServiceImpl")
public class HandoverServiceImpl extends BaseServiceImpl<Handover, Long> implements HandoverService {

    @Resource(name = "handoverDaoImpl")
    private HandoverDao handoverDao;

    @Resource(name = "handoverDaoImpl")
    public void setBaseDao(HandoverDao handoverDao) {
        super.setBaseDao(handoverDao);
    }

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        return handoverDao.isServiceNoExist(serviceNo);
    }
}
