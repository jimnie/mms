package com.educonsulting.mms.service.impl;

import com.educonsulting.mms.dao.MemberDao;
import com.educonsulting.mms.entity.Member;
import com.educonsulting.mms.service.MemberService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created by Wayne on 2016/3/8.
 */
@Service("memberServiceImpl")
public class MemberServiceImpl extends BaseServiceImpl<Member, String> implements MemberService {

    @Resource(name = "memberDaoImpl")
    private MemberDao memberDao;

    @Resource(name = "memberDaoImpl")
    public void setBaseDao(MemberDao memberDao) {
        super.setBaseDao(memberDao);
    }

    @Transactional(readOnly = true)
    public boolean cartNoExists(String cardNo) {
        return memberDao.cartNoExists(cardNo);
    }


}
