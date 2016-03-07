package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Area;

import java.util.List;

public interface AreaService extends BaseService<Area, Long> {

    List<Area> findRoots();

    List<Area> findRoots(Integer count);

}