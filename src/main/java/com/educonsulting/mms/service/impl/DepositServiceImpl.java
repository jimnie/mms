package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.DepositDao;
import com.educonsulting.mms.entity.Deposit;
import com.educonsulting.mms.service.DepositService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("depositServiceImpl")
public class DepositServiceImpl extends BaseServiceImpl<Deposit, Long> implements DepositService {

    @Resource(name = "depositDaoImpl")
    private DepositDao depositDao;

    @Resource(name = "depositDaoImpl")
    public void setBaseDao(DepositDao depositDao) {
        super.setBaseDao(depositDao);
    }

    @Override
    public boolean isServiceNoExist(String serviceNo) {
        return depositDao.isServiceNoExist(serviceNo);
    }

    @Override
    public Page<Deposit> findpage(Pageable pageable) {
        return super.findPage(pageable);
    }

}
