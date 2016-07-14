package com.educonsulting.mms.dao;

import com.educonsulting.mms.entity.Member;

/**
 * Created by Wayne on 2016/3/7.
 */
public interface MemberDao extends BaseDao<Member, Long> {

    boolean isCardNoAssigned(String cardNo);

    boolean isMobileExisted(String mobile);
}
