package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Log;

public interface LogService extends BaseService<Log, Long> {

    void clear();

}