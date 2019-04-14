package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.DesertAshes;

import java.util.List;

public interface DesertAshesDao extends BaseDao<DesertAshes, Long> {

    boolean isServiceNoExist(String serviceNo);

    List<DesertAshes> findDesertAshesByServiceNo(String serviceNo);
}
