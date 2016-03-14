package com.educonsulting.mms.service;

import com.educonsulting.mms.Page;
import com.educonsulting.mms.Pageable;
import com.educonsulting.mms.entity.Member;

/**
 * Created by Wayne on 2016/3/7.
 */
public interface MemberService extends BaseService<Member, String> {

    boolean isCartNoAssigned(String cardNo);

    boolean isMobileExisted(String mobile);

    Page<Member> findPage(Pageable pageable);
}
