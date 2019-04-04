package com.educonsulting.mms.service;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Order;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;

import java.io.Serializable;
import java.util.List;

public interface ViewBaseService<T extends Serializable> {

    List<T> findList(Integer count, List<Filter> filters, List<Order> orders);

    List<T> findList(Integer first, Integer count, List<Filter> filters, List<Order> orders);

    Page<T> findPage(Pageable pageable);

    long count();

    long count(Filter... filters);

    boolean exists(Filter... filters);
}
