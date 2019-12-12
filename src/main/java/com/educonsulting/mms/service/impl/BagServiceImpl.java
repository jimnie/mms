package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.BagDao;
import com.educonsulting.mms.entity.Bag;
import com.educonsulting.mms.service.BagService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("bagServiceImpl")
public class BagServiceImpl extends BaseServiceImpl<Bag, Long> implements
        BagService {

    @Resource(name = "bagDaoImpl")
    private BagDao bagDao;

    @Resource(name = "bagDaoImpl")
    public void setBaseDao(BagDao bagDao) {
        super.setBaseDao(bagDao);
    }

    @Override
    public Page<Bag> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    public List<Bag> findBagByDpCertNo(String dpCertNo) {
        return bagDao.findBagByDpCertNo(dpCertNo);
    }

    @Override
    public List<Bag> findBagByDpCertNoAndStatus(String dpCertNo, Integer status) {
        return bagDao.findBagByDpCertNoAndStatus(dpCertNo, status);
    }

    @Override
    public List<Bag> findBagByServiceNo(String serviceNo) {
        return bagDao.findBagByServiceNo(serviceNo);
    }
}
