package com.educonsulting.mms.service;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Member;
import com.educonsulting.mms.entity.RechargeLog;
import com.educonsulting.mms.entity.User;

/**
 * Created by Wayne on 2016/3/7.
 */
public interface MemberService extends BaseService<Member, Long> {

    boolean isCartNoAssigned(String cardNo);

    boolean isMobileExisted(String mobile);

    Page<Member> findpage(Pageable pageable);

    void update(Member member, User user, RechargeLog.Type type);

}
