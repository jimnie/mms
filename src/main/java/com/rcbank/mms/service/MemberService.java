package com.rcbank.mms.service;

import com.rcbank.mms.Page;
import com.rcbank.mms.Pageable;
import com.rcbank.mms.entity.Member;
import com.rcbank.mms.entity.RechargeLog;
import com.rcbank.mms.entity.User;

/**
 * Created by Wayne on 2016/3/7.
 */
public interface MemberService extends BaseService<Member, Long> {

    boolean isCartNoAssigned(String cardNo);

    boolean isMobileExisted(String mobile);

    Page<Member> findPage(Pageable pageable);

    void update(Member member, User user, RechargeLog.Type type);

}
