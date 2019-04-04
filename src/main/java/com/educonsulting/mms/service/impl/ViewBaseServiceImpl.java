package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Order;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.ViewBaseDao;
import com.educonsulting.mms.service.ViewBaseService;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

public class ViewBaseServiceImpl<T extends Serializable> implements ViewBaseService<T> {

    private ViewBaseDao<T> viewBaseDao;

    public void setViewBaseDao(ViewBaseDao<T> viewBaseDao) {
        this.viewBaseDao = viewBaseDao;
    }

    @Transactional(readOnly = true)
    public List<T> findList(Integer count, List<Filter> filters, List<Order> orders) {
        return findList(null, count, filters, orders);
    }

    @Transactional(readOnly = true)
    public List<T> findList(Integer first, Integer count, List<Filter> filters, List<Order>
            orders) {
        return viewBaseDao.findList(first, count, filters, orders);
    }

    @Transactional(readOnly = true)
    public Page<T> findPage(Pageable pageable) {
        return viewBaseDao.findPage(pageable);
    }

    @Transactional(readOnly = true)
    public long count() {
        return count(new Filter[]{});
    }

    @Transactional(readOnly = true)
    public long count(Filter... filters) {
        return viewBaseDao.count(filters);
    }

    @Transactional(readOnly = true)
    public boolean exists(Filter... filters) {
        return viewBaseDao.count(filters) > 0;
    }
}
