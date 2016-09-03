package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Area;

import java.util.List;

public interface AreaDao extends BaseDao<Area, Long> {

    List<Area> findRoots(Integer count);

    List<Area> getAresByParent(Long id);
}