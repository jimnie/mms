package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Log;

public interface LogDao extends BaseDao<Log, String> {

    void removeAll();

}