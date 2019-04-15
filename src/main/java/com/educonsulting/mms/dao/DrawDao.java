package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Draw;

import java.util.List;

public interface DrawDao extends BaseDao<Draw, Long> {

    boolean isServiceNoExist(String serviceNo);

    List<Draw> findDrawByServiceNo(String serviceNo);
}
