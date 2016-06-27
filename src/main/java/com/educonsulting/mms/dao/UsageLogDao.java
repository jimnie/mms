package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.UsageLog;

public interface UsageLogDao extends BaseDao<UsageLog, String> {

    void removeAll();

}