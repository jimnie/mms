package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Order;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.dao.RechargeLogDao;
import com.educonsulting.mms.entity.RechargeLog;
import com.educonsulting.mms.service.RechargeLogService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Wayne on 2016/5/24.
 */
@Service("rechargeLogServiceImpl")
public class RechargeLogServiceImpl extends BaseServiceImpl<RechargeLog, Long> implements
        RechargeLogService {

    @Resource(name = "rechargeLogDaoImpl")
    private RechargeLogDao rechargeLogDao;

    @Resource(name = "rechargeLogDaoImpl")
    public void setBaseDao(RechargeLogDao rechargeLogDao) {
        super.setBaseDao(rechargeLogDao);
    }

    @Override
    public void save(RechargeLog entity) {
        super.save(entity);
    }

    @Override
    public List<RechargeLog> findAll() {
        return super.findAll();
    }

    @Override
    public List<RechargeLog> findList(Long... longs) {
        return super.findList(longs);
    }

    @Override
    public List<RechargeLog> findList(Integer count, List<Filter> filters, List<Order> orders) {
        return super.findList(count, filters, orders);
    }

    @Override
    public List<RechargeLog> findList(Integer first, Integer count, List<Filter> filters,
                                      List<Order> orders) {
        return super.findList(first, count, filters, orders);
    }

    @Override
    public Page<RechargeLog> findPage(Pageable pageable) {
        return super.findPage(pageable);
    }

    @Override
    public long count() {
        return super.count();
    }

    @Override
    public long count(Filter... filters) {
        return super.count(filters);
    }
}
