package com.educonsulting.mms.dao;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Order;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;

import java.io.Serializable;
import java.util.List;

public interface ViewBaseDao<T extends Serializable> {

    List<T> findList(Integer first, Integer count, List<Filter> filters, List<Order> orders);

    Page<T> findPage(Pageable pageable);

    long count(Filter... filters);
}
