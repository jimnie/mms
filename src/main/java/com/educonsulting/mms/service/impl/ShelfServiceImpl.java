package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.ShelfDao;
import com.educonsulting.mms.entity.Shelf;
import com.educonsulting.mms.service.ShelfService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("shelfServiceImpl")
public class ShelfServiceImpl extends BaseServiceImpl<Shelf, Long> implements ShelfService {

    @Resource(name = "shelfDaoImpl")
    private ShelfDao shelfDao;


    @Resource(name = "shelfDaoImpl")
    public void setBaseDao(ShelfDao shelfDao) {
        super.setBaseDao(shelfDao);
    }

    @Override
    public List<Shelf> findIdelShelf(Integer status) {
        return shelfDao.findIdelShelf(status);
    }

    @Override
    public Shelf findShelfByCode(String code) {
        return shelfDao.findShelfByCode(code);
    }
}
