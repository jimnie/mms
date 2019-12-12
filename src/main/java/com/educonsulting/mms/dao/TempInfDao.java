package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.TempInf;

public interface TempInfDao extends BaseDao<TempInf, Long> {

    boolean isServiceNoExist(String serviceNo);

    TempInf findByServiceNo(String serviceNo);
}
