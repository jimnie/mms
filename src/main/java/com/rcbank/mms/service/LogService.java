package com.rcbank.mms.service;

import com.rcbank.mms.entity.Log;

public interface LogService extends BaseService<Log, Long> {

    void clear();

}