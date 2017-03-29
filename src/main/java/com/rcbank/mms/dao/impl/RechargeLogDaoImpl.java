package com.rcbank.mms.dao.impl;

import com.rcbank.mms.dao.RechargeLogDao;
import com.rcbank.mms.entity.RechargeLog;
import org.springframework.stereotype.Repository;

/**
 * Created by Wayne on 2016/5/24.
 */
@Repository("rechargeLogDaoImpl")
public class RechargeLogDaoImpl extends BaseDaoImpl<RechargeLog, Long> implements RechargeLogDao {
}
