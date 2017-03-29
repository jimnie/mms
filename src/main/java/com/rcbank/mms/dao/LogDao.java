package com.rcbank.mms.dao;

import com.rcbank.mms.entity.Log;

public interface LogDao extends BaseDao<Log, Long> {

    void removeAll();

}