package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.DrawDao;
import com.educonsulting.mms.entity.Draw;
import com.educonsulting.mms.service.DrawService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("drawServiceImpl")
public class DrawServiceImpl extends BaseServiceImpl<Draw, Long> implements DrawService {

    @Resource(name = "drawDaoImpl")
    private DrawDao drawDao;

    @Resource(name = "drawDaoImpl")
    public void setBaseDao(DrawDao drawDao) {
        super.setBaseDao(drawDao);
    }
}
