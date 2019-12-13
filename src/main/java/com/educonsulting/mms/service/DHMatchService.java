package com.educonsulting.mms.service;

import com.educonsulting.mms.Filter;
import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.DHMatch;

import java.util.List;

public interface DHMatchService extends ViewBaseService<DHMatch> {

    List<DHMatch> findDHMatch(String serviceNo, String dpName);

    Page<DHMatch> findPage(Pageable pageable);

    boolean exists(Filter... filters);
}
