package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Handover;

public interface HandoverDao extends BaseDao<Handover, Long> {

    boolean isServiceNoExist(String serviceNo);
}
