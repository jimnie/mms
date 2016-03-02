package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.LogDao;
import com.educonsulting.mms.entity.Log;
import com.educonsulting.mms.service.LogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("logServiceImpl")
public class LogServiceImpl extends BaseServiceImpl<Log, String> implements LogService {

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