package com.rcbank.mms.dao.impl;

import com.rcbank.mms.Filter;
import com.rcbank.mms.Order;
import com.rcbank.mms.dao.DictionaryDao;
import com.rcbank.mms.entity.Dictionary;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Wayne on 2015/7/4.
 */
@Repository("dictionaryDaoImpl")
public class DictionaryDaoImpl extends BaseDaoImpl<Dictionary, Long> implements DictionaryDao {

    public List<Dictionary> findDict(String fieldName) {
        if (StringUtils.isEmpty(fieldName)) {
            return null;
        }

        Filter filter = new Filter("nickname", Filter.Operator.eq, fieldName);
        List<Filter> filters = new ArrayList<Filter>();
        filters.add(filter);

        Order order = new Order("sortNo", Order.Direction.asc);
        List<Order> orders = new ArrayList<Order>();
        orders.add(order);

        return findList(null, null, filters, orders);
    }
}
