package com.educonsulting.mms.service;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Deposit;

public interface DepositService extends BaseService<Deposit, Long> {

    boolean isServiceNoExist(String serviceNo);

    Page<Deposit> findpage(Pageable pageable);
}
