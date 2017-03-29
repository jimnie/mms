package com.rcbank.mms.service.impl;

import com.rcbank.mms.dao.LogDao;
import com.rcbank.mms.entity.Log;
import com.rcbank.mms.service.LogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("logServiceImpl")
public class LogServiceImpl extends BaseServiceImpl<Log, Long> implements
        LogService {

    @Resource(name = "logDaoImpl")
    private LogDao logDao;

    @Resource(name = "logDaoImpl")
    public void setBaseDao(LogDao logDao) {
        super.setBaseDao(logDao);
    }

    public void clear() {
        logDao.removeAll();
    }

}