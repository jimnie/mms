package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.Handover;

public interface HandoverService extends BaseService<Handover, Long> {

    boolean isServiceNoExist(String serviceNo);
}
