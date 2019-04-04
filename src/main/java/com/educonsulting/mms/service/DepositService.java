package com.educonsulting.mms.service;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Deposit;

import java.util.List;

public interface DepositService extends BaseService<Deposit, Long> {

    boolean isServiceNoExist(String serviceNo);

    Page<Deposit> findpage(Pageable pageable);

    List<Deposit> findDepositByServiceNo(String serviceNo);
}
