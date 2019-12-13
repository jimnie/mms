package com.educonsulting.mms.service;

import com.educonsulting.mms.entity.TempInf;

public interface TempInfService extends BaseService<TempInf, Long> {

    boolean isServiceNoExist(String serviceNo);

    TempInf findByServiceNo(String serviceNo);

    boolean isRfidNoExist(String rfid);

    TempInf findByRfidNo(String rfid);
}
