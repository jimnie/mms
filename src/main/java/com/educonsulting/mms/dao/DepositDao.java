package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Deposit;

public interface DepositDao extends BaseDao<Deposit, Long> {

    boolean isServiceNoExist(String serviceNo);
}
