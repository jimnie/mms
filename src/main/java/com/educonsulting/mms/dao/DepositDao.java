package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Deposit;

import java.util.List;

public interface DepositDao extends BaseDao<Deposit, Long> {

    boolean isServiceNoExist(String serviceNo);

    List<Deposit> findDepositByServiceNo(String serviceNo);
}
