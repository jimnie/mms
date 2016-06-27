package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.UsageLog;

public interface UsageLogService extends BaseService<UsageLog, String> {

    void clear();

}