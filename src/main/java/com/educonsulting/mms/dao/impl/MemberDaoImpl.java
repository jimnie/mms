package com.educonsulting.mms.dao.impl;

import com.educonsulting.mms.dao.MemberDao;
import com.educonsulting.mms.entity.Member;
import org.springframework.stereotype.Repository;

import javax.persistence.FlushModeType;

/**
 * Created by Wayne on 2016/3/8.
 */
@Repository("memberDaoImpl")
public class MemberDaoImpl extends BaseDaoImpl<Member, Long> implements MemberDao {

    @Override
    public boolean isCardNoAssigned(String cardNo) {
        String jpql = "select count(mem) from Member mem where mem.cardNo = " +
                ":cardNo";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType
                .COMMIT).setParameter("cardNo", cardNo).getSingleResult();
        return count > 0;
    }

    @Override
    public boolean isMobileExisted(String mobile) {
        String jpql = "select count(mem.mobile) from Member mem where mem.mobile = :mobile";
        Long count = entityManager.createQuery(jpql, Long.class).setFlushMode(FlushModeType.COMMIT)
                .setParameter("mobile", mobile).getSingleResult();
        return count > 0;
    }
}
