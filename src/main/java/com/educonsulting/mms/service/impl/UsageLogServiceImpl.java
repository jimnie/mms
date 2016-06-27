package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.UsageLogDao;
import com.educonsulting.mms.entity.UsageLog;
import com.educonsulting.mms.service.UsageLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("usageLogServiceImpl")
public class UsageLogServiceImpl extends BaseServiceImpl<UsageLog, String> implements
        UsageLogService {

    @Resource(name = "usageLogDaoImpl")
    private UsageLogDao logDao;

    @Resource(name = "usageLogDaoImpl")
    public void setBaseDao(UsageLogDao logDao) {
        super.setBaseDao(logDao);
    }

    public void clear() {
        logDao.removeAll();
    }

}