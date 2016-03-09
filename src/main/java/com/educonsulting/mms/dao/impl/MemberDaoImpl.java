package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.MemberDao;
import com.educonsulting.mms.entity.Member;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

/**
 * Created by Wayne on 2016/3/8.
 */
@Repository("memberDaoImpl")
public class MemberDaoImpl extends BaseDaoImpl<Member, String> implements MemberDao {

    @Override
    public boolean cartNoExists(String cardNo) {
        String jpql = "select count(member.cardNo) from Member member where member.cardNo = " +
                ":cardNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("cardNo", cardNo).getSingleResult();
        return count > 0;
    }
}
