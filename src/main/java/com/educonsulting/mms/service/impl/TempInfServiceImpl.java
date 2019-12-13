package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.TempInfDao;
import com.educonsulting.mms.entity.TempInf;
import com.educonsulting.mms.service.TempInfService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("tempInfServiceImpl")
public class TempInfServiceImpl extends BaseServiceImpl<TempInf, Long> implements TempInfService {

    @Resource(name = "tempInfDaoImpl")
    private TempInfDao tempInfDao;

    @Resource(name = "tempInfDaoImpl")
    public void setBaseDao(TempInfDao tempInfDao) {
        super.setBaseDao(tempInfDao);
    }

    @Override
    public void save(TempInf entity) {
        super.save(entity);
    }

    @Override
    public TempInf update(TempInf entity) {
        TempInf pInf = findByServiceNo(entity.getServiceNo());
        entity.setId(pInf.getId());
        return super.update(entity);
    }

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        return tempInfDao.isServiceNoExist(serviceNo);
    }

    @Override
    public TempInf findByServiceNo(String serviceNo) {
        return tempInfDao.findByServiceNo(serviceNo);
    }

    @Override
    public boolean isRfidNoExist(String rfid) {
        return tempInfDao.isRfidNoExist(rfid);
    }

    @Override
    public TempInf findByRfidNo(String rfid) {
        return tempInfDao.findByRfidNo(rfid);
    }
}
