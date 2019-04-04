package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.DHMatchDao;
import com.educonsulting.mms.entity.DHMatch;
import com.educonsulting.mms.service.DHMatchService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("dhMatchServiceImpl")
public class DHMatchServiceImpl extends ViewBaseServiceImpl<DHMatch> implements DHMatchService {

    @Resource(name = "dhMatchDaoImpl")
    private DHMatchDao dhMatchDao;

    @Resource(name = "dhMatchDaoImpl")
    private void setViewBaseDao(DHMatchDao dhMatchDao) {
        super.setViewBaseDao(dhMatchDao);
    }

    @Override
    public Page<DHMatch> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    public List<DHMatch> findDHMatch(String serviceNo, String dpName) {
        return null;
    }
}
